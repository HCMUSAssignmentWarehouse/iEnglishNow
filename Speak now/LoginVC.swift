//
//  ViewController.swift
//  Speak now
//
//  Created by Nha T.Tran on 5/18/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var loginview: UIView!
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet var txtError: UILabel!
    
    
    @IBAction func Login(_ sender: UIButton) {
        //self.performSegue(withIdentifier: "LoginSuccessSegue", sender: self)
        if let email = txtName.text , let password = txtPassword.text{
            Auth.auth().signIn(withEmail: email,password:password,completion:{uer,error in
            if let firebaseError = error{
                    self.txtError.text = firebaseError.localizedDescription
                    return
                }
                print("Login Success!")
                self.performSegue(withIdentifier: "LoginSuccessSegue", sender: self)                

            })
        }
        else {
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

    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

