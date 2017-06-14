//
//  Status.swift
//  Speak now
//
//  Created by Nha T.Tran on 6/14/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import Foundation
class Status {
    
    var user: String?
    var content: String?
    var time: TimeInterval?
    var photo: String?
    var likeNumber: Int?
    var isUserLiked: Bool?
    
    init(user:String, content: String, time: TimeInterval, photo: String, likeNumber: Int, isUserLiked: Bool){
        self.user = user
        self.content = content
        self.time = time
        self.photo = photo
        self.likeNumber = likeNumber
        self.isUserLiked = isUserLiked
    }
    
}
