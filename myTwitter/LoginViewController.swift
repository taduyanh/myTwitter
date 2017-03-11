//
//  LoginViewController.swift
//  myTwitter
//
//  Created by admin on 3/11/17.
//  Copyright © 2017 anhtd. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLoginClick(_ sender: UIButton) {
        TwitterClient.shared().login(success: {
            print("move screen")
            self.performSegue(withIdentifier: "moveToFeedList", sender: nil)
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
