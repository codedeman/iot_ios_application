//
//  AppDelegate.swift
//  smart_city
//
//  Created by Apple on 9/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import UserNotifications



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let retrievedToken: String? = KeychainWrapper.standard.string(forKey: "token")
        
        if (retrievedToken != nil)  {
            
             let storyboard  =  UIStoryboard(name: "Main", bundle: Bundle.main)
            let dasboardVC = storyboard.instantiateViewController(withIdentifier: "Home")
            
                
            self.window?.rootViewController?.navigationController?.pushViewController(dasboardVC, animated: true)

        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
    }
    
//    func applicationDidEnterBackground(application: UIApplication) {
//        SocketIOManager.sharedInstance.closeConnection()
//    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        SocketService.instance.closeConnection()
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        SocketService.instance.establishConnection()
        
    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
    //    lazy var persistentContainer: NSPersistentContainer = {

//    lazy var persistentContainer: NSpr = {
//         
//          let container = NSPersistentContainer(name: "GoalPost")
//          container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//              if let error = error as NSError? {
//                  
//                  fatalError("Unresolved error \(error), \(error.userInfo)")
//              }
//          })
//          return container
//      }()
    
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
    private func configureUserNotification()
    {
        let favAction = UNNotificationAction(identifier: "firstBump", title: "💪🏻First Bump💪🏻", options: [])
        let dismissAction = UNNotificationAction(identifier: "dissmiss", title: "😰Dissmiss😭", options: [])
        let category =  UNNotificationCategory(identifier: "myNotificationCategory", actions: [favAction,dismissAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
    }

}

extension  AppDelegate:UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
                print("Response received for \(response.actionIdentifier)")
                completionHandler()

        
        
    }

}

