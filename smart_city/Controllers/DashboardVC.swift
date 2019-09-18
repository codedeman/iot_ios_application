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
   
    let data:[Int]  = [43, 53]
    let data2: [Double] = [1, 3, 5, 13, 17, 20]
    
    var forcastVC:ForeCastVC!
    var visualEffectView:UIVisualEffectView!
    
    let carHeight:CGFloat  = 600
    let cardHandelAreaHeight:CGFloat = 65
    
    var cardVisible =  false
    var nextState:CardState{
        
        return cardVisible ? .collapsed: .expanded
    }
    
    var runningAnimations  = [UIViewPropertyAnimator]()
    
    var animationPRogressWhenInterrupted:CGFloat = 0
    
    
    
    @IBOutlet weak var inforView: RoundedView!
    
    // simple line with custom x axis labels
    let xLabels: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
    @IBOutlet weak var lineChart: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCard()
        
        setLineChart(name: xLabels, values: data2)

        

        // Do any additional setup after loading the view.
    }
    
    func setLineChart(name:[String],values:[Double])  {
        
        var lineArray:[ChartDataEntry] = []
        
        for row in 0..<name.count{
            
            let data:ChartDataEntry = ChartDataEntry(x: Double(row), y: values[row])
            lineArray.append(data)
        }
        let lineDataSet:LineChartDataSet = LineChartDataSet(entries: lineArray, label: "Air Quality")
        
        let linedata:LineChartData = LineChartData(dataSet: lineDataSet )
        
        lineChart.data = linedata
        lineChart.animate(xAxisDuration: 2, easingOption: .easeInSine)
        
    }
    
    
//    @IBAction func seeallBtnWasPressed(_ sender: Any) {
////          forecastTable.isHidden = false
//        
//        
//    }
    
    func setupCard()  {
        
        
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        forcastVC = ForeCastVC(nibName: "ForeCastVC", bundle: nil)
        
        self.addChild(forcastVC)
        self.view.addSubview(forcastVC.view)
        
        forcastVC.view.frame = CGRect(x: 0, y: self.view.frame.height -  cardHandelAreaHeight, width: self.view.bounds.width, height: carHeight)
        
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
                    self.forcastVC.view.frame.origin.y = self.view.frame.height - self.cardHandelAreaHeight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.forcastVC.view.layer.cornerRadius = 12
                case .collapsed:
                    self.forcastVC.view.layer.cornerRadius = 0
                }
            }
            
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }
            
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
            
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
            
            startInteractiveTransition(state: nextState, duration: 0.9)

            
        case .changed:
            
            let translation = recognizer.translation(in: self.forcastVC.handleArea)

            var fractionComplete = translation.y / carHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()

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

