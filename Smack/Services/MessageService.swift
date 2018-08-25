//
//  MessageService.swift
//  Smack
//
//  Created by DokeR on 22.08.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messagesArray = [Message]()
    var selectedChannel: Channel?
    
    func findAllChannels(completion: @escaping CompletionHandler) {
        Alamofire.request(urlGetChannels, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: bearerHeader).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                do{
                    //self.channels = try JSONDecoder().decode([Channel]).self, from: data)
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let name = item["name"].string
                            let channelDiscription = item["description"].string
                            let id = item["_id"].string
                            self.channels.append(Channel(channelTitle: name, channelDescription: channelDiscription, id: id))
                        }
                        NotificationCenter.default.post(name: notifChannelsLoaded, object: nil)
                        completion(true)
                    }
                } catch {
                    print(error)
                    completion(false)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
    func findAllMessagesForChannel(channelID: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(urlGetMessages)\(channelID)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: bearerHeader).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                //
                self.clearMessages()
                //
                do {
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let messageBody = item["messageBody"].string
                            let channelID = item["channelId"].string
                            let id = item["_id"].string
                            let userName = item["userName"].string
                            let userAvatar = item["userAvatar"].string
                            let userAvatarColor = item["userAvatarColor"].string
                            let timeStamp = item["timeStamp"].string
                            
                            let newMessage = Message(message: messageBody, userName: userName, channelID: channelID, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                            self.messagesArray.append(newMessage)
                        }
                      completion(true)
                        //
                    print(self.messagesArray.count)
                    }
                } catch {
                    completion(false)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func clearMessages() {
        messagesArray.removeAll()
    }
    
}















