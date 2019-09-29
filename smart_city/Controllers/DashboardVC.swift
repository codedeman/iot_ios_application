//
//  DashboardVC.swift
//  smart_city
//
//  Created by Apple on 9/17/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Charts


class DashboardVC: UIViewController {
    enum CardState {
        case expanded
        case collapsed
        
    }
   
    @IBOutlet weak var apiValue: UILabel!
    
    @IBOutlet weak var concurentStatus: UILabel!
    let data:[Int]  = [43, 53]
    let data2: [Double] = [1, 3, 5, 13, 17, 20]
    
    var forcastVC:ForeCastVC!
    var visualEffectView:UIVisualEffectView!
    var environment:Environment!
    
    var carHeight:CGFloat  = 600.5
    var cardHandelAreaHeight:CGFloat!
    
    var cardVisible =  false
    var nextState:CardState{
        
        return cardVisible ? .collapsed: .expanded
    }
    
    var runningAnimations  = [UIViewPropertyAnimator]()
    
    var animationPRogressWhenInterrupted:CGFloat = 0

    @IBOutlet weak var inforView: RoundedView!
    
    
    // simple line with custom x axis labels
    let xLabels: [Double] = [70, 69, 90, 20, 30, 40]
    let nameLabels:[String] = ["Temperature", "UV", "Rain", "Dust", "Humidity", "Co2"]
    
    var environtment:Environment!
    @IBOutlet weak var lineChart: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let  cardHandelAreaHeight1 = (self.view.bounds.height / self.view.bounds.width) * 200
        
        print("card height\(cardHandelAreaHeight1)")
        
        cardHandelAreaHeight  = cardHandelAreaHeight1-90
        setupCard(cardHandelAreaHeight1: cardHandelAreaHeight)

        self.forcastVC.view.layer.cornerRadius = 20
        
      
        
//        SocketService.instance.conectSocket { (sucess) in
//
//            print("haha \(sucess)")
//        }
//
//        SocketService.instance.conectSocket { (sucess) in
//
//            print("test \(sucess)")
//        }
        
//        EnvironmentService.instance.getPlaceIds { (place_id) in
//
//
//                for id in place_id{
//
//                    print("hello \(id)")
//
//                    SocketService.instance.getEnvironmentParameter(place_id: id) { (environment) in
//
//                            print("environent \(environment)")
//                    }
//
//                }
//        }
//
//        SocketService.instance.getNotify()
//
        
     
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        EnvironmentService.instance.findCurrentParameter { (sucess) in

            self.apiValue.text = "\(EnvironmentService.instance.aqiCaculation())"+"AQI"
            self.concurentStatus.text = "\(Thresholds.instance.aqiThreshold(value: EnvironmentService.instance.aqiCaculation()))"
     
        }
        EnvironmentService.instance.findAllParameter { (sucess) in
            
            self.setLineChart(name: self.nameLabels, values: EnvironmentService.instance.aqiCaculationLineChart())

        }
        
        
           
        
        

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        
    }
    
   
    func setLineChart(name:[String],values:[Double])  {
        
        var lineArray:[ChartDataEntry] = []
        
        for row in 0..<name.count{
            
            let data:ChartDataEntry = ChartDataEntry(x: Double(row), y: values[row])
            lineArray.append(data)
        }
        let lineDataSet:LineChartDataSet = LineChartDataSet(entries: lineArray, label: "Air Quality")
        
        let linedata:LineChartData? = LineChartData(dataSet: lineDataSet )
        
        lineChart.data = linedata
        

        lineChart.animate(xAxisDuration: 0.5, easingOption: .easeInSine)
        
    }
    
    
    
    func setupCard(cardHandelAreaHeight1:CGFloat)  {
        
        
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        forcastVC = ForeCastVC(nibName: "ForeCastVC", bundle: nil)
        
        self.addChild(forcastVC)
        self.view.addSubview(forcastVC.view)
        
        forcastVC.view.frame = CGRect(x: 0, y: self.view.frame.height -  cardHandelAreaHeight1, width: self.view.bounds.width, height: carHeight)
        
        forcastVC.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DashboardVC.handleCardTap(recognzier:)))

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DashboardVC.handleCardPan(recognizer:)))

        forcastVC.handleArea.addGestureRecognizer(tapGestureRecognizer)
        forcastVC.handleArea.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    
    func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.forcastVC.view.frame.origin.y = self.view.frame.height - self.carHeight
                case .collapsed:
                    self.forcastVC.view.frame.origin.y =  (self.view.frame.height - self.cardHandelAreaHeight)+20
                        
//                        self.view.frame.height - self.cardHandelAreaHeight;
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
        
            
        }
    }
    
    @objc func handleCardTap(recognzier:UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc func handleCardPan(recognizer:UIPanGestureRecognizer)  {
        
        
        switch recognizer.state {
        case .began:
            
            startInteractiveTransition(state: nextState, duration: 0.5)

            
        case .changed: break
            
            let translation = recognizer.translation(in: self.forcastVC.handleArea)

//        var fractionComplete = translation.y / carHeight - 200.0
//            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
        updateInteractiveTransition(fractionCompleted: 100.0)
        case .ended: break
//            continueInteractiveTransition()

        default:
            break
        }
    }
    func startInteractiveTransition(state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationPRogressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted:CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationPRogressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition (){
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
   
    

  

}

