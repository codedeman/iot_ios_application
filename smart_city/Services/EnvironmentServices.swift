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

    func findCurrentParameter(completion: @escaping CompletionHandler) {
        
        let body: [String: Any] = [
            "token": token
        ]
    
        Alamofire.request(URL_GET_CURRENT, method: .post, parameters: body,encoding: JSONEncoding.default,headers: HEADER).responseJSON { (response) in
            
            var  envronmentModel =  Environment()
         
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
                                    
                                    let getenvironment = Environment(result: result)
                                    
//                                    envronmentModel.fetchParameterConcurent(result: result)
                                    
                                    
//                                    let temperature = result["temp"] as! String
//                                    let  rain = result["rain"] as! String
//                                    let gas = result["gas"] as! String
//
//                                    let fire  = result["fire"] as! String
//                                    let co2 = result["co2"] as! String
//
//                                    let uv = result["uv"] as! String
//                                    let dust = result["dust"] as! String
//
//                                    let humidity = result["humidity"] as! String
//
//                                    let convertDustValue = Double(dust)
//
//                                    let api = ((convertDustValue!/1024) - 0.0356) * 120000 * 0.03
                                    
                                
                                    
//                                    let getenvironment = Environment(temperature: temperature,uv: uv,fire: fire,gas : gas,rain: rain,dust: String(api),humidity: humidity,co2: co2)
                                    
//                                    print("environment \(getenvironment.co2)")
                                    
                                    
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
