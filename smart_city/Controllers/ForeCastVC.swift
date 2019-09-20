//
//  ForeCastVC.swift
//  smart_city
//
//  Created by Apple on 9/18/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ForeCastVC: UIViewController {
//    handleArea
    
    let xLabels: [String] = ["40", "30", "54", "69", "40", "70"]
    let nameLabels: [String] = ["Temperature", "UV", "Fire", "Gas", "Rain", "Dust","Humidity","Co2"]

    @IBOutlet weak var handleArea: UIView!
    
    @IBOutlet weak var forecastTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        forecastTableView.register(UINib(nibName: "ForeCastCell", bundle: nil), forCellReuseIdentifier: "ForeCastCell")

        forecastTableView.delegate =  self
        forecastTableView.dataSource = self

    }


    

}
extension ForeCastVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return xLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForeCastCell", for: indexPath) as? ForeCastCell else {
            return ForeCastCell()
        }
        cell.value.text = xLabels[indexPath.row]
        cell.environmentPrameter.text = nameLabels[indexPath.row]
        
        
        return cell
        
    }
    

}
