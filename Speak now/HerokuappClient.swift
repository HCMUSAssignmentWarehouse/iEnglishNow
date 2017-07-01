//
//  HerokuappClient.swift
//  Speak now
//
//  Created by GeniusDoan on 6/29/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import Foundation
import AFNetworking

struct URLServer {
    static let base : String = "https://englishnow.herokuapp.com"
    static let createSession : String = "session"
}

class SessionSponse {
    var apiKey: String
    var session: String
    var token: String
    
    init(data : [String: AnyObject]) {
        apiKey = data["apiKey"] as! String
        session = data["sessionId"] as! String
        token = data["token"] as! String
    }
}

class HerokuappClient: AFHTTPSessionManager {
    static var shared = HerokuappClient(baseURL: URL(string: URLServer.base))
    
    func getSessionDeprecated(complete: @escaping ([String: String]?, Error?) -> Void) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let url = baseURL?.appendingPathComponent(URLServer.createSession)
       
        let dataTask = session.dataTask(with: url!) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            guard error == nil, let data = data else {
                print(error!)
                complete(nil, error)
                return
            }
            
            let dict = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyHashable: Any]
        
            Singleton.sharedInstance.tokBoxApiKey = dict?["apiKey"] as? String ?? ""
            var sessionId : String = dict?["sessionId"] as? String ?? ""
            var token : String = dict?["token"] as? String ?? ""
            complete([sessionId : token], nil)
        }
        dataTask.resume()
        session.finishTasksAndInvalidate()
    }
    
    func getSession(complete: @escaping ([String: String]?, Error?) -> Void) {
        get(URLServer.createSession, parameters: nil, progress: nil, success: { (task, response) in
            if let dictionary = response as? [String: String] {
                complete(dictionary, nil)
            }
        }) { (task, error) in
            complete(nil, error)
        }
    }
}
