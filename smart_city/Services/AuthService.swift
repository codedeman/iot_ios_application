//
//  AuthService.swift
//  smart_city
//
//  Created by Apple on 9/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class  AuthService {
    
    static let instance =  AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn:Bool{
        
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
        
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    
    
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "username": lowerCaseEmail,
            "password": password
        ]
//        var url = URL_LOGIN+"?username=\(email)&password=\(password)"
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                do{
                
                let json =  try!  JSON(data: data)
                    self.authToken = json["token"].stringValue
//                    print(self.authToken)
                    self.isLoggedIn = true
                    completion(true)
                
                }catch{
                    
                    print("error right here")
                }
                
             
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    func findUserByEmail(completion: @escaping CompletionHandler) {
        
        let body: [String: Any] = [
            "token":authToken
        ]
        
        print("hello \(body)")
        
//        print("token here \(authToken)")
        Alamofire.request(URL_USER_BY_EMAIL, method: .post, parameters: body,encoding: JSONEncoding.default,headers: HEADER).responseJSON { (response) in
            
            var arr1 = [String]()
         
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
                                
                                let arr:Dictionary<String,AnyObject> = evvalue["datas"] as! Dictionary<String, AnyObject>
                                
//                                print("data \(arr["temp"])")
                                
                                arr1.append(arr["temp"] as! String)
                            
                                
                            }
                        
                        }

                    }
                    print("data \(arr1.count)")


                
                }

                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
}
