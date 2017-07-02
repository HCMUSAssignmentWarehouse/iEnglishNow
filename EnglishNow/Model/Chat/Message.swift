//
//  Message.swift
//  EnglishNow
//
//  Created by IceTeaViet on 6/12/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation
class Message{
    
    var fromId: String?
    var text: String?
    var timestamp: TimeInterval
    
    init(fromId: String, text: String, timestamp: TimeInterval){
        self.fromId = fromId
        self.text = text
        self.timestamp = timestamp
    }
    
}
