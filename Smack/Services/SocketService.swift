//
//  SocketService.swift
//  Smack
//
//  Created by DokeR on 22.08.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    static let instance = SocketService()
    
    override init() {
        super.init()
    }

     //var socket : SocketIOClient = SocketIOClient(socketURL: URL(string: baseUrlString)!)
    var socketManager = SocketManager(socketURL: URL(string: baseUrlString)!)
    
    func establishConnection() {
        socketManager.defaultSocket.connect()
    }
    
    func closeConnection() {
        socketManager.defaultSocket.disconnect()
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        //socketManager.emitAll("newChannel", channelName, channelDescription)
        socketManager.defaultSocket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        socketManager.defaultSocket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDescription = dataArray[1] as? String else {return}
            guard let channelID = dataArray[2] as? String else {return}
            
            let channel = Channel(channelTitle: channelName, channelDescription: channelDescription, id: channelID)
            MessageService.instance.channels.append(channel)
            completion(true)
        }
    }
    
}




















