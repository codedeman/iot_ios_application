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
    
    

    
    func fetchParameterConcurent()->Double{
        
        let converValue = Double(getDust()) ?? 0
        let api = ((converValue/1024) - 0.0356) * 120000 * 0.035
        
        return api
        
    }
    

    

    
}
