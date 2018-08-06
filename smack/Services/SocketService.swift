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
    

}
