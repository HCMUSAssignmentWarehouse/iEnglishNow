//
//  ProgressHUD.swift
//  EnglishNow
//
//  Created by GeniusDoan on 6/28/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation
import MBProgressHUD

class ProgressHUD: MBProgressHUD {
    class func show(view: UIView) {
        showAdded(to: view, animated: true)
    }
    
    class func hide(view: UIView) {
        hide(for: view, animated: true)
    }
}
