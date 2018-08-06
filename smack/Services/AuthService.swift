//
//  AuthService.swift
//  smack
//
//  Created by Adolfo Frias on 7/21/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
    static let instance = AuthService()
    
    //not heavy data, also insecure so no passwords
    let defaults = UserDefaults.standard
    
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    // Alamofire, built on top of apple's URL session framework that makes web resquest easier
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        
        
        let body: [String:Any] = [
            // should match exactly the body found in postman
            "email": lowerCaseEmail,
            "password": password
        ]
        // this first request we want to get backa string '.responseString', part of the API; in the other calls, we will be asking back for JSON '.responseJSON
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            //renaming what we get as 'response'
            
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
        
        let body: [String:Any] = [
            // should match exactly the body found in postman
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
//                if let json = response.value as? Dictionary<String, Any> {
//                    if let email = json["user"] as? String {
//                        self.userEmail = email
//                    }
//                    if let token = json["token"] as? String {
//                        self.authToken = token
//                    }
//
//                }
                // Using swiftyJSON
                //swiftyJSON needs the data
                guard let data = response.data, let json = try? JSON(data: data) else { return }
                //guard let json = try? JSON(data: data) else {return}; chained with previous line
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                
                //Method 2
//                do {
//
//                    let json = try JSON(data: data)
//                    self.userEmail = json["user"].stringValue
//                    self.authToken = json["token"].stringValue
//
//                } catch {
//                    debugPrint("Error converting to json object")
//                }
                //Method 3
//                if let json = try? JSON(data: data) {
//                    self.userEmail = json["user"].stringValue
//                    self.authToken = json["token"].stringValue
//                }
                
                
                self.isLoggedIn = true
                //there is no errors
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        let body: [String:Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        
        ]
        
        
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                
                guard let data = response.data, let json = try? JSON(data: data) else {return}
                self.setupUserInfo(json: json)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler) {
        
        
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            //same as create user
            if response.result.error == nil {
                
                guard let data = response.data, let json = try? JSON(data: data) else {return}
                self.setupUserInfo(json: json)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
        
    }
    
    func setupUserInfo(json: JSON) {
        // switched from data to json because of the new throw
        let id = json["_id"].stringValue
        let color = json["avatarColor"].stringValue
        let avatarName = json["avatarName"].stringValue
        let email = json["email"].stringValue
        let name = json["name"].stringValue
        
        
        UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
        //no need to return since we are just setting new variables
    }
    
    
    //END
}



