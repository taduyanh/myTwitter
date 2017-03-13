//
//  FeedListViewController.swift
//  myTwitter
//
//  Created by admin on 3/11/17.
//  Copyright © 2017 anhtd. All rights reserved.
//

import UIKit

class FeedListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    var tweets: [Tweet]?
    var selectedTweet: Tweet?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        refreshControl.addTarget(self, action: #selector(self.loadTimeLineData), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        loadTimeLineData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    func loadTimeLineData() {
        tweets = []
        tableView.reloadData()
        TwitterClient.shared().homeTimeline(success: {(tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "moveToDetailFeed" {
            let navbar = segue.destination as! UINavigationController
            let vc = navbar.topViewController as! DetailFeedViewController
            vc.tweet = selectedTweet
        }
        
        if segue.identifier == "newTweet" {
            let navbar = segue.destination as! UINavigationController
            let vc = navbar.topViewController as! NewTweetViewController
            vc.user = User.currentUser
        }
    }
}

extension FeedListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTweet = self.tweets?[indexPath.row]
        performSegue(withIdentifier: "moveToDetailFeed", sender: nil)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets?.count ?? 0 
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell") as! FeedViewCell
        let tweet = self.tweets?[indexPath.row]
        cell.importDataFromTweet(tweet!)
        return cell
    }
}
