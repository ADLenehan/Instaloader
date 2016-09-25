//
//  ViewController.swift
//  Instaloader
//
//  Created by Andrew Lenehan on 8/27/16.
//  Copyright © 2016 Andrew Lenehan. All rights reserved.
//

import UIKit
import OAuthSwift


class LoginViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    func doOAuthInstagram() {
        
        let oauthswift = OAuth2Swift(
            consumerKey:    "5f8b7002172c4ce6bfdfe76bdf366f3f",
            consumerSecret: "75638f7d84b547629a56267db9224b7e",
            authorizeUrl:   "https://api.instagram.com/oauth/authorize",
            responseType:   "token"
        )
        
        oauthswift.authorizeWithCallbackURL( NSURL(string: "http://oauthswift.herokuapp.com/callback/Instaloader/MainListViewController")!,
                                             scope: "likes+comments+public_content+follower_list+basic",
                                             state:"INSTAGRAM22",
                                             success: {
                                                credential, response, parameters in
                                                print("oauth_token:\(credential.oauth_token)")
                                                let url :String = "https://api.instagram.com/v1/users/1574083/?access_token=\(credential.oauth_token)"
                                                oauthswift.client.get(url, parameters: parameters,
                                                    success: {
                                                        data, response in
                                                        do {
                                                            let jsonDict: AnyObject! = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                                                            print(jsonDict) } catch {}
                                                    }, failure: {(error:NSError!) -> Void in
                                                        print(error)
                                                })
            }, failure: {(error:NSError!) -> Void in
                print(error.localizedDescription)
        })
        self.performSegueWithIdentifier("loginsegue", sender: self)
    }
    

    @IBAction func loginButton(sender: AnyObject) {
        doOAuthInstagram()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

