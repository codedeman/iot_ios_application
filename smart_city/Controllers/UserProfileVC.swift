//
//  UserProfile.swift
//  smart_city
//
//  Created by Apple on 9/29/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController {

    @IBOutlet weak var userContentTableView: UITableView!
    var userProfile:UserService!
    @IBOutlet weak var emailLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userContentTableView.delegate = self
        userContentTableView.dataSource = self
        
        AuthService.instance.findUserByEmail { (sucess) in
            
            if sucess{
            
                self.emailLbl.text = "\(AuthService.instance.getEmail())"
                

                    
            }
            
        }
//        self.emailLbl.text = "\(UserService.instance.email)"
//        print(UserService.instance.email)

        // Do any additional setup after loading the view.
    }
    

   

}

extension UserProfileVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UserProfileCell
        
//        cell.stateLbl.te
//        cell.stateLbl.text = "Dark mode"
        
        if (cell.switchState.isOn) {
            
            self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }else{
            self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        
        }
        return cell
    }
    

}
