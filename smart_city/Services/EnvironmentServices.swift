//
//  EnvirontmentServices.swift
//  smart_city
//
//  Created by Apple on 9/21/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class EnvironmentService {
    static let instance = EnvironmentService()
    
    let token =  AuthService.instance.authToken
    
    public private(set) var temperature: String!
    public private(set) var uv: String!
    public private(set) var fire: String!
    public private(set) var gas : String!
    public private(set) var rain: String!
    public private(set) var dust: String!
    public private(set) var humidity: String!
    public private(set) var co2: String!
    
    func setParameter(result:[String:Any])  {
        
        
        temperature = result["temp"] as? String
        rain = result["rain"] as? String

        gas = result["gas"] as? String

        fire  = result["fire"] as? String

        co2 = result["co2"] as? String

        uv = result["uv"] as? String
        dust = result["dust"] as? String

        humidity = result["humidity"] as? String
        
        
    }
    
//    var environmentParameter:[]

    
    func findCurrentParameter(completion: @escaping CompletionHandler) {
        
        let body: [String: Any] = [
            "token": token
        ]
        
    
        Alamofire.request(URL_GET_CURRENT, method: .post, parameters: body,encoding: JSONEncoding.default,headers: HEADER).responseJSON { (response) in
            
            var  envronmentModel = [Environment]()
         
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                let json =  try!  JSON(data: data)
                
               if  let item  =  json["places"].arrayObject{
                
                    for itemset in item{
                        
                        let dataset:Dictionary<String,AnyObject> =  itemset as! Dictionary<String, AnyObject>
                        
                        if let environtment =  dataset["times"]{
                            
                            
                            let environmentvalue = environtment as! Array<AnyObject>
                            
                            
                            for castvalue in environmentvalue{
                            
                            
                                let evvalue:Dictionary<String,AnyObject> = castvalue as! Dictionary<String,AnyObject>
                                
                                if  let result:Dictionary<String,AnyObject> = evvalue["datas"] as? Dictionary<String, AnyObject>{
                                    
                                    self.setParameter(result: result)
                                    
                                    
                                    
                                    
                                    
                                }
        
                    
                            }
                        
                        }

                    }
//                    print("data \(arr1.count)")
                }
                completion(true)


                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
}
//static let instance = MessageService()
