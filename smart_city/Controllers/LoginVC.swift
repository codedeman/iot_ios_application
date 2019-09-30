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
                AuthService.instance.getAllData(completion: { (sucess) in

                    if sucess{

                        print("Sucess \(sucess)")
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        let storyboard  =  UIStoryboard(name: "Main", bundle: Bundle.main)
                               let authVC = storyboard.instantiateViewController(withIdentifier: "Home")
                        self.present(authVC, animated: true)

                        let saveSuccessful: Bool = KeychainWrapper.standard.set(AuthService.instance.authToken, forKey: "token")
                        let retrievedToken: String? = KeychainWrapper.standard.string(forKey: "token")

                        
                        print("logged in  \(retrievedToken)")
                        print("token \(saveSuccessful)")


                        print("logged in user!",AuthService.instance.authToken)

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
