//
//  MediaItem.swift
//  Instaloader
//
//  Created by Andrew Lenehan on 8/28/16.
//  Copyright © 2016 Andrew Lenehan. All rights reserved.
//

import Foundation

class MediaItem {
    
    var userID: String?
    var username: String?
    var imageURL: String?
    var profilePictureURL: String?
    var imageData: NSData?
    var profilePictureData: NSData?
    var likes: Int?
    var caption: String?
    var createdTime: Int?
    
    init(item: NSDictionary){
        
        userID = item.valueForKeyPath("user.id") as? String
        username = item.valueForKeyPath("user.username") as? String
        imageURL = item.valueForKeyPath("images.standard_resolution.url") as? String
        profilePictureURL = item.valueForKeyPath("user.profile_picture") as? String
        likes = item.valueForKeyPath("likes.count") as? Int
        caption = item.valueForKeyPath("caption.text") as? String
        createdTime = item.valueForKeyPath("created_time") as? Int
        
        }
}