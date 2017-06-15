//
//  CreateNewPostController.swift
//  Speak now
//
//  Created by Nha T.Tran on 6/14/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateNewPostController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    
    @IBOutlet var avatar: UIImageView!
    
    @IBOutlet var username: UILabel!
    
    @IBOutlet var txtContent: UITextField!
    
    @IBOutlet var viewAddPhoto: UIView!
    
    @IBOutlet var btnAddPhoto: UIImageView!
    
    
    @IBOutlet var choosenImage: UIImageView!
    
    @IBOutlet var viewInput: UIView!
    
    var selectedImageFromPicker: UIImage?

    var avatarUrl: String?
    
    @IBAction func btnPost(_ sender: UIBarButtonItem) {
        
        if txtContent.text != ""{
            let userRef = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid)
            
            var databaseRef = Database.database().reference()
            var storageRef = Storage.storage().reference()
            var currentUser = Auth.auth().currentUser
            
            if selectedImageFromPicker != nil {
                if let imageData:NSData = UIImagePNGRepresentation(selectedImageFromPicker!)! as NSData?{
                    let profilePicStorageRef = storageRef.child("user_profiles/\(currentUser?.uid)/profile_pic")
                    let uploadTask = profilePicStorageRef.putData(imageData as Data, metadata:nil){metadata, error in
                        if (error == nil){
                            let downloadUrl = metadata?.downloadURL()
                            
                            //save to status root
                            let statusRef = databaseRef.child("status").childByAutoId()
                            
                            statusRef.child("photo").setValue(downloadUrl?.absoluteString)
                            statusRef.child("user").setValue(currentUser?.uid)
                            statusRef.child("content").setValue(self.txtContent.text)
                            statusRef.child("time").setValue(Date.timeIntervalBetween1970AndReferenceDate)
                            statusRef.child("like_number").setValue(0)
                            statusRef.child("isUserLiked").setValue(false)
                            
                            //save to user_root
                            let userRef = databaseRef.child("user_profile").child((currentUser?.uid)!).child("status").childByAutoId()
                            userRef.child("photo").setValue(downloadUrl?.absoluteString)
                            userRef.child("content").setValue(self.txtContent.text)
                            userRef.child("time").setValue(Date.timeIntervalBetween1970AndReferenceDate)
                            userRef.child("like_number").setValue(0)
                            userRef.child("isUserLiked").setValue(false)

                            self.performSegue(withIdentifier: "SegueAfterPost", sender: nil)
                            print("post success!")
                        }else{
                            print(error?.localizedDescription)
                        }
                    }
                }

            }else{
                let statusRef = databaseRef.child("status").childByAutoId()
                
                statusRef.child("photo").setValue("")
                statusRef.child("user").setValue(currentUser?.uid)
                statusRef.child("content").setValue(self.txtContent.text)
                statusRef.child("time").setValue(Date.timeIntervalBetween1970AndReferenceDate)
                statusRef.child("like_number").setValue(0)
                statusRef.child("isUserLiked").setValue(false)
                statusRef.child("username").setValue(username.text)
                statusRef.child("avatar").setValue(avatarUrl)
                
                
                let userRef = databaseRef.child("user_profile").child((currentUser?.uid)!).child("status").childByAutoId()
                userRef.child("photo").setValue("")
                userRef.child("content").setValue(self.txtContent.text)
                userRef.child("time").setValue(Date.timeIntervalBetween1970AndReferenceDate)
                userRef.child("like_number").setValue(0)
                userRef.child("isUserLiked").setValue(false)
                
                self.performSegue(withIdentifier: "SegueAfterPost", sender: nil)

                print("post success!")

            }
            
            
        }
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initShow()
        initUser()
        // Do any additional setup after loading the view.
    }

    func initShow(){
                
        viewInput.layer.borderWidth = 1
        viewInput.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor
        
        viewAddPhoto.layer.borderWidth = 1
        viewAddPhoto.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor
        
    }
    
    func initUser(){
        
        let user = Auth.auth().currentUser
        
        Database.database().reference().child("user_profile").child((user?.uid)!).observeSingleEvent(of: .value, with:{ (snapshot) in
            
            let userDict = snapshot.value as! [String:AnyObject]
                
            let _username = userDict["username"] as! String
            let url = userDict["profile_pic"]
            self.avatarUrl = url as! String?
            let imgUrl =  URL(string: url as! String)
            let data = try? Data(contentsOf: imgUrl!)
                    
            if let imageData = data {
                let profilePic = UIImage(data: data!)
                self.avatar.image = profilePic
                        
            }
            self.username.text = _username
                    
            
        })
        
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let editedimage = info["UIImagePickerControllerEditedImage"]{
            selectedImageFromPicker = editedimage as! UIImage
            print("edited!")
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"]{
            selectedImageFromPicker = originalImage as! UIImage
            print("original!")
        }
        
        if (selectedImageFromPicker != nil) {
            
            self.choosenImage.image = selectedImageFromPicker
        }
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel!")
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
