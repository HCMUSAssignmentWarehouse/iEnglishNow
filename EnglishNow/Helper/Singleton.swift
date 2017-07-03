//
//  Singleton.swift
//  EnglishNow
//
//  Created by GeniusDoan on 6/29/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation

class Singleton{
    static let sharedInstance = Singleton()
    var partner: User!
    var tabBarController:UITabBarController!
    var tokBoxSessionId: String!
    var tokBoxApiKey: String! = "45900432"
    var conversationViewController: MyConversationVC?
    var chatViewController: ChatViewController?
    var matchViewController: MatchViewController?
    var timelineViewController: HomeTimeLineVC?
    
    /*
    func reloadProfileHistory() {
        if let hvc = historyViewController {
            hvc.historyTableView.reloadData()
        }
        
        if let pvc = profileViewController {
            pvc.profileTableView.reloadData()
        }
    }
     */
    
    fileprivate init(){
        partner = User()
        createTabbar()
    }
    
    static let skills:[String] = ["Listening", "Pronounciation", "Fluency", "Vocabulary"]
    
    
    fileprivate func createTabbar(){
        let mainStoryboard = UIStoryboard(name: "MainScreen", bundle: nil)
        
        matchViewController = mainStoryboard.instantiateViewController(withIdentifier: "MatchViewController") as! MatchViewController
        
        chatViewController = mainStoryboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        
        timelineViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeTimeLine") as! HomeTimeLineVC
        
        conversationViewController = mainStoryboard.instantiateViewController(withIdentifier: "ConversationViewController") as! MyConversationVC
        
        
        tabBarController = mainStoryboard.instantiateViewController(withIdentifier: "TabBar") as!UITabBarController
    }
    
    static func getTabbar() -> UITabBarController{
        if sharedInstance.tabBarController == nil {
            sharedInstance.createTabbar()
        }
        return sharedInstance.tabBarController
    }
}
