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
    
    var environmentModel = [Environment]()
    
    var environmentArr = [String]()
    
    var dustAqi = [String]()

    
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
    
  
    

    
    func findCurrentParameter(completion: @escaping CompletionHandler) {
        
        let body: [String: Any] = [
            "token": token
        ]
        
    
        Alamofire.request(URL_GET_CURRENT, method: .post, parameters: body,encoding: JSONEncoding.default,headers: HEADER).responseJSON { (response) in
            
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
                                    
                                    let parameter = Environment(temperature: self.temperature, uv: self.uv, fire: self.fire, gas: self.gas, rain: self.gas, dust: self.dust, humidity: self.humidity, co2: self.humidity)
                                    
                                    self.environmentModel.append(parameter)
                                
                                    
                                }
        
                    
                            }
                        
                        }

                    }
                }
                completion(true)
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
   
    

        
        func findAllParameter(completion: @escaping CompletionHandler) {
            
            let body: [String: Any] = [
                "token": token
            ]
            Alamofire.request(URL_GET_ALL, method: .post, parameters: body,encoding: JSONEncoding.default,headers: HEADER).responseJSON { (response) in
                
             
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
                                        
                                            let dust = result["dust"] as? String
                                        
                                        self.dustAqi.append(dust!)
                                    }
            
                        
                                }
                            
                            }

                        }
                    print("dust \(self.dustAqi)")
                    }
                    completion(true)
                } else {
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
        }
    

    
    func getPlaceIds(handler: @escaping (_ _placeID:[String])->() ) {
               
               let body: [String: Any] = [
                   "token": token
               ]
                var place_idArray = [String]()
        Alamofire.request(URL_GET_CURRENT, method: .post, parameters: body,encoding: JSONEncoding.default,headers: HEADER).responseJSON { (response) in

                   if response.result.error == nil {
                       guard let data = response.data else { return }
                       
                       let json =  try!  JSON(data: data)
                       
                      if  let item  =  json["places"].arrayObject{
                       
                           for itemset in item{
                               
                               let dataset:Dictionary<String,AnyObject> =  itemset as! Dictionary<String, AnyObject>
                               
                            guard  let place = dataset["place_id"]  as? String else {
                                return
                            }
                            
                                
                                place_idArray.append(place)
                                

                           }
                       }
                        handler(place_idArray)
                  
               }
           }
        
    }
    
    

    
    func configureDevice(device:String,switching:String,completion: @escaping CompletionHandler)  {
        
        let body: [String: Any] = [
            "token": token,"device_name":device, "switch":switching
        ]
        
        Alamofire.request(CONFIGURE_DEVICE_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            switch response.result{
                
            case .success:
                
                completion(true)
                break
            case .failure(_):
                
                completion(false)
        
                debugPrint(response.result.error as Any)
                
                print("false")

            }
        
        
    
    }
        
}
    
    
    
    
    
    func environmentParameters()->[Environment]{
        
        
        return environmentModel
        
          
    }
    
    func getDust() -> String {
           return dust
    }
    
    func getEnvironment() -> [String] {
        
        let  environment:[String] = [self.temperature,self.uv,self.fire,self.gas,self.rain,self.dust]

        
//        let doubleArray = environment.compactMap(Double.init)
//
//        let arrOfDoubles = doubleArray.map { (value) -> Double? in
//            return Double(value)
//        }
        
        return environment
        
        
    
            
    }
    
    func  aqiCaculationLineChart() ->[Double] {
        
        var aqiArr = [Double]()
        
        let doubleArray = dustAqi.compactMap(Double.init)
        
        let arrOfDoubles = doubleArray.map { (value) -> Double? in
            return Double(value)
        }
        
        for aqi in arrOfDoubles{
            
            let apic:Double = ((aqi!/1024) - 0.0356) * 120000 * 0.035
//            print("aqi caculation: \(aqic)")
            aqiArr.append(apic)
        }
        
        print("aqi \(aqiArr)")
        
        let reversvalue = aqiArr.reversed()
        
        let arraySlice = reversvalue.prefix(12)
        let newArray = Array(arraySlice)
        print("array reverse \(newArray)")

        
        
        return newArray
    }
    
    func aqiCaculation()->Int{
              
        let converValue = Double(getDust()) ?? 0
              let api = ((converValue/1024) - 0.0356) * 120000 * 0.035
               
           let roundvalue = Int(api)
           
              
           return roundvalue
              
    }

}


   


//static let instance = MessageService()
