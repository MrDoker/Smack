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
let urlFindUserByEmail = "\(baseUrlString)user/byEmail/"
let urlGetChannels = "\(baseUrlString)channel/"
let urlGetMessages = "\(baseUrlString)message/byChannel/"
let urlChangeUserName = "\(baseUrlString)user/"


//Colors
let purplePlaceholderColor = #colorLiteral(red: 0.3098039216, green: 0.3647058824, blue: 0.7333333333, alpha: 0.6207459332)

//Notification Constants
let notifUserDataDidChange = Notification.Name("notifUserDataDidChange")
let notifChannelsLoaded = Notification.Name("notifChannelsLoaded")
let notifChannelSelected = Notification.Name("notifChannelSelected")

//Segues
let toLoginSegueName = "toLogin"
let toCreateAccountSegueName = "toCreateAccount"
let unwindToChannel = "unwindToChannel"
let toAvatarPickerSegueName = "toAvatarPicker"

//User Defaults
let isLoggedInKey = "loggedIn"
let tokenKey = "token"
let userEmailKey = "userEmail"

//Headers
let header = [
    "Content-Type": "application/json; charset=utf-8"
]

let bearerHeader = [
    "Authorization":"Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]
