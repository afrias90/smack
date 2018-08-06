//
//  SocketService.swift
//  smack
//
//  Created by Adolfo Frias on 8/5/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    static let instance = SocketService()
    
    //NSOBject; needs an initializer
    override init() {
        super.init()
    }
    
    var socket : SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        //newChannel is the identifier in the API, order matters as well
        //socket.emit: sends out changes
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    //place this where you want to listen for this: channelVC
    func getChannel(completion: @escaping CompletionHandler) {
        //SocketACKEmitter: ACK = acknowledgement
        //socket.on: listens to changes
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDes = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDes, id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        
        //some infor we get from creating the message, and other from the user itself
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
        
    }
    
    
    func getChatMessage(completion: @escaping CompletionHandler) {
        //do check that selected channel id matches, so we don't get messages from other channels
        socket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            guard let userName = dataArray[3] as? String else {return}
            guard let userAvatar = dataArray[4] as? String else {return}
            guard let userAvatarColor = dataArray[5] as? String else {return}
            guard let id = dataArray[6] as? String else {return}
            guard let timeStamp = dataArray[7] as? String else {return}
            
            if channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                let newMessage = Message(message: msgBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                MessageService.instance.messages.append(newMessage)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    

}
