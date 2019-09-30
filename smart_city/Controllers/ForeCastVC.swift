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
    let nameLabels: [String] = ["Temperature", "UV", "Fire", "Gas", "Rain", "Dust","Humidity","Co","Soil","Smoke"]
    
//    let environment:[String] = [self.temperature,self.uv,self.fire,self.gas,self.rain,self.dust,self.humidity,self.smoke,self.soil]

    let environment:[Environment] = []

    @IBOutlet weak var handleArea: UIView!
    
    @IBOutlet weak var forecastTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("what the hell \(nameLabels.count)")
      
        print("data \(EnvironmentService.instance.environmentParameters())")
        forecastTableView.register(UINib(nibName: "ForeCastCell", bundle: nil), forCellReuseIdentifier: "ForeCastCell")
        
        

        forecastTableView.delegate =  self
        forecastTableView.dataSource = self

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        EnvironmentService.instance.findCurrentParameter { (sucess) in
            
            _ = EnvironmentService.instance.environmentParameters()
            let data = EnvironmentService.instance.getEnvironment()
            print("what the hell \(data.count)")
        
        }
        
    }


    @IBAction func configureBtnWasPressed(_ sender: Any) {
        
        let configureVC =  ConfigurationVC()
        configureVC.modalPresentationStyle = .overCurrentContext
        
        present(configureVC, animated: true) {
            
            print("cool")
        }
        

    }
    
}


extension ForeCastVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nameLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForeCastCell", for: indexPath) as? ForeCastCell else {
            return ForeCastCell()
        }
        
        EnvironmentService.instance.findCurrentParameter { (sucess) in
            
            let data = EnvironmentService.instance.getEnvironment()[indexPath.row]
            
            let intArray = EnvironmentService.instance.getEnvironment().compactMap(Int.init)
            
            let arrOfInt = intArray.map { (value) -> Int? in return Int(value)}
        
            cell.value.text = data
            cell.environmentPrameter.text = self.nameLabels[indexPath.row]
            
            
            if self.nameLabels[indexPath.row] == "Temperature"{
                
                cell.environmentStatus.text = "\(Thresholds.instance.temperatureThreshold(value:arrOfInt[0]! ))"
                
                let temp =  "\(EnvironmentService.instance.temperature!)&deg"
                
                
                let temp1 = "".htmlDecoded(input: temp)+"C"
                cell.value!.text = temp1
                
            }

            if self.nameLabels[indexPath.row] == "UV"{
                
                
                cell.environmentStatus.text = "\(Thresholds.instance.uvThreshold(value:arrOfInt[1]! ))"
            
                cell.background.backgroundColor = self.hexStringToUIColor(hex: "#6fccb0")
                let uv = "\(EnvironmentService.instance.uv!)mW/cm&sup2"
                let uv1 = "".htmlDecoded(input: uv)
                cell.value.text = uv1
                
            }
            if self.nameLabels[indexPath.row] == "Rain"{
                if EnvironmentService.instance.rain == "1"{
                    cell.value.isHidden = true
                    cell.environmentStatus.text = "Raining"
                    cell.background.backgroundColor = self.hexStringToUIColor(hex: "#653ac9")

                }else{
                
                
                    cell.environmentStatus.text = "Normal"

                
                }

            }
            if self.nameLabels[indexPath.row] == "Fire"{
                
                if EnvironmentService.instance.fire == "1" {
                    cell.environmentStatus.text = "Yes"
                    cell.value.isHidden = true
                }
                else{
                    
                    cell.environmentStatus.text = "Normal"
                    cell.value.isHidden = true
                }
                cell.background.backgroundColor = self.hexStringToUIColor(hex: "#ee3661")
                
            }
            
            
            
            if self.nameLabels[indexPath.row] == "Dust"{
                
                let dust = "\(EnvironmentService.instance.dust!)"+"mg/m&sup3"
                
                let dustconvert = "".htmlDecoded(input: dust)


                cell.value.text =  dustconvert

            }
            
            if self.nameLabels[indexPath.row] == "Humidity"{
                          
                    let humidity = "\(EnvironmentService.instance.humidity!)"+"&#37"
                          
                    let dustconvert = "".htmlDecoded(input: humidity)
                    cell.value.text =  dustconvert

            }
            
            if self.nameLabels[indexPath.row] == "Soil"{
                                     
                let soil = "\(EnvironmentService.instance.soil!)"+"&#37"
                                     
                    let soilconvert = "".htmlDecoded(input: soil)
                    cell.value.text =  soilconvert

            }
            
            if self.nameLabels[indexPath.row] == "Co"{
                let co = "\(EnvironmentService.instance.co!)"+"ppm"
                cell.value.text =  co

                
            }
                      
            
            
            
        }
        
        
        return cell
        
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
   
    

}

