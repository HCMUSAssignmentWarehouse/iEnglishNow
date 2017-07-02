//
//  MessageBox.swift
//  EnglishNow
//
//  Created by GeniusDoan on 6/28/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation
import SwiftMessages

class SystemMessage {
    class func show(body: String) {
        let view = MessageView.viewFromNib(layout: .StatusLine)
        view.configureTheme(.success)
        view.configureContent(body: body)
        SwiftMessages.show(view: view)
    }
}
