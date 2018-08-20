//
//  Constants.swift
//  Smack
//
//  Created by DokeR on 18.08.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ success: Bool) -> ()

//URL
let baseUrlString = "https://smackchatdok.herokuapp.com/v1/"
let urlRegister = "\(baseUrlString)account/register"
let urlLogin = "\(baseUrlString)account/login"
let urlAddUser = "\(baseUrlString)user/add"

//Segues
let toLoginSegueName = "toLogin"
let toCreateAccountSegueName = "toCreateAccount"
let unwindToChannel = "unwindToChannel"

//User Defaults
let isLoggedInKey = "loggedIn"
let tokenKey = "token"
let userEmailKey = "userEmail"

//Headers
let header = [
    "Content-Type": "application/json; charset=utf-8"
]
