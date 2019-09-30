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
    var smokeAqi = [String]()
    var coAqi = [String]()
    var uvAqi = [String]()
    

    
    public private(set) var temperature: String!
    public private(set) var uv: String!
    public private(set) var fire: String!
    public private(set) var gas : String!
    public private(set) var rain: String!
    public private(set) var dust: String!
    public private(set) var humidity: String!
    public private(set) var co2: String!
    public private(set) var co: String!
    public private(set) var smoke: String!
    public private(set) var soil: String!


    
    func setParameter(result:[String:Any])  {
        
        
        temperature = result["temp"] as? String
        rain = result["rain"] as? String

        gas = result["gas"] as? String

        fire  = result["fire"] as? String

        co2 = result["co2"] as? String

        uv = result["uv"] as? String
        dust = result["dust"] as? String

        humidity = result["humidity"] as? String
        
        smoke = result["smoke"] as? String
        co  = result["co"] as? String
        soil =  result["soil"] as? String
        
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
                                            let  co = result["co"] as? String
                                            
                                            let smoke = result["smoke"] as? String
                                            
                                            let uv = result["uv"] as? String
                                            
                                            self.smokeAqi.append(smoke!)
                                            self.coAqi.append(co!)
                                            self.uvAqi.append(uv!)
                                            
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
        
        let environment:[String] = [self.temperature,self.uv,self.fire,self.gas,self.rain,self.dust,self.humidity,self.smoke,self.co,self.soil]

        

        
        return environment
        
        
    
            
    }
    
  
    func getCo()->[Double]{
        
        let convertCo = coAqi.compactMap(Double.init)
        
        let coArr = convertCo.map { (value) -> Double? in
            return Double(value)
        }
        
        let reversvalue = coArr.reversed()
        
        let arraySlice = reversvalue.prefix(12)
        let newArray = Array(arraySlice)
        
        print("array reverse \(newArray)")

        
        
        return newArray as! [Double]

    }
    
    func getUV()->[Double]{
    
        let convertUV = uvAqi.compactMap(Double.init)
        
        let uvArr = convertUV.map { (value) -> Double? in
            return Double(value)
        }
        
        let reversvalue = uvArr.reversed()
        
        let arraySlice = reversvalue.prefix(12)
        let newArray = Array(arraySlice)
        
        print("array reverse \(newArray)")

        
        
        return newArray as! [Double]
    
    }
    
    func getSmoke()->[Double]{
    
        let convertSmoke = smokeAqi.compactMap(Double.init)
        
        let smokeArr = convertSmoke.map { (value) -> Double? in
            return Double(value)
        }
        
        let reversvalue = smokeArr.reversed()
        
        let arraySlice = reversvalue.prefix(12)
        let newArray = Array(arraySlice)
        
        print("array reverse \(newArray)")

        
        
        return newArray as! [Double]
    
    }
    
    func getDustAqi()->[Double]{
    
        let convertDust = dustAqi.compactMap(Double.init)
        
        let dustArr = convertDust.map { (value) -> Double? in
            return Double(value)
        }
        
        let reversvalue = dustArr.reversed()
        
        let arraySlice = reversvalue.prefix(12)
        let newArray = Array(arraySlice)
        
        print("array reverse \(newArray)")

        
        
        return newArray as! [Double]
    
    }
    
   
    
    func  aqiCaculationLineChart() ->[Double] {
            
        var Aqiarr = [Double]()
        
        for dust in getDustAqi(){
            
            for co in getCo(){
                
                for smoke in getSmoke(){
                    
                    for uv in getUV(){
                
                        let api = (dust/1.66)*0.9+((co+smoke)/2) * 4.84*0.005 + uv*1.2*0.05
                        Aqiarr.append(api)
                    }
                }
            }
            
        }
        
        
        return Aqiarr
 
    }
    
    func aqiCaculation()->Int{
              
        if dust != nil{
            
            let dustValue  = Double(dust) ?? 0
            let coValue = Double(co) ?? 0
            let smokeValue = Double(smoke) ?? 0
            let uvValue = Double(uv) ?? 0
            let api = (dustValue/1.66)*0.9+((coValue+smokeValue)/2) * 4.84*0.005 + uvValue*1.2*0.05
                
            let roundvalue = Int(api)
            
            return roundvalue
        }
        
        return 0
        
              
    }

}


   


//static let instance = MessageService()
