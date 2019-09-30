//
//  Thresholds.swift
//  smart_city
//
//  Created by Apple on 9/23/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

import UserNotifications

class Thresholds {
    
    static let instance = Thresholds()
    static let  verybad = "Dengerous"
    static let bad = "Bad"

    static  let medium = "Medium"
    static let normal = "Normal"
    
    static let good = "Good"
    
    static let verygood = "Verygood"
    
    static let  safe = "Safe"
    static let  extreme = "Extreme"

    static let verycool = "Very cool"
    static let  cool = "Cool"
    static let  hot = "Hot"
    static let veryhot = "Very hot"
    
    static let low = "Low"
    static let verylow = "Very low"
    static  let high = "High"
    static let veryhight = "Very high"
    
    func aqiThreshold(value:Int)->String{
        
        var  message = ""
        
        if (value >= 0 && value < 75) {message =  Thresholds.good}
        
        if (value >= 150 && value < 300) {
            
            message = Thresholds.normal
            
            
            
//            thresholdNotification(value: value, inSeconds: 3) { (sucess) in
//                           if sucess{
//
//                               print("Sucessfully ")
//                           }
//                           print("Error")
//                       }
            
        }

        if (value >= 300 && value < 1050){ message = Thresholds.medium}
        
        if (value >= 1050 && value < 3000){
            
            message = Thresholds.bad
            thresholdNotification(value: value, inSeconds: 3) { (sucess) in
                if sucess{
                
                    print("Sucessfully ")
                }
                print("Error")
            }
        }


        return message
        
    
    }
    
    func uvThreshold(value:Int) ->String  {
        
        var message = ""

        if (value >= 0 && value < 3) {message = Thresholds.safe}
        if (value >= 3 && value < 6) {message = Thresholds.medium}
        if (value >= 6 && value < 8) {message = Thresholds.high}
        if (value >= 8 && value < 11) {message = Thresholds.veryhight}
        if (value >= 11) {message = Thresholds.extreme}

        return message
    }
    
    func  temperatureThreshold(value:Int) -> String {
        var message = ""
        
        if (value < 0) {message = Thresholds.extreme}
        if (value >= 0 && value < 10) {message = Thresholds.verylow}
        if (value >= 10 && value < 20) {message = Thresholds.low}
        if (value >= 20 && value < 25) {message = Thresholds.normal}
        if (value >= 25 && value < 30) {message = Thresholds.high}
        if (value >= 30 && value < 40) {message = Thresholds.veryhight}
        if (value >= 40) {message = Thresholds.extreme}
        
        return message
        
    }
    
    func thresholdNotification(value:Int,inSeconds:TimeInterval,completion:@escaping (_ Success:Bool)->()) {
   
//            var attachment:UNNotificationAttachment
            
    //          attachment = try!UNNotificationAttachment(identifier: "myNotification", url:imageUrl , options: .none)
            //ONLY FOR EXTENSION
        
             let notif = UNMutableNotificationContent()
            notif.categoryIdentifier = "myNotificationCategory"
            notif.title = "New Notification"
            notif.subtitle = "\(value)"

     
            
            let  notifTrigger =  UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)

            
            let request =  UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
            
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                
                if error != nil{
                    
                    print(error!)
                    completion(false)
                    
                }
                else {
                    completion(true)
                }
            })
        }

}
