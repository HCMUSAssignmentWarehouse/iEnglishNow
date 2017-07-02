//
//  ViewController.swift
//  Speak now
//
//  Created by Nha T.Tran on 5/18/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    
    // MARK: -declare and hanlde click event
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var loginview: UIView!
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet var txtError: UILabel!
    
    
    @IBAction func Login(_ sender: UIButton) {
        if let email = txtName.text , let password = txtPassword.text {
            ProgressHUD.show(view: view)
            
            FirebaseClient.shared.signIn(email: email, password: password, completion: {(user, error) in
                
                if let firebaseError = error {
                    ProgressHUD.hide(view: self.view)
                    self.txtError.text = firebaseError.localizedDescription
                    return
                }

                if user != nil {
                    Singleton.sharedInstance.partner.type = UserType.learner
                    DataUtils.saveUser()
                    FirebaseClient.shared.handleReviews()
                    print("Login Success!")
                    ProgressHUD.hide(view: self.view)
                    self.performSegue(withIdentifier: "LoginSuccessSegue", sender: self)
            } else {
                    ProgressHUD.hide(view: self.view)
                    let alert = UIAlertController(title: "Error", message: "Invalid email or password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
        else {
            ProgressHUD.hide(view: self.view)
            txtError.text = "Email or password is invalid!"
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtPassword.isSecureTextEntry = true
        
        loginview.layer.cornerRadius = 5
        loginview.layer.borderWidth = 1
        loginview.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor
        
        passwordView.layer.cornerRadius = 5
        passwordView.layer.borderWidth = 1
        passwordView.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor

        txtName.becomeFirstResponder()
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

