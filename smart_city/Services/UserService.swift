//
//  UserService.swift
//  smart_city
//
//  Created by Apple on 9/30/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

class UserService {
    

    static let instance = UserService()

    
    public private(set) var email: String!
    public private(set) var place_name: String!
    
    func setParameter(email:String,place_name:String)  {
        
        self.email = email
        self.place_name = place_name
    }
    
    
}
