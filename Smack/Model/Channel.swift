//
//  Channel.swift
//  Smack
//
//  Created by DokeR on 22.08.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import Foundation

//May be Channel: Decodable for automatic work with JSON
//vars have to be named exactly as in JSON file

struct Channel {
    public private(set) var channelTitle: String!
    public private(set) var channelDescription: String!
    public private(set) var id: String!
}
