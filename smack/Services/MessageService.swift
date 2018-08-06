//
//  MessageService.swift
//  smack
//
//  Created by Adolfo Frias on 8/4/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class MessageService {
    
    static let instance  = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannel : Channel?
    
    
    func findAllChannel(completion: @escaping CompletionHandler) {
        //get request, don't need to pass anything
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                //array of json objects
                
                do {
                    guard let json = try JSON(data: data).array else {return}
                    for item in json {
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                        self.channels.append(channel)
                        
                    }
                } catch {
                    
                }
                NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                completion(true)

            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
            print(self.channels)
        }
    }
    
    func findAllMessageForChannel(channelId: String, completion: @escaping CompletionHandler) {
        //channeId is in the 
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                //clears out previous messages if any
                self.clearMessage()
                
                guard let data = response.data else {return}
                
                do {
                    guard let json = try JSON(data: data).array else {return}
                    for item in json {
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let id = item["_id"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                        
                        self.messages.append(message)
                        
                    }
                    
                } catch {
                    print("We have an error obtaining messages")
                }
                
                
                
                
                completion(true)
                
            } else {
                debugPrint(response.error as Any)
                print("find all messages")
                completion(false)
            }
        }
    }
    
    
    func clearChannels() {
        channels.removeAll()
    }
    
    func clearMessage() {
        messages.removeAll()
    }
    
}
