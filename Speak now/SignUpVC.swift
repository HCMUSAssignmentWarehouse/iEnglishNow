//
//  SignUpVC.swift
//  Speak now
//
//  Created by Nha T.Tran on 5/20/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SignUpVC: UIViewController {

    
    @IBAction func btnDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var registerView: UIView!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    
    @IBOutlet weak var txtPassword: UITextField!
    
    
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    @IBOutlet var txtUsername: UITextField!
    
    @IBOutlet var txtError: UILabel!
    
    
    @IBOutlet var btnSignUp: UIButton!
    
    
    @IBAction func btnSignUp(_ sender: Any) {
        
        if txtPassword.text != txtConfirmPassword.text{
            txtError.text = "Cofirm password must be equal to password!"
        }
        else{
            if let email = txtEmail.text, let password = txtPassword.text{
                Auth.auth().createUser(withEmail: email,password:password,completion:{user,error in
                    if let firebaseError = error{
                        print(firebaseError.localizedDescription)
                        return
                    }
                    
                    let userRef = Database.database().reference().child("user_profile").child((user?.uid)!)
                    userRef.child("username").setValue(self.txtUsername.text)
                    userRef.child("email").setValue(self.txtEmail.text)
                    userRef.child("password").setValue(self.txtPassword.text)
                    print("Success!")
                    
                    self.dismiss(animated: true, completion: nil)
                })
            }
            else {
                print("Email or password is invalid!")
                self.txtError.text = "Email or password is invalid!"
            }

        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initShow()
        // Do any additional setup after loading the view.
    }

    func initShow(){
        registerView.layer.cornerRadius = 5
        txtEmail.layer.cornerRadius = 5
        txtEmail.layer.borderWidth = 1
        txtEmail.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor
        txtPassword.layer.cornerRadius = 5
        txtPassword.layer.borderWidth = 1
        txtPassword.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor
        txtPassword.isSecureTextEntry = true

        txtUsername.layer.cornerRadius = 5
        txtUsername.layer.borderWidth = 1
        txtUsername.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor
        txtUsername.isSecureTextEntry = true
        
        txtConfirmPassword.layer.cornerRadius = 5
        txtConfirmPassword.layer.borderWidth = 1
        txtConfirmPassword.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor
        txtConfirmPassword.isSecureTextEntry = true

    
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
