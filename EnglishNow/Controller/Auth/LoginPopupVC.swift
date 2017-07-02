//
//  LoginPopupVC.swift
//  EnglishNow
//
//  Created by IceTeaViet on 5/20/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase


class LoginPopupVC: UIViewController {

    
    // MARK: -declare and handle click event
    @IBOutlet var txtWelcomeName: UILabel!
    
    @IBAction func btnCancel(_ sender: Any) {
        var storyboard = UIStoryboard(name: "MainScreen", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainScreenVC") as UIViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func btnDismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var LoginSuccessView: UIView!
    
    @IBOutlet weak var AvatarView: UIView!
    
    @IBOutlet weak var avatar: UIImageView!
    
    @IBAction func btnFind(_ sender: Any) {
        
        self.performSegue(withIdentifier: "SegueFind", sender: self)
        
    }
    
   
    
    let shapeLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        initShow()
        initShowUser()
        
    }

    // MARK: -init to show
    func initShowUser(){
        if let user = Auth.auth().currentUser{
            
            let queryRef = Database.database().reference().child("user_profile/\(user.uid)").observe(.value, with: { (snapshot) -> Void in
                
                if let dictionary = snapshot.value as? [String:Any] {
                    let username = dictionary["username"] as? String ?? ""
                    self.txtWelcomeName.text = username
                    
                    if let url = dictionary["profile_pic"] {
                        if let imgUrl =  URL(string: url as! String){
                            let data = try? Data(contentsOf: imgUrl)
                            
                            if let imageData = data {
                                let profilePic = UIImage(data: data!)
                                self.avatar.image = profilePic
                            }
                            
                        }
                    
                        
                    }
                    
                    
                }
                
            })
        }
        
    }
    
    
    func initShow(){
        LoginSuccessView.layer.cornerRadius = 5
        LoginSuccessView.layer.borderWidth = 1
        LoginSuccessView.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor
        
        AvatarView.layer.borderWidth = 1
        AvatarView.layer.cornerRadius = 60
        
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = 60
        
    }
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}
