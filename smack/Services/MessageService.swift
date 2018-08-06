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
    
    func clearChannels() {
        channels.removeAll()
    }
    
}
