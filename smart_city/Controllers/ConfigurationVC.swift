//
//  ConfigurationVC.swift
//  smart_city
//
//  Created by Apple on 9/27/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ConfigurationVC: UIViewController {

    @IBOutlet weak var pumpState: UISwitch!
    
    @IBOutlet weak var fanState: UISwitch!
    
    @IBOutlet weak var lightState: UISwitch!
    @IBOutlet weak var awningState: UISwitch!
    
    
    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(backWasPressed))
        tap.numberOfTapsRequired = 1
        bgView.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pumpSwitch(_ sender: Any) {
        
       if (pumpState.isOn){
            
            EnvironmentService.instance.configureDevice(device: PUMP, switching: SWITCH_ON) { (sucess) in
                
                if sucess{
                
                    print("Sucess")
                }
                print("false")
            }
        
       }else{
        
            EnvironmentService.instance.configureDevice(device: PUMP, switching: SWITCH_OFF) { (sucess) in
                       
                if sucess{
                       
                    print("Sucess")
                }
                    print("false")
                }
        
        }
        
    }
    
    
    @IBAction func fanSwitch(_ sender: Any) {
        
        
        if (fanState.isOn){
                  
                  EnvironmentService.instance.configureDevice(device: FAN, switching: SWITCH_ON) { (sucess) in
                      
                      if sucess{
                      
                          print("Sucess")
                      }
                      print("false")
                  }
              
             }else{
              
                  EnvironmentService.instance.configureDevice(device: FAN, switching: SWITCH_OFF) { (sucess) in
                             
                      if sucess{
                             
                          print("Sucess")
                      }
                          print("false")
                      }
              
              }
        
    }
    
    
    @IBAction func lightSwitch(_ sender: Any) {
        
        if (lightState.isOn){
                        
                EnvironmentService.instance.configureDevice(device: LIGHT, switching: SWITCH_ON) { (sucess) in
                            
                        if sucess{
                            
                                print("Sucess")
                            }
                            print("false")
                        }
                    
                   }else{
                    
                        EnvironmentService.instance.configureDevice(device: LIGHT, switching: SWITCH_OFF) { (sucess) in
                                   
                            if sucess{
                                   
                                print("Sucess")
                            }
                                print("false")
                            }
                    
                    }
        
        
    }
    
    
    @IBAction func awningSwitch(_ sender: Any) {
        
        
        if (awningState.isOn){
                        
                        EnvironmentService.instance.configureDevice(device: AWNING, switching: SWITCH_ON) { (sucess) in
                            
                            if sucess{
                            
                                print("Sucess")
                            }
                            print("false")
                        }
                    
                   }else{
                    
                        EnvironmentService.instance.configureDevice(device: AWNING, switching: SWITCH_OFF) { (sucess) in
                                   
                            if sucess{
                                   
                                print("Sucess")
                            }
                                print("false")
                            }
                    
                    }
        
    }
    
    @objc func backWasPressed()  {
        
        dismiss(animated: true) {
            
            
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
