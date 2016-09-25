//
//  MainListViewController.swift
//  Instaloader
//
//  Created by Andrew Lenehan on 8/28/16.
//  Copyright © 2016 Andrew Lenehan. All rights reserved.
//

import UIKit

class MainListViewController: UITableViewController, MediaGetterDelegate {
    
    var mediaItemList: [MediaItem] = []
    var mediaItem: MediaItem?
    var mediaGetter: MediaGetter = MediaGetter()
    var mediaUsers: [String] = []
    let userDefaults = NSUserDefaults.standardUserDefaults()
    var userList: [String: Bool] = [:]
    
    override func viewDidLoad() {
        
        if let userList = userDefaults.objectForKey("currentUserList") {
            self.userList = userList as! [String : Bool]
            for (user, include) in self.userList {
                if include == true {
                    mediaUsers.append(user)
                } else {}
            }
        }
        
        
    mediaGetter.delegate = self
        mediaItemList.removeAll(keepCapacity: true)
        for mediaUser in mediaUsers {
                mediaGetter.getUserPhotos(mediaUser)
        }
    }
    
    func didGetMediaItems(items: NSArray){
        for item: AnyObject in items {
            let newItem: MediaItem = MediaItem(item: item as! NSDictionary)
            mediaItemList.append(newItem)
            mediaItemList.sortInPlace({$0.createdTime < $1.createdTime })
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
    }
    
    func didFailToGetMediaItems(error: NSError){
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaItemList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> MediaCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("maincellidentifier", forIndexPath: indexPath) as! MediaCell
        
        let MediaItem = mediaItemList[indexPath.row]
        
        cell.handleLabel?.text = MediaItem.username
        cell.captionLabel?.text = MediaItem.caption
        
        
        asyncLoadImage(MediaItem, profileImageView: cell.profileImage, imageView: cell.photoImageView)
        return cell
    }
    
    func asyncLoadImage (mediaItem: MediaItem, profileImageView: UIImageView, imageView: UIImageView){
        let downloadQueue = dispatch_queue_create("processdownload", nil)
        dispatch_async(downloadQueue) {
            
            var profileImage:UIImage?
            var image:UIImage?
            
            if let data = NSData(contentsOfURL: NSURL(string: mediaItem.imageURL!)!),
                let profileData = NSData(contentsOfURL: NSURL(string: mediaItem.profilePictureURL!)!){
                mediaItem.imageData = data
                mediaItem.profilePictureData = profileData
                image = UIImage(data: data)
                profileImage = UIImage(data: profileData)
            }
            dispatch_async(dispatch_get_main_queue()){
                imageView.image = image
                profileImageView.image = profileImage
            }
        }
    }
}




