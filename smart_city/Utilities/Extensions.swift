//
//  Extensions.swift
//  smart_city
//
//  Created by Apple on 9/21/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit
extension String {
    var isNotEmpty : Bool {
        return !isEmpty
    }
}

extension UIViewController {
    
    
   func simpleAlert(title: String, msg: String) {
          
          let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
          present(alert, animated: true, completion: nil)
      }
      
//      func dismissDetail()  {
//          let transition = CATransition()
//          transition.duration = 0.3
//          transition.type =  CATransitionType.push
//  //        transition.subtype = CATransitionSubtype.fromRight
//          
//          self.view.window?.layer.add(transition, forKey: kCATransition)
//          
//          dismiss(animated: false, completion: nil)
//      }
      
      func presentDetail(viewControllerToPresent: UIViewController)   {
          
          let transition = CATransition()
          transition.duration = 0.4          
          self.view.window?.layer.add(transition, forKey: kCATransition)
          
          present(viewControllerToPresent, animated: false, completion: nil)
          
      }
   
}

extension String{
    
     func htmlDecoded(input:String) ->String{
            
        var temperature = ""
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        
        if let data = input.data(using:String.Encoding.utf8){
            
            
            
            do{
                
                let usescaped = try  NSAttributedString(data: data, options: options, documentAttributes: nil)
                
                temperature = usescaped.string
                
            }catch{

                print("Error")
            }
            
            
            
            return temperature
            
            
        }
            

        return "---"
            

    }
        
    
}



