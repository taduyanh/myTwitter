//
//  DetailFeedViewController.swift
//  myTwitter
//
//  Created by mac on 3/12/17.
//  Copyright © 2017 anhtd. All rights reserved.
//

import UIKit

class DetailFeedViewController: UIViewController {
    var tweet: Tweet?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let tweet = tweet {
            print(tweet)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
