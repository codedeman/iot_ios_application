//
//  Configure.swift
//  smart_city
//
//  Created by Apple on 9/28/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
struct Configure {
    
    public private(set) var awning: String!
    public private(set) var fan: String!
    public private(set) var light: String!
    public private(set) var pump: String!
    

    init(awning:String,fan:String,light:String,pump:String)  {
        
        
        self.awning = awning
        self.fan = fan
        self.light = light
        self.pump = pump
       
    }
    
    func getAwning() -> String {
        
        return awning
    }
    
    
}
