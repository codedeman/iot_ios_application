//
//  NotificationViewController.swift
//  NotificationContentApp
//
//  Created by Apple on 9/29/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        guard let attachment  = notification.request.content.attachments.first else{
            return
        }
//        if attachment.url.startAccessingSecurityScopedResource(){
//            let imageData  = try? Data.init(contentsOf:attachment.url)
////            if let img = imageData{
////                imageView.image = UIImage(data: img)
////            }
//        }
    }
    
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        if response.actionIdentifier == "firstBump"{
            completion(.dismissAndForwardAction)
        }else if response.actionIdentifier == "dissmiss" {
            completion(.dismissAndForwardAction)
        }
    }

}
