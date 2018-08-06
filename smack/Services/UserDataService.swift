//
//  UserDataService.swift
//  smack
//
//  Created by Adolfo Frias on 7/23/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import Foundation

// to save user info...

class UserDataService {
    
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
    
    func returnUIColor(components: String) -> UIColor {
        // reference  "avatarColor": "[0.52156862745098, 0.92156862745098, 0.0274509803921569, 1]",
        //scanner converts characters of an NSString object into number and string values
        let scanner = Scanner(string: components)
        // four characters, [, ], a comma, and a space
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        //NSString is what scanner converts the values into
        var r, g, b, a : NSString?
        
        //from beginning, it will skip [ and go up to the comma]
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        guard let rUnwrapped = r else {return defaultColor}
        guard let gUnwrapped = g else {return defaultColor}
        guard let bUnwrapped = b else {return defaultColor}
        guard let aUnwrapped = a else {return defaultColor}
        
        //No straight convertion from string to CGfloat... must go to double and then CGFloat
        let rfloat = CGFloat(rUnwrapped.doubleValue)
        let gfloat = CGFloat(gUnwrapped.doubleValue)
        let bfloat = CGFloat(bUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        
        let newColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        return newColor
    }
    
    func logoutUser() {
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessage()
    }
    
}
