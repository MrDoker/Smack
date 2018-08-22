//
//  AuthService.swift
//  Smack
//
//  Created by DokeR on 20.08.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    static let  instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: isLoggedInKey)
        }
        set {
            defaults.set(newValue, forKey: isLoggedInKey)
        }
    }
    
    var authToken: String {
        get {
           return defaults.value(forKey: tokenKey) as! String
        }
        set {
            defaults.set(newValue, forKey: tokenKey)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: userEmailKey) as! String
        }
        set {
            defaults.set(newValue, forKey: userEmailKey)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(urlRegister, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(urlLogin, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                do{
                    let json = try JSON(data: data)
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                    
                    self.isLoggedIn = true
                    completion(true)
                } catch  {
                    print(error)
                }
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func createUser(name:String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
         let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        Alamofire.request(urlAddUser, method: .post, parameters: body, encoding: JSONEncoding.default, headers: bearerHeader).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                self.setUserInfo(data)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    fileprivate func setUserInfo(_ data: Data) {
        do {
            let json = try JSON(data: data)
            let id = json["_id"].stringValue
            let color = json["avatarColor"].stringValue
            let avatarName = json["avatarName"].stringValue
            let email = json["email"].stringValue
            let name = json["name"].stringValue
            
            UserDataService.instance.setUserData(id: id, avatarColor: color, avatarName: avatarName, email: email, name: name)
        } catch {
            print(error)
        }
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler) {
        Alamofire.request("\(urlFindUserByEmail)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: bearerHeader).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                self.setUserInfo(data)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
}



/*if let json = response.result.value as? [String: Any] {
 if let email = json["user"] as? String {
 self.userEmail = email
 }
 if let token = json["token"] as? String {
 self.authToken = token
 }
 }*/





















