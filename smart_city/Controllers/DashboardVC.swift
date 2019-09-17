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
    
   
    let data:[Int]  = [43, 53]
    let data2: [Double] = [1, 3, 5, 13, 17, 20]
    
    @IBOutlet weak var forecastTable: UITableView!
    @IBOutlet weak var inforView: RoundedView!
    // simple line with custom x axis labels
    let xLabels: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
    @IBOutlet weak var lineChart: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        forecastTable.isHidden = true
        
//        forecastTable.register(UINib(nibName: "ForeCastCell", bundle: nil), forCellReuseIdentifier: "ForeCastCell")
        
//        productCollectionView.register(UINib(nibName: Identifiers.ProductCell, bundle: nil), forCellWithReuseIdentifier:Identifiers.ProductCell)

        setLineChart(name: xLabels, values: data2)
        forecastTable.register(UINib(nibName: "ForeCastCell", bundle: nil), forCellReuseIdentifier: "ForeCastCell")

        

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
    
    
    @IBAction func seeallBtnWasPressed(_ sender: Any) {
          forecastTable.isHidden = false
        
        
    }
    
   
    

  

}

extension DashboardVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return xLabels.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForeCastCell", for: indexPath) as? ForeCastCell else {
            return ForeCastCell()
        }
        cell.value.text = xLabels[indexPath.row]
        
        
        return cell
    }
    

}
