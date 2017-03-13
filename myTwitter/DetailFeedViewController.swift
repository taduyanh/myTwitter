//
//  DetailFeedViewController.swift
//  myTwitter
//
//  Created by mac on 3/12/17.
//  Copyright © 2017 anhtd. All rights reserved.
//

import UIKit
import DateToolsSwift

class DetailFeedViewController: UIViewController {
    var tweet: Tweet?

    @IBOutlet weak var retweetView: UIView!
    @IBOutlet weak var reTweetedPostImageView: UIImageView!
    @IBOutlet weak var reTweetedPostLabel: UILabel!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBOutlet weak var loveImageView: UIImageView!
    @IBOutlet weak var loveLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var loveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tweet = tweet {
            importDataFromTweet(tweet)
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func onBackButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        retweetLabel.text = "\(tweet.retweetCount)"
        loveLabel.text = "\(tweet.favoritesCount)"
        
        if tweet.isRetweeted {
            retweetButton.setImage(UIImage(named: "retweet_on"), for: .normal)
            reTweetedPostImageView.image = UIImage(named: "retweet_on")
        } else {
            retweetButton.setImage(UIImage(named: "retweet_off"), for: .normal)
            reTweetedPostImageView.image = UIImage(named: "retweet_off")
        }
        
        if tweet.isFavorited {
            loveButton.setImage(UIImage(named: "love_on"), for: .normal)
        } else {
            loveButton.setImage(UIImage(named: "love_off"), for: .normal)
        }
        
        if tweet.isRetweetedPost {
            reTweetedPostLabel.text = "\((tweet.retweetedUser?.name)!) retweeted"
        } else {
            retweetView.isHidden = true
        }
    }


    @IBAction func onRetweetButton(_ sender: UIButton) {
        guard let tweet = self.tweet else { return }
        var action = "retweet"
        if(tweet.isRetweeted) {
            action = "unretweet"
        }
        TwitterClient.shared().retweet(tweetId: tweet.id!, action: action, success: { (tweet: Tweet) in
            self.importDataFromTweet(tweet)
        })
    }
    
    @IBAction func onLoveClick(_ sender: UIButton) {
        guard let tweet = self.tweet else { return }
        var action = "create"
        if(tweet.isFavorited) {
            action = "destroy"
        }
        TwitterClient.shared().favorite(tweetId: tweet.id!, action: action, success: { (tweet: Tweet) in
            self.importDataFromTweet(tweet)
        })
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
