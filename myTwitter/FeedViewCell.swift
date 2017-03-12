//
//  FeedViewCell.swift
//  myTwitter
//
//  Created by mac on 3/12/17.
//  Copyright © 2017 anhtd. All rights reserved.
//

import UIKit
import DateToolsSwift

class FeedViewCell: UITableViewCell {

    @IBOutlet weak var retweetView: UIView!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var retweetedImage: UIImageView!
    
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBOutlet weak var contentLabel: UILabel!

    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var loveButton: UIButton!
    
    var tweet: Tweet!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onRetweetClick(_ sender: UIButton) {
        var action = "retweet"
        if(tweet.isRetweeted) {
            action = "unretweet"
        }
        TwitterClient.shared().retweet(tweetId: tweet.id!, action: action, success: { (tweet: Tweet) in
            self.importDataFromTweet(tweet)
        })
    }
    
    @IBAction func onLoveClick(_ sender: UIButton) {
        var action = "create"
        if(tweet.isFavorited) {
            action = "destroy"
        }
        TwitterClient.shared().favorite(tweetId: tweet.id!, action: action, success: { (tweet: Tweet) in
            self.importDataFromTweet(tweet)
        })
    }
    func importDataFromTweet(_ tweet: Tweet) {
        self.tweet = tweet
        avatarImageView.setImageWith((tweet.user?.profileUrl)!)
        avatarImageView.layer.cornerRadius = 5
        avatarImageView.clipsToBounds = true
        
        // Set Name
        nameLabel.text = tweet.user?.name
            
        // Set Screen Name
        nickLabel.text = "@\((tweet.user?.screenname)!)"
            
        // Set Timestamp
        timeLabel.text = tweet.timestamp?.shortTimeAgoSinceNow
            
        // Set Tweet Text
        contentLabel.text = tweet.text
        
        if tweet.isRetweeted {
            retweetButton.setImage(UIImage(named: "retweet_on"), for: .normal)
            retweetedImage.image = UIImage(named: "retweet_on")
        } else {
            retweetButton.setImage(UIImage(named: "retweet_off"), for: .normal)
            retweetedImage.image = UIImage(named: "retweet_off")
        }
        
        if tweet.isFavorited {
            loveButton.setImage(UIImage(named: "love_on"), for: .normal)
        } else {
            loveButton.setImage(UIImage(named: "love_off"), for: .normal)
        }
        
        if tweet.isRetweetedPost {
            retweetLabel.text = "\((tweet.retweetedUser?.name)!) retweeted"
        } else {
            retweetView.isHidden = true
        }
        
    }
}
