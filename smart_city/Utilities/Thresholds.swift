//
//  Thresholds.swift
//  smart_city
//
//  Created by Apple on 9/23/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

class Thresholds {
    
    static let instance = Thresholds()
    static let  verybad = "Dengerous"
    static let bad = "Bad"

    static  let medium = "Medium"
    static let normal = "Normal"
    
    static let good = "Good"
    
    static let verygood = "Verygood"
    
    func aqiThreshold(value:Int)->String{
        
        var  message:String!
        
        if (value >= 0 && value < 75) {message =  Thresholds.good}
        
        if (value >= 150 && value < 300) {message = Thresholds.normal}

        if (value >= 300 && value < 1050){ message = Thresholds.medium}
        
        if (value >= 1050 && value < 3000){ message = Thresholds.bad}


        return message
        
    
    }
    

}
