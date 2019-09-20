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
        Alamofire.request(URL_USER_BY_EMAIL, method: .post, parameters: body,encoding: JSONEncoding.default,headers: nil).responseJSON { (response) in
         
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                let json =  try!  JSON(data: data)
                
               if  let item  =  json["data"].arrayObject{
                
                    for itemset in item{
                        
                        let dataset =  itemset as! [String:AnyObject]
                        
                        for i in dataset{
                        
                        
                            print("data set \(i)")
                        
                        }
                
                        
                    }
                

                
                }

                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
}
