//
//  UserViewController.swift
//  Instaloader
//
//  Created by Andrew Lenehan on 9/8/16.
//  Copyright © 2016 Andrew Lenehan. All rights reserved.
//

import Foundation
import UIKit


class UserViewController: UIViewController {
    
    var userList: [String: Bool] = [:]
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var user1ButtonOutlet: UIButton!
    @IBOutlet weak var user2ButtonOutlet: UIButton!
    @IBOutlet weak var user3ButtonOutlet: UIButton!
    
    
    @IBAction func user1Button(sender: UIButton) {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            if self.userList["232192182"] == true {
                sender.setBackgroundImage(UIImage(named: "therockhighlighted"), forState: UIControlState.Normal)
                self.userList.updateValue(false, forKey: "232192182")
            }else{
                sender.setBackgroundImage(UIImage(named: "therock"), forState: UIControlState.Normal)
                self.userList.updateValue(true, forKey: "232192182")
            }
            self.userDefaults.setObject(self.userList, forKey: "currentUserList")
        });
    }
    
    @IBAction func user2Button(sender: AnyObject) {
        dispatch_async(dispatch_get_main_queue(), {
        
            if self.userList["54388245"] == true{
                sender.setBackgroundImage(UIImage(named: "tomlenehanhighlighted"), forState: UIControlState.Normal)
                self.userList.updateValue(false, forKey: "54388245")
            }else{
                sender.setBackgroundImage(UIImage(named: "tomlenehan"), forState: UIControlState.Normal)
                self.userList.updateValue(true, forKey: "54388245")
            }
            self.userDefaults.setObject(self.userList, forKey: "currentUserList")
        });
    }
    
    @IBAction func user3Button(sender: AnyObject) {
            dispatch_async(dispatch_get_main_queue(), {
            if self.userList["1711337410"] == true{
                sender.setBackgroundImage(UIImage(named: "pokeballhighlighted"), forState: UIControlState.Normal)
                self.userList.updateValue(false, forKey: "1711337410")
            }else{
                sender.setBackgroundImage(UIImage(named: "pokeball"), forState: UIControlState.Normal)
                self.userList.updateValue(true, forKey: "1711337410")
            }
            self.userDefaults.setObject(self.userList, forKey: "currentUserList")
            });
    }
    
    override func viewDidLoad() {
        if let userList = userDefaults.objectForKey("currentUserList") {
            self.userList = userList as! [String : Bool]
            if self.userList["232192182"] == false {
                user1ButtonOutlet.setBackgroundImage(UIImage(named: "therockhighlighted"), forState: UIControlState.Normal)
            }
            if self.userList["54388245"] == false {
                user2ButtonOutlet.setBackgroundImage(UIImage(named: "tomlenehanhighlighted"), forState: UIControlState.Normal)
            }
            if self.userList["1711337410"] == false {
                user3ButtonOutlet.setBackgroundImage(UIImage(named: "pokeballhighlighted"), forState: UIControlState.Normal)
                
            }
        } else {
            self.userList = ["232192182": true, "54388245": true, "1711337410": true]
            self.userDefaults.setObject(self.userList, forKey: "currentUserList")
        }
    }
    
    @IBAction func feedAction(sender: AnyObject) {
        var users: Int = 0
        for (_, include) in self.userList {
            if include == true {
                users = users + 1
            }
        }
        if users == 0 {
            let alertController = UIAlertController(title: "No Users Selected", message:
                "Please be sure to select a user", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            performSegueWithIdentifier("mainlist", sender: self)
        }
    }
}