//
//  Comment.swift
//  EnglishNow
//
//  Created by Nha T.Tran on 6/20/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation

class Comment {

    var userId: String?
    var username: String?
    var avatar: UIImage?
    var content: String?
    var commentId:String?
    var time: TimeInterval?
    
    init(userId: String, username: String ,avatar: UIImage, content: String ,commentId:String , time: TimeInterval) {
        self.userId = userId
        self.username = username
        self.avatar = avatar
        self.content = content
        self.commentId = commentId
        self.time = time
    }
    
}

