//
//  MyConversationVC.swift
//  EnglishNow
//
//  Created by IceTeaViet on 5/21/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import UIKit

class MyConversationVC: UIViewController,UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet var btnMenu: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initShow()
        
        if  revealViewController() != nil {
            btnMenu.target = self.revealViewController()
            btnMenu.action = "revealToggle:"
            
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }
        
        // Do any additional setup after loading the view.
    }
    
    func initShow(){
        table.delegate = self
        table.dataSource = self
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath ) as! ConversationCellVCTableViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 213/255,green: 216/255,blue: 220/255,alpha: 1.0).cgColor
        cell.layer.cornerRadius = 15
        //cell.textLabel?.text = "a"
        return cell
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
