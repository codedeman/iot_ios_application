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
let URL_REGISTER = "\(BASE_URL)account/register"

let URL_LOGIN = "\(BASE_URL)/login"
let URL_USER_BY_EMAIL = "\(BASE_URL)/data/get"




let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

let ForecastSegure = "ForeCastCell"


// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]

let BEARER_HEADER = [
    "Authorization":"Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]





