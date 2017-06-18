//
//  SlideMenuViewController.swift
//  Speak now
//
//  Created by Nha T.Tran on 6/17/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit

class SlideMenuViewController: UIViewController {

    
    @IBOutlet var avatar: UIImageView!
    
    @IBOutlet var txtUsername: UILabel!
    
    @IBOutlet var txtEmail: UILabel!
    
    @IBOutlet var btnProfile: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnProfile.layer.shadowOpacity = 1
        avatar.layer.cornerRadius = 62
        avatar.layer.masksToBounds = true
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor(red: 255, green: 111, blue: 0, alpha: 1.0).cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
