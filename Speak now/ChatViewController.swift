//
//  ChatViewController.swift
//  Speak now
//
//  Created by Nha T.Tran on 6/11/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ChatViewController: UITableViewController {

    
    @IBOutlet var table: UITableView!
    
    var contactList:[Contact] = [Contact]()
    
    var img: UIImage?
    var selectedIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMessage()
        //self.initAvatar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadMessage(){
        
        if let user = Auth.auth().currentUser{
            
            let queryRef = Database.database().reference().child("message/private").observe(.value, with: { (snapshot) -> Void in
                
                self.contactList.removeAll()
                
                for item in snapshot.children {
                    let receiveUser = item as! DataSnapshot
                    let uid = receiveUser.key
                    
                    if uid.range(of:user.uid) != nil{
                        
                        let listId = uid.components(separatedBy: " ")
                        
                        if listId[0] != user.uid{
                            self.retrieveUser(id: listId[0])
                        }else{
                            self.retrieveUser(id: listId[1])
                        }
                        
                    }
                    
                    
                }
            })
            
        }
        
    }
    
    func retrieveUser(id:String){
        var username:String = "no name"
        
       Database.database().reference().child("user_profile").observeSingleEvent(of: .value, with:{ (snapshot) in
        
        for item in snapshot.children {
            let receiveUser = item as! DataSnapshot
            let uid = receiveUser.key
            let userDict = receiveUser.value as! [String:AnyObject]
            
            if  uid == id {
                let username = userDict["username"] as! String
                let url = userDict["profile_pic"]

                if let imgUrl =  URL(string: url as! String){

                    let data = try? Data(contentsOf: imgUrl)
                    
                    if let imageData = data {
                        let profilePic = UIImage(data: data!)
                        let avatar = profilePic
                        if self.checkExist(id: id) == false{
                            self.contactList.append(Contact(name:username,id: uid,avatar: avatar!))
                        }
                        self.table.reloadData()
                        //self.img = profilePic

                        
                    }else{
                        let avatar = UIImage(named:"sample.jpg")
                        if self.checkExist(id: id) == false{
                            self.contactList.append(Contact(name:username,id: uid,avatar: avatar!))
                        }
                        self.table.reloadData()
                        //self.img = profilePic
                        
                    }
                    
                    
                }
                else {
                    let avatar = UIImage(named:"sample.jpg")
                    if self.checkExist(id: id) == false{
                        self.contactList.append(Contact(name:username,id: uid,avatar: avatar!))
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ContactTableViewCell

        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor

        cell.avatar.image = contactList[indexPath.row].avatar
        cell.txtName.text = contactList[indexPath.row].name
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = contactList.count - 1 - indexPath.row
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "SegueDetailChat"){
            let des = segue.destination as! DetailChatViewController
            des.currentContact = contactList[selectedIndex]
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
