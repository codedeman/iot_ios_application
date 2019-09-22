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
                
                
                EnvironmentService.instance.findCurrentParameter { (sucess) in
                    
                    if sucess{
                    
                        print("Sucess\(sucess)")
                    
                    }
                }
                
                AuthService.instance.findUserByEmail(completion: { (sucess) in

                    if sucess{

                        print("Sucess \(sucess)")
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        let dashboardVC = DashboardVC()
                        dashboardVC.modalPresentationStyle = .pageSheet
                        self.present(dashboardVC, animated: true, completion: nil)


//                        presentDetail(viewControllerToPresent: )
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
