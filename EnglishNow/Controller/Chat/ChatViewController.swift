//
//  ChatViewController.swift
//  EnglishNow
//
//  Created by IceTeaViet on 6/11/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ChatViewController: UITableViewController {

    
    // MARK: declare and hanlde click event
    @IBOutlet var btnMenu: UIBarButtonItem!
    
    @IBOutlet var table: UITableView!
    
    var contactList:[Contact] = [Contact]()
    
    var img: UIImage?
    var selectedIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMessage()
        if  revealViewController() != nil {
            btnMenu.target = self.revealViewController()
            btnMenu.action = "revealToggle:"
            
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: load data to show on screen
    func loadMessage(){
        
        if let user = Auth.auth().currentUser{
            
            let queryRef = Database.database().reference().child("message/private").observe(.value, with: { (snapshot) -> Void in
                
                self.contactList.removeAll()
                
                //go to each message
                for item in snapshot.children {
                    let message = item as! DataSnapshot
                    
                    let uid = message.key
                    
                    //if message is between current user and other
                    if uid.range(of:user.uid) != nil{
                        

                        let temp = message.value as! [String:AnyObject]
                        let lastestText = temp["lastest_text"] as! String
                        
                        

                        let listId = uid.components(separatedBy: " ")
                        if listId[0] != user.uid{                            
                            
                            self.retrieveUser(id: listId[0] , lastestText: lastestText)
                        }else{
                            self.retrieveUser(id: listId[1] , lastestText: lastestText)
                        }
                        
                    }
                    
                    
                }
            })
            
        }
        
    }
    
    func retrieveUser(id:String , lastestText: String){
        var username:String = "no name"
        
       Database.database().reference().child("user_profile").observeSingleEvent(of: .value, with:{ (snapshot) in
        
        //go to each user
        for item in snapshot.children {
            let receiveUser = item as! DataSnapshot
            let uid = receiveUser.key
            let userDict = receiveUser.value as! [String:AnyObject]
            
            //find profile of user in message with current user
            if  uid == id {
                let username = userDict["username"] as! String
                let url = userDict["profile_pic"]

                if let imgUrl =  URL(string: url as! String){

                    let data = try? Data(contentsOf: imgUrl)
                    
                    if let imageData = data {
                        let profilePic = UIImage(data: data!)
                        let avatar = profilePic
                        if self.checkExist(id: id) == false{
                            self.contactList.append(Contact(name:username,id: uid,avatar: avatar! , lastestText: lastestText))
                        }
                        self.table.reloadData()
                        
                    }else{
                        
                        //set default image for avatar
                        let avatar = UIImage(named:"sample.jpg")
                        if self.checkExist(id: id) == false{
                            self.contactList.append(Contact(name:username,id: uid,avatar: avatar! , lastestText: lastestText))
                        }
                        self.table.reloadData()
                    }
                    
                    
                }
                else {
                    let avatar = UIImage(named:"sample.jpg")
                    if self.checkExist(id: id) == false{
                        self.contactList.append(Contact(name:username,id: uid,avatar: avatar! , lastestText: lastestText))
                    }
                    self.table.reloadData()
                    //self.img = profilePic
                }
            }
        }

       })
        
    }
    
    
    func checkExist(id: String) -> Bool{
        
        for item in self.contactList{
            if item.id == id{
                return true
            }
        }
        return false
    }
  
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contactList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ContactCell

        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor

        cell.avatar.image = contactList[indexPath.row].avatar
        cell.txtName.text = contactList[indexPath.row].name
        cell.txtContent.text = contactList[indexPath.row].lastestText
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
    }
    
    
   
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "SegueDetailChat"){
            let des = segue.destination as! DetailChatViewController
            des.currentContact = contactList[selectedIndex]
        }
        

    }
    
}
