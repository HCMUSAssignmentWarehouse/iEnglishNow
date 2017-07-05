//
//  FirebaseClient.swift
//  EnglishNow
//
//  Created by GeniusDoan on 6/29/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation

import Firebase

class FirebaseClient {
    static var shared: FirebaseClient!
    var dataReference: DatabaseReference!
    
    class func configure() {
        FirebaseApp.configure()
        shared = FirebaseClient()
    }
    
    init() {
        dataReference = Database.database().reference()
    }
    
    func saveUserData() {
        let data = NSKeyedArchiver.archivedData(withRootObject: User.current)
        let stringData = data.base64EncodedString()
        
        DataUtils.saveUser()
        dataReference.child("data/\(User.current.uid!)").setValue(stringData)
    }
    
    func loadUserData(completion: @escaping (Bool) -> Void) {
        dataReference.child("data/\(User.current.uid!)").observeSingleEvent(of: .value, with: {(snapshot) in
            if let dataString = snapshot.value as? String, let data = NSData(base64Encoded: dataString, options: []) {
                User.current = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! User
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    func loadUserSpeaker(completion: @escaping (Bool) -> Void) {
        loadUserData(completion: {(exist) in
            if !exist {
                completion(false)
            } else {
                self.dataReference.child("user_profile/\(User.current.uid!)").observeSingleEvent(of: .value, with: {(snapshot) in
                    if let dictionary = snapshot.value as? NSDictionary {
                        
                        User.current.name = dictionary["username"] as! String
                        User.current.profilePhoto = dictionary["profile_pic"] as! String
                        print(User.current.profilePhoto)
                        completion(true)
                    }
                })
            }
        })
    }
    
    func signIn(completion: @escaping (Firebase.User?, Error?) -> Void) {
        //TODO: Support anonymously sign in
        Auth.auth().signInAnonymously(completion: { (user, error) in
            if let user = user {
                self.dataReference.child("learners/\(user.uid)").observeSingleEvent(of: .value, with: { snapshot in
                    if let value = snapshot.value as? NSObject, value is NSNull {
                        self.dataReference.child("learners/\(user.uid)").updateChildValues(["name": User.current.name])
                    }
                })
            }
            completion(user, error)
        })
    }
    
    func signIn(email: String, password: String, completion: @escaping (Firebase.User?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if let user = user {
                User.current.uid = user.uid
                User.current.type = UserType.learner //TODO: Change to multi-role
                User.current.email = email
                User.current.password = password
                self.loadUserSpeaker(completion: { (exist) in
                    if !exist {
                        self.saveUserData()
                    }
                })
                completion(user, error)
            } else {
                completion(user, error)
            }
        })
    }
    
    func signUp(email: String, password: String, userName: String, skills: [Skill], completion: @escaping (Firebase.User?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if let user = user {
                let userRef = Database.database().reference().child("user_profile").child((user.uid))
                userRef.child("username").setValue(userName)
                userRef.child("email").setValue(email)
                userRef.child("password").setValue(password)
                userRef.child("profile_pic").setValue("")
                
                
                //save stats numbers
                userRef.child("drinks").setValue(0)
                userRef.child("conversations").setValue(0)
                
                for item in skills {
                    userRef.child("skill").child(item.name).child("rate_value").setValue(0)
                }
                
                print("Success!")
                
            }
            completion(user, error)
        })
    }
   
    
    func onMatch(completion: @escaping (_ session: String, _ token: String) -> Void) {
        dataReference.child("available/learners").observeSingleEvent(of: .value, with: {snapshot in
            if snapshot.hasChildren() {
                self.onSpeakerMatch(completion: completion)
            }
            else {
                self.onLearnerMatch(completion: completion)
            }
        })
    }
    
    func onSpeakerMatch(completion: @escaping (_ session: String, _ token: String) -> Void) {
        print("on speaker match")
        handleLearnerAvailable(completion: completion)
    }
    
    func onLearnerMatch(completion: @escaping (_ session: String, _ token: String) -> Void) {
        let learnerInfo = ["uid": User.current.uid,
                           "name": User.current.name,
                           "photo": User.current.profilePhoto,
                           "rating": User.current.learnerAverageRating(),
                           "matched": false] as [String : Any]
        dataReference.child("available/learners/\(User.current.uid!)").updateChildValues(learnerInfo)
            handleSpeakerAvailable(completion: completion)
    }
    
    func handleSpeakerAvailable(completion: @escaping (_ session: String, _ token: String) -> Void) {
        dataReference.child("available/learners").child(User.current.uid).observeSingleEvent(of: .childChanged, with: { (snapshot) in
            if let sessionId = snapshot.value as? String {
                self.dataReference.child("sessions/\(sessionId)").observeSingleEvent(of: .value, with: { (snapshot) in
                    if let dictionary = snapshot.value as? NSDictionary {
                        Singleton.sharedInstance.partner.uid = dictionary["speakerUid"] as! String
                        Singleton.sharedInstance.partner.name = dictionary["speakerName"] as! String
                        Singleton.sharedInstance.partner.rating = dictionary["speakerRating"] as! Double
                        Singleton.sharedInstance.partner.profilePhoto = dictionary["speakerPhoto"] as! String
                        Singleton.sharedInstance.partner.type = UserType.speaker
                        Singleton.sharedInstance.tokBoxSessionId = sessionId
                        /*
                        HerokuappClient.shared.getSession{(dictionary, error) in
                            if let newDictionary = dictionary {
                                let newSessionId = newDictionary["sessionId"]!
                                if sessionId == newSessionId {
                                let token = newDictionary["token"]!
                                completion(sessionId, token)
                                }
                            }
                        }
                        print("invalid token")
                        */
                        completion(sessionId, dictionary["learner_token"]! as! String)
                    }
                })
                self.dataReference.child("available/learners/\(User.current.uid!)").setValue(nil)
            }
            
        })
    }
    
    
    func handleLearnerAvailable(completion: @escaping (_ session: String, _ token: String) -> Void) {
        print("in handle")
        dataReference.child("available/learners").observeSingleEvent(of: .value, with: {snapshot in
            if let learners = snapshot.value as? NSDictionary {
                print(learners)
                if let learnerInfo = learners[learners.allKeys[0]] as? NSDictionary {
                    Singleton.sharedInstance.partner.name = learnerInfo["name"] as! String
                    Singleton.sharedInstance.partner.rating = learnerInfo["rating"] as! Double
                    Singleton.sharedInstance.partner.uid = learnerInfo["uid"] as! String
                    Singleton.sharedInstance.partner.profilePhoto = learnerInfo["photo"] as! String
                    Singleton.sharedInstance.partner.type = UserType.learner
                    self.createSession(completion: completion)
                }
            } else {
                self.handleLearnerAvailable(completion: completion)
            }
        })
    }
    
    func removeHandleSpeakerAvailable() {
        dataReference.child("available/learners").child(User.current.uid).removeAllObservers()
        dataReference.child("available/learners").child(User.current.uid).setValue(nil)
    }
    
    
    func removeHandleLearnerAvailable() {
        dataReference.child("available/learners").removeAllObservers()
    }
    
    func createSession(completion: @escaping (_ session: String, _ token: String) -> Void) {
                dataReference.child("user_profile/\(Singleton.sharedInstance.partner.uid!)/username").observeSingleEvent(of: .value, with: {snapshot in
                    Singleton.sharedInstance.partner.name = snapshot.value as! String
                })
        var roomName : String = Singleton.sharedInstance.partner.uid + User.current.uid
        HerokuappClient.shared.getSession(roomName: roomName){ (dictionary, error) in
            if let dictionary = dictionary {
                Singleton.sharedInstance.tokBoxApiKey = dictionary["apiKey"]!
                let sessionId = dictionary["sessionId"]!
                let speakerToken = dictionary["token"]!
                let learnerToken = dictionary["learner_token"]!
                Singleton.sharedInstance.tokBoxSessionId = sessionId
                let dictionary = ["session_id" : sessionId,
                                  "speaker_token": speakerToken,
                                  "learner_token": learnerToken,
                                  "learnerUid": Singleton.sharedInstance.partner.uid,
                                  "learnerName": Singleton.sharedInstance.partner.name,
                                  "learnerRating": Singleton.sharedInstance.partner.rating,
                                  "speakerUid": User.current.uid,
                                  "speakerName": User.current.name,
                                  "speakerRating": User.current.speakerAverageRatings(),
                                  "speakerPhoto": User.current.profilePhoto] as [String : Any]
                self.dataReference.child("sessions/\(sessionId)").updateChildValues(dictionary)
                self.dataReference.child("available/learners/\(Singleton.sharedInstance.partner.uid!)").updateChildValues(["matched": sessionId])
                completion(sessionId, speakerToken)
            }
        }
    }
    
    func commitReview(review: Review) {
        let dictionaryReview = review.dictionary()
        
        dataReference.child("rating/\(Singleton.sharedInstance.partner.uid!)/\(Singleton.sharedInstance.tokBoxSessionId!)").setValue(dictionaryReview)
    }
    
    func loadReviews(completion: @escaping (_ reviews: [Review]?) -> Void) {
        dataReference.child("rating/\(User.current.uid!)").observeSingleEvent(of: .value, with: {snapshot in
            print(User.current.uid)
            self.dataReference.child("rating/\(User.current.uid!)").setValue(nil)
            if let reviewsDictionary = snapshot.value as? NSDictionary {
                var reviews = [Review]()
                for index in 0 ..< reviewsDictionary.count {
                    let review = Review(dictionary: reviewsDictionary[reviewsDictionary.allKeys[index]] as! NSDictionary)
                    reviews.append(review)
                }
                completion(reviews)
                self.saveUserData()
            } else {
                completion(nil)
            }
        })
    }
    
    func handleReviews() {
        dataReference.child("rating/\(User.current.uid!)").observe(.value, with: {(snapshot) in
            print(snapshot.value)
            if snapshot.value is NSNull {
                return
            }
            
            self.dataReference.child("rating/\(User.current.uid!)").setValue(nil)
            if let reviewsDictionary = snapshot.value as? NSDictionary {
                //                var reviews = [Review]()
                for index in 0 ..< reviewsDictionary.count {
                    let review = Review(dictionary: reviewsDictionary[reviewsDictionary.allKeys[index]] as! NSDictionary)
                    User.current.reviews.insert(review, at: 0)
                    User.current.conversations = User.current.conversations + 1
                }
                //                completion(reviews)
                MessageBox.show(body: "You have new review.")
                self.saveUserData()
            } else {
                //                completion(nil)
            }
        })
    }
}
