//
//  LoginVC.swift
//  smart_city
//
//  Created by Apple on 9/11/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper


class LoginVC: UIViewController {
    


    @IBOutlet weak var usernameTxt: UITextField!
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    @IBOutlet weak var loginPressed: RoundedButton!
    
    @available(iOS 13.0, *)
    @IBAction func loginWasPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = usernameTxt.text , usernameTxt.text != "" else {
            
            
            return }
        guard let pass = passwordTxt.text , passwordTxt.text != "" else {
            simpleAlert(title: "Error", msg: "Please fill out all fields.")

            return }
        
        AuthService.instance.loginUser(email: email, password: pass) { (sucess) in
            
            if sucess{
                
                
//                EnvironmentService.instance.findCurrentParameter { (sucess) in
//
//                    if sucess{
//
//                        print("Sucess\(sucess)")
//                        print("hhahhaha\(EnvironmentService.instance.dust)")
//
//                    }
//                }
                
                AuthService.instance.findUserByEmail(completion: { (sucess) in

                    if sucess{

                        print("Sucess \(sucess)")
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        let storyboard  =  UIStoryboard(name: "Main", bundle: Bundle.main)
                               let authVC = storyboard.instantiateViewController(withIdentifier: "DashboardVC")
                        self.present(authVC, animated: true)
//                        let dashboardVC = DashboardVC()
//                        self.present(dashboardVC, animated:true, completion:nil)



                        let saveSuccessful: Bool = KeychainWrapper.standard.set(AuthService.instance.authToken, forKey: "token")

                        print("token \(saveSuccessful)")


                        print("logged in user!",AuthService.instance.authToken)

//                        self.dismiss(animated: true, completion: nil)
                    }else{

                        self.simpleAlert(title: "Error", msg: "Something wrong")

//
                    }

                })
            
            }
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinner.stopAnimating()
//        self.spinner.isHidden = true


    }
    
    
}
