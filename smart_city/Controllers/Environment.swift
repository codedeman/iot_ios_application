//
//  Environment.swift
//  smart_city
//
//  Created by Apple on 9/20/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

struct Environment {
    
    public private(set) var temperature: String!
    public private(set) var uv: String!
    public private(set) var fire: String!
    public private(set) var gas : String!
    public private(set) var rain: String!
    public private(set) var dust: String!
    public private(set) var humidity: String!
    public private(set) var co2: String!
    

   
    
    func getDust()->String{
            
       
        return dust
    }
    
    init(temperature:String,
         uv:String,
         fire:String,gas:String,rain:String,dust:String,humidity:String,co2:String) {
            
            self.temperature = temperature
            self.uv = uv
            self.gas = gas
            self.rain = rain
            self.humidity = humidity
            self.co2 = co2
            
        }
    
    func fetchParameterConcurent()->Double{
        
        let converValue = Double(getDust()) ?? 0
        let api = ((converValue/1024) - 0.0356) * 120000 * 0.035
        
        return api
        
    }
    

    

    
}
