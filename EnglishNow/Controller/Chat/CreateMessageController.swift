//
//  CreateMessageController.swift
//  EnglishNow
//
//  Created by IceTeaViet on 6/13/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateMessageController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: -declare
    var messages = [Message]()
    var avatar: UIImage?
    var id: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 58, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ChatMessageCell.self, forCellWithReuseIdentifier: cellId)
        
        
        //handle event click on anywhere in collectionview to disappear keyboard
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.collectionView?.backgroundView = UIView(frame:(self.collectionView?.bounds)!)
        self.collectionView?.backgroundView!.addGestureRecognizer(tapGestureRecognizer)
        
        setupInputComponents()
        loadMessage()
    }
    
    func handleTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    // MARK: -Collectionview datasource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatMessageCell
        
        let message = messages[indexPath.item]

        
        //if the message is of other user
        if message.fromId != Auth.auth().currentUser?.uid{
            cell.bubbleView.backgroundColor = UIColor(red:229/255, green: 232/255, blue:232/255, alpha: 1.0)
            cell.textView.textColor = UIColor.black
            cell.bubbleViewRightAnchor?.isActive = false
            cell.bubbleViewLeftAnchor?.isActive = true
            cell.profileImageView.isHidden = false
            cell.profileImageView.image = avatar
            
        }
            //if the message is of current user
        else {
            cell.bubbleView.backgroundColor = UIColor(red:30/255, green: 136/255, blue: 229/255, alpha: 1.0)
            cell.textView.textColor = UIColor.white
            cell.bubbleViewRightAnchor?.isActive = true
            cell.bubbleViewLeftAnchor?.isActive = false
            cell.profileImageView.isHidden = true
        }

        cell.textView.text = message.text

        
        //edit width of message to fit the content
        cell.bubbleWidthAnchor?.constant = estimateFrameForText(message.text!).width + 32
        
        return cell
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 80
        
        //get estimated height somehow????
        if let text = messages[indexPath.item].text {
            height = estimateFrameForText(text).height + 20
        }
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
        
    }
    
    
    
    
    // MARK: -setup view
    
    //handle event scroll to show from the last item up
    func viewScrollButton() {
        let lastItem = collectionView(self.collectionView!, numberOfItemsInSection: 0) - 1
        if (lastItem >= 0){
            let indexPath: IndexPath = IndexPath.init(item: lastItem, section: 0) as IndexPath
            print("lastItem: \(indexPath.row)")
            self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter message..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.white
        textField.delegate = self
        return textField
    }()
    
    lazy var inputNewContactTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "To: Enter username..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.white
        textField.delegate = self
        return textField
    }()
    
    let cellId = "cellId"
    

    fileprivate func estimateFrameForText(_ text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
    func setupInputComponents() {
        
        let containerToContactView = UIView()
        containerToContactView.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor
        containerToContactView.layer.borderWidth = 1.0
        containerToContactView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerToContactView)
        
        containerToContactView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerToContactView.topAnchor.constraint(equalTo: view.topAnchor , constant: 60).isActive = true
        containerToContactView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerToContactView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        containerToContactView.addSubview(inputNewContactTextField)
        inputNewContactTextField.leftAnchor.constraint(equalTo: containerToContactView.leftAnchor, constant: 8).isActive = true
        inputNewContactTextField.centerYAnchor.constraint(equalTo: containerToContactView.centerYAnchor).isActive = true
        inputNewContactTextField.rightAnchor.constraint(equalTo: containerToContactView.rightAnchor).isActive = true
        inputNewContactTextField.heightAnchor.constraint(equalTo: containerToContactView.heightAnchor).isActive = true

        
        
        let containerView = UIView()
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor

        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        //ios9 constraint anchors
        //x,y,w,h
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant: -40.0).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let sendButton = UIButton(type: .system)
        sendButton.backgroundColor = UIColor.blue
        sendButton.setTitle("Send", for: UIControlState())
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        containerView.addSubview(sendButton)
        //x,y,w,h
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        containerView.addSubview(inputTextField)
        //x,y,w,h
        inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        let separatorLineView = UIView()
        separatorLineView.backgroundColor = UIColor(red: 220, green: 220, blue: 220, alpha: 1.0)
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(separatorLineView)
        //x,y,w,h
        separatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        separatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        separatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: -load data
    func loadMessage(){
        
        if let user = Auth.auth().currentUser{
            
            let queryRef = Database.database().reference().child("message/private").observe(.value, with: { (snapshot) -> Void in
                
                //got to each message
                for item in snapshot.children {
                    let message = item as! DataSnapshot
                    let uid = message.key
                    
                    //if key has id of user
                    if uid.range(of:user.uid) != nil{
                        
                        //separate into user's id and other user's id
                        let listId = uid.components(separatedBy: " ")
                        
                        //if other user is the user whose username is input username
                        if listId[0] == self.id || listId[1] == self.id{
                            
                            self.messages.removeAll()
                            
                            let temp = message.value as! [String:AnyObject]
                            
                            let numberMessage = temp.count
                            
                            var count = 1
                            
                            for msg in message.children{
                                
                                if count < numberMessage{
                                
                                    let userDict = (msg as! DataSnapshot).value as! [String:AnyObject]
                                
                                    if userDict.count >= 3{
                                        let sender = userDict["sender"] as! String
                                        let text = userDict["text"] as! String
                                        let time = userDict["time"] as! TimeInterval
                                    
                                        self.messages.append(Message(fromId: sender, text: text, timestamp: time))
                                        self.collectionView?.reloadData()
                                        self.viewScrollButton()
                                    }
                                    
                                    count += 1
                                
                                }
                            }
                            
                            
                            
                        }
                        
                    }
                    
                    
                }
            })
            
        }
        
    }
    
    //MARK: -handle send message event
    func handleSend() {
        
        if inputNewContactTextField.text == ""{
            let alert = UIAlertController(title: "Error", message: "Must enter receive's username!", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
                alert.dismiss(animated: true, completion: nil)
            })
            present(alert, animated: true, completion: nil)
            
        } else {
            
            Database.database().reference().child("user_profile").observeSingleEvent(of: .value, with:{ (snapshot) in
                
                var done:Int = 0
                
                //go to each user
                for item in snapshot.children {
                    let receiveUser = item as! DataSnapshot
                    let userDict = receiveUser.value as! [String:AnyObject]
                    
                    
                    let _username = userDict["username"] as! String
                    let url = userDict["profile_pic"]
                    
                    if let url = userDict["profile_pic"] {
                        if let imgUrl =  URL(string: url as! String){
                            let data = try? Data(contentsOf: imgUrl)
                            
                            if let imageData = data {
                                let profilePic = UIImage(data: data!)
                                self.avatar = profilePic
                            }
                            
                        }
                        
                        
                    }
                    
                    
                    //find user whose username is the input username
                    if _username.caseInsensitiveCompare(self.inputNewContactTextField.text!) == ComparisonResult.orderedSame{
                        
                        //get id of this user
                        self.id = receiveUser.key as! String
                        
                        //send message
                        self.saveMessage(receiceId: self.id)
                        
                        //reload collectionview
                        self.collectionView?.reloadData()
                        done = 1
                    }
                    
                }
                
                if done == 0{
                    
                    var username:String = self.inputNewContactTextField.text!
                    
                    let alert = UIAlertController(title: "Error", message: "Username: \(username) is not exist!", preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
                        alert.dismiss(animated: true, completion: nil)
                    })
                    self.present(alert, animated: true, completion: nil)
                }
                self.collectionView?.reloadData()
                
            })
            
        }
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSend()
        return true
    }
    

    
    func saveMessage(receiceId: String){
        
        let user = Auth.auth().currentUser
        
        //create key of message
        var child : String?
        if (user?.uid)! > receiceId{
            child = (user?.uid)! + " " +  receiceId
        }else{
            child = receiceId + " " + (user?.uid)!
        }
        
        //save message
        let userRef = Database.database().reference().child("message").child("private").child(child!)
        
        //save the lastest message
        userRef.child("lastest_text").setValue(inputTextField.text)
        
        let childRef = userRef.childByAutoId()
        if (user?.uid)! != nil && inputTextField.text != nil && Date.timeIntervalBetween1970AndReferenceDate != nil{
            childRef.child("sender").setValue((user?.uid)!)
            childRef.child("text").setValue(inputTextField.text)
            childRef.child("time").setValue(Date.timeIntervalBetween1970AndReferenceDate)
          
        }
        
        self.messages.removeAll()
        inputTextField.text = ""
        
    }
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}
