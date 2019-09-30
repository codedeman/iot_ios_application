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
    
        Alamofire.request(URL_GET_INFOR, method: .post, parameters: body,encoding: JSONEncoding.default,headers: HEADER).responseJSON { (response) in
            
            var arr1 = [String]()
         
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                self.setUserInfo(data: data)
            
                }

                
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func setUserInfo(data: Data) {
        
        do {
            
            let json = try! JSON(data: data)
            let email = json["email"].stringValue
            let place_name = json["place_name"].stringValue
            UserService.instance.setParameter(email: email, place_name:place_name)
        } catch  {
            
            debugPrint(error)
        }
        
    }
    
    
}
