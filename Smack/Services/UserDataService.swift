//
//  UserDataService.swift
//  Smack
//
//  Created by DokeR on 20.08.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import Foundation

class UserDataService {
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, avatarColor: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColor = avatarColor
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
    
    func returnUIColor(components: String) -> UIColor {
        let scanner = Scanner(string: components)
        let skippedChars = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skippedChars
        
        var r, g, b, a: NSString?
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        guard let rUnwrap = r else { return defaultColor }
        guard let gUnwrap = g else { return defaultColor }
        guard let bUnwrap = b else { return defaultColor }
        guard let aUnwrap = a else { return defaultColor }
        
        let rFLoat = CGFloat(rUnwrap.doubleValue)
        let gFLoat = CGFloat(gUnwrap.doubleValue)
        let bFLoat = CGFloat(bUnwrap.doubleValue)
        let aFLoat = CGFloat(aUnwrap.doubleValue)
        
        
        return UIColor(red: rFLoat, green: gFLoat, blue: bFLoat, alpha: aFLoat)
    }
    
    func logoutUser() {
        id = ""
        avatarColor = ""
        avatarName = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
    }
}

















