//
//  LoadingViewController.swift
//  EnglishNow
//
//  Created by GeniusDoan on 7/3/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class LoadingViewController: UIViewController {
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.startAnimating()
        UIView.animate(withDuration: 0.5, animations: {
            self.logoLabel.transform = CGAffineTransform(translationX: 0, y: -40)
            self.sloganLabel.transform = CGAffineTransform(translationX: 0, y: -40)
        }, completion: {finished in
            UIView.animate(withDuration: 0.3, animations: {
                self.loadingIndicator.layer.opacity = 1
            })
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            // Put your code which should be executed with a delay here
            if Auth.auth().currentUser != nil {
                self.handleAuthUser(user: Auth.auth().currentUser!)
            } else {
                Auth.auth().addStateDidChangeListener({auth, user in
                    if let user = user {
                        //User is signed in
                        self.handleAuthUser(user: user)
                    }
                    else {
                        //No user is signed in
                        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
                        (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = nextVC
                    }
                })
            }
        })
    }
    
    
    func handleAuthUser(user: Firebase.User) {
        User.current.uid = user.uid
        User.current.type = UserType.learner //TODO: Change to multi-role
        User.current.email = user.email
        
        FirebaseClient.shared.loadUserSpeaker(completion: { (exist) in
            if !exist {
                FirebaseClient.shared.saveUserData()
            }
        })
        
        FirebaseClient.shared.handleReviews()
        var storyboard = UIStoryboard(name: "MainScreen", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainScreenVC") as UIViewController
        self.present(controller, animated: true, completion: nil)
    }
}
