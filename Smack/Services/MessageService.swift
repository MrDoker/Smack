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
                            let id = item["id"].string
                            self.channels.append(Channel(channelTitle: name, channelDescription: channelDiscription, id: id))
                            completion(true)
                        }
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
    
}
