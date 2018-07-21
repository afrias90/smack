//
//  Constants.swift
//  smack
//
//  Created by Adolfo Frias on 7/20/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// URL Constants
let BASE_URL = "https://longwaychat.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"

// segues

let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"




