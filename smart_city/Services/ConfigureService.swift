//
//  ConfigureService.swift
//  smart_city
//
//  Created by Apple on 9/28/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class ConfigureService {
    
    static let instance = ConfigureService()
    let token =  AuthService.instance.authToken

    public private(set) var awning: String!
    public private(set) var fan: String!
    public private(set) var light: String!
    public private(set) var pump: String!
    var configure = [Configure]()


    func setParameter(result:[String:Any]!)  {
        
        
        awning = result["awning_1"] as? String
        fan  = result["fan_1"] as?  String
        light =  result["light_1"] as? String
        pump = result["pump_1"] as? String
       
        
    }
    
    
    func getSate(completion: @escaping CompletionHandler) {
    
        let body: [String: Any] = [
            "token": token
        ]
        
        let _:[String:Any]
        
        
        
        Alamofire.request(URL_GET_SATE, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            
            if response.result.error == nil {
                    guard let data = response.data else { return }
                
                  do{
                                
                    let json =  try!  JSON(data: data)
                    
                    print("data2 \(json["devices"])")
                    print("data1 \(json["code"])")

                    
                    let state = json["devices"].dictionary
                    
                    
                    guard let result = state as? Dictionary<String,Any> else {return}
                    
                    
                    for index in result{
                    
                    
                        guard let item = index as? Dictionary<String,Any> else {return}
                        print("items \(item["awnings"])")
                    }
                    
//                    print("Fuck\(result["awnings"])")
                    
//                    print("Fuck \(state!["awnings"])")
//
//
//                    for index in state!{
//
//                        print("Fuck \(index)")
//
//
//
//                    }
                    
                    

                                            
                        completion(true)
                                
                  }catch{
                    
                    completion(false)
                    
                    
                }
                                    

             
                
            }

            
        }
        
        
    }
    
    
    func getAwning()->String {
        if self.awning != nil{
            
            return self.awning

        }
        
        return "0"
    }
    
    
    
}

