//
//  TwitterClient.swift
//  myTwitter
//
//  Created by admin on 3/11/17.
//  Copyright © 2017 anhtd. All rights reserved.
//

import Foundation
import BDBOAuth1Manager

let baseUrlString = "https://api.twitter.com/"
let consumerKey = "g2Uc5ulZcrKZBVxVzckA288X1"
let consumerSecret = "LLLdtBeeD8Ygdz98yyWCcqael4dc1LaNDuuWCSACcuxakDeUxg"

class TwitterClient : BDBOAuth1SessionManager {
    
    static var _shared: TwitterClient?
    var loggedInCallback: (() -> ())?
    var accessToken: String?
    static func shared() -> TwitterClient {
        if ( _shared == nil ) {
            _shared = TwitterClient(baseURL: URL(string: baseUrlString), consumerKey: consumerKey, consumerSecret: consumerSecret)
        }
        return _shared!
    }
    
    func login(success successCallback: @escaping () -> ()) {
        loggedInCallback = successCallback
        TwitterClient.shared().deauthorize()
        TwitterClient.shared().fetchRequestToken(withPath: "oauth/request_token", method: "POST", callbackURL: URL(string: "blueBirdFeed://"), scope: nil, success: { (response : BDBOAuth1Credential?) in
            guard let token = response?.token else { return }
            let authorizeUrl = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(token)")
            UIApplication.shared.open(authorizeUrl!)
        }, failure: TwitterClient.handleError)
    }
    
    func getAceessToken(_ queryToken: String, sucesss: @escaping () -> ()) {
        let requestToken = BDBOAuth1Credential(queryString: queryToken)
        TwitterClient.shared().fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (response: BDBOAuth1Credential?) in
            guard let response = response, let token = response.token else { return }
            self.accessToken = token
            sucesss()
        }, failure: TwitterClient.handleError)
    }
    
    func getUserAndMoveOn() {
        TwitterClient.shared().get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            guard let data = response as! NSDictionary? else {
                return
            }
            print(data)
            self.loggedInCallback?()
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print(error.localizedDescription)
        })
    }
    
    static func handleError(_ error: Error?) {
        guard let errorString = error?.localizedDescription else { return }
        print(errorString)
    }
}
