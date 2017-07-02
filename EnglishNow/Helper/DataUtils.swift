//
//  DataUtils.swift
//  EnglishNow
//
//  Created by GeniusDoan on 6/29/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation

class DataUtils {
    static let key = "user_archived"
    static var userDefaults = UserDefaults.standard
    
    class func saveUser() {
        let data = NSKeyedArchiver.archivedData(withRootObject: User.current)
        userDefaults.set(data, forKey: key)
        userDefaults.synchronize()
    }
    
    class func loadUser() -> Bool {
        let data = userDefaults.object(forKey: key) as? Data
        print("defaults: \(data)")
        if let user = data {
            User.current = NSKeyedUnarchiver.unarchiveObject(with: user) as! User
            return true
        }
        
        return false
    }
}
