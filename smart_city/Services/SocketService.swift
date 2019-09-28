//
//  SocketService.swift
//  smart_city
//
//  Created by Apple on 9/21/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit
import SocketIO


//let manager = SocketManager(socketURL: URL(string: "http://localhost:8080")!, config: [.log(true), .compress])
//
//let socket = manager.defaultSocket
let config : [String: Any] = ["log": true,
"compress": true,
"forcePolling": true,
"forceNew": true]
class SocketService: NSObject {
    


    static let instance = SocketService()
    var socket: SocketIOClient!


    let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: config)
    

//    let manager = SocketManager(socketURL: URL(string: BASE_URL)!)

    
    
    override init() {
        super.init()
        socket = manager.defaultSocket
        
    }
    
    
    
    func getEnvironmentParameter(place_id:String,handler: @escaping (_ newParameter:[String])->()) {
        
        
        var newParamete = [String]()
        
        manager.defaultSocket.on(clientEvent: .statusChange) { (data, ack) in
            
                guard let data = data[0] as? String else { return }
            newParamete.append(data)
            handler(newParamete)
            

            
        }
        
//        socket.on(place_id, callback: { (dataArr, ack) in
//
//            guard let data = dataArr[0] as? String else { return }
//                newParamete.append(data)
//                print("what the hell \(data)")
//                handler(newParamete)
//        })
        
    }
    
    func conectSocket(completion:@escaping CompletionHandler)  {
        

    }
    
   
    
    func getNotify(){
        
        socket.on("notify", callback: { (data,message )  in


            print("notify right here \(data)")

            
        })
        
        
        
    }
    
    
    func establishConnection() {
        
        socket.connect()
        
        print("wha what! \(socket.connect())")
//        let socket = manager.socket(forNamespace: "/consumer")

//        socket.on("connect") { (data, ack) -> Void in
//            print("socket connected",data,ack)
//        }
//
//        socket.on(clientEvent: .disconnect){data, ack in
//            print("socket disconnected")
//        }
//
//        socket.on("session-available") { (dataArr, ack) -> Void in
//            ack.with(true)
//            if let sessionAvailableCB = self.avaialableCallBack {
//                sessionAvailableCB(dataArr)
//            }
//        }

        
        
        
    }
    
    func closeConnection() {
        socket?.disconnect()
    }
    func checkConnection() -> Bool {
           if socket.manager?.status == .connected {
               return true
           }
           return false

    }
    
    
    



}
