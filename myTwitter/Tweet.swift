//
//  Tweet.swift
//  myTwitter
//
//  Created by mac on 3/12/17.
//  Copyright © 2017 anhtd. All rights reserved.
//

import Foundation

class Tweet: NSObject {
    var user: User?
    var timestamp: Date?
    var id: String?
    var text: String?
    var replyCount: Int = 0
    var retweetCount: Int = 0
    var isRetweeted: Bool = false
    var favoritesCount: Int = 0
    var isFavorited: Bool = false
    var isRetweetedPost: Bool = false
    var retweetedUser: User?
    
    init(dictionary: NSDictionary) {
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        isRetweeted = (dictionary["retweeted"] as? Bool) ?? false
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        isFavorited = (dictionary["favorited"] as? Bool) ?? false
        var tweet = dictionary
        if let baseTweet = dictionary["retweeted_status"] {
            isRetweetedPost = true
            retweetedUser = User(dictionary: dictionary["user"] as! NSDictionary)
            tweet = baseTweet as! NSDictionary
        }
        user = User(dictionary: tweet["user"] as! NSDictionary)
        let timestampString = tweet["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }
        id = tweet["id_str"] as? String
        text = tweet["text"] as? String
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
    }
    
}
