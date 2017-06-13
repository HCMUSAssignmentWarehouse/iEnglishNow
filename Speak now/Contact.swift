//
//  Contact.swift
//  Speak now
//
//  Created by Nha T.Tran on 6/11/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import Foundation
import UIKit
class Contact {
    
    private var _name = "";
    private var _id = "";
    private var _avatar:UIImage?
    
    public init(name: String, id:String, avatar: UIImage){
        self._id = id;
        self._name = name;
        self._avatar = avatar
    }
    
    
    var name: String{
        get{
            return _name;
        }
    }
    
    var id:String{
        return _id;
    }
    
    var avatar:UIImage{
        return _avatar!
    }
}
