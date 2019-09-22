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
    
    
        
    
    init(result:[String:Any]) {


        temperature = result["temp"] as? String
        rain = result["rain"] as? String

        gas = result["gas"] as? String

        fire  = result["fire"] as? String

        co2 = result["co2"] as? String

        uv = result["uv"] as? String
        dust = result["dust"] as? String

        humidity = result["humidity"] as? String
//
//        let convertDustValue = Double(dust)
//
//        let api = ((convertDustValue!/1024) - 0.0356) * 120000 * 0.03

    }
    init() {
//
    }
    
    func funncgetDust()->Double{
        guard let convertDustValue = (dust as? NSString)?.doubleValue else { return 84.0 }

        
        return convertDustValue
    }
    
    func fetchParameterConcurent()->Double{
        
        
        
        
        let api = ((funncgetDust()/1024) - 0.0356) * 120000 * 0.03
        
        return api
        
    }

    
}
