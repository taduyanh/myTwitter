//
//  User.swift
//  myTwitter
//
//  Created by mac on 3/12/17.
//  Copyright © 2017 anhtd. All rights reserved.
//

import Foundation


import UIKit

let currentUserKey = "currentUser"
let currentUserDataKey = "currentUserData"

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var tagline: String?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        
        tagline = dictionary["descrition"] as? String
    }
    
    static let userDidLogoutNotification = NSNotification.Name(rawValue: "UserDidLogout")
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                
                let userData = defaults.object(forKey: "currentUserData") as? NSData
                
                guard let userInfo = userData else { return nil }
                let dictionary = try! JSONSerialization.jsonObject(with: userInfo as Data, options: []) as! NSDictionary
                
                _currentUser = User(dictionary: dictionary)
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
                defaults.synchronize()
            } else {
                let appDomain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: appDomain)
            }
        }
    }
    
}
