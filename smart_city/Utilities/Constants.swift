//
//  Constants.swift
//  smart_city
//
//  Created by Apple on 9/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()
let BASE_URL = "http://45.77.102.151:5000/v1.1"

let URL_LOGIN = "\(BASE_URL)/login"
let URL_GET_ALL = "\(BASE_URL)/data/get"

let URL_GET_CURRENT = "\(BASE_URL)/data/get/current"

let CONFIGURE_DEVICE_URL = "\(BASE_URL)/device/switch"
let URL_GET_SATE = "\(BASE_URL)/device/get"




// Notification Constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("channelsLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name("chanenlSelected")

let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

let ForecastSegure = "ForeCastCell"


// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
// State device
let SWITCH_ON = "1"
let SWITCH_OFF = "0"

// device
let FAN = "fan_1"
let PUMP = "pump_1"

let LIGHT = "light_1"

let AWNING = "awning_1"


// Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]

//let BEARER_HEADER = [
//    "Authorization":"Bearer \(AuthService.instance.authToken)",
//    "Content-Type": "application/json; charset=utf-8"
//]





