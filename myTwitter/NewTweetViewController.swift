//
//  NewTweetViewController.swift
//  myTwitter
//
//  Created by admin on 3/13/17.
//  Copyright © 2017 anhtd. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nickLabel: UILabel!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var tweetButton: UIBarButtonItem!
    
    
    var user: User?
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = user {
            avatarImageView.setImageWith(user.profileUrl!)
            nameLabel.text = user.name
            nickLabel.text = "@\(user.screenname!)"
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contentTextView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tweetButtonClick(_ sender: UIBarButtonItem) {
        TwitterClient.shared().tweet(status: contentTextView.text, success: {(tweet: Tweet) in
            
            let nav = self.presentingViewController as! UINavigationController
            let vc = nav.topViewController as! FeedListViewController
            vc.tweets?.insert(tweet, at: 0)
            self.dismiss(animated: true, completion: nil)
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
