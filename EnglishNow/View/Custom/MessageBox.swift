//
//  MessageBox.swift
//  EnglishNow
//
//  Created by GeniusDoan on 6/28/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation
import SwiftMessages

class MessageBox {
    class func show(body: String) {
        let view = MessageView.viewFromNib(layout: .StatusLine)
        view.configureTheme(.success)
        view.configureContent(body: body)
        SwiftMessages.show(view: view)
    }
    
    class func warning(body: String) {
        let view = MessageView.viewFromNib(layout: .StatusLine)
        view.configureTheme(.warning)
        view.configureContent(body: body)
        SwiftMessages.show(view: view)
    }
    
    class func error(body: String) {
        let view = MessageView.viewFromNib(layout: .StatusLine)
        view.configureTheme(.error)
        view.configureContent(body: body)
        SwiftMessages.show(view: view)
    }
    
    class func info(body: String) {
        let view = MessageView.viewFromNib(layout: .StatusLine)
        view.configureTheme(.info)
        view.configureContent(body: body)
        SwiftMessages.show(view: view)
    }
}
