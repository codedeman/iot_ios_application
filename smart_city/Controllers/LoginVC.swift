//
//  LoginVC.swift
//  smart_city
//
//  Created by Apple on 9/11/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    @IBOutlet weak var loginPressed: RoundedButton!
    
    @IBAction func loginWasPressed(_ sender: Any) {
        
        guard let email = usernameTxt.text , usernameTxt.text != "" else { return }
        guard let pass = passwordTxt.text , passwordTxt.text != "" else { return }
        
        AuthService.instance.loginUser(email: email, password: pass) { (sucess) in
            
            if sucess{
                
                AuthService.instance.findUserByEmail(completion: { (sucess) in
                
                    print("Sucess \(sucess)")
                    self.spinner.isHidden = true
                    self.spinner.stopAnimating()
                    self.dismiss(animated: true, completion: nil)
                    
                    
                })
//                print("logged in user!",AuthService.instance.authToken)
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinner.stopAnimating()
//        self.spinner.isHidden = true


        // Do any additional setup after loading the view.
    }
    
    
}
