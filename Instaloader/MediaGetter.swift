//
//  MediaFetcher.swift
//  Instaloader
//
//  Created by Andrew Lenehan on 8/29/16.
//  Copyright © 2016 Andrew Lenehan. All rights reserved.
//


import Foundation
import UIKit

//protocol MediaFetcherDelegate {
//    func didFetchMediaItems(items: NSArray)
//    func didFailToFetchMediaItems(error: NSError)
//    func didFetchImage(image: UIImage, tag: String)
//    func didFailToFetchImage(error: NSError)
//}

class MediaFetcher {
    
    let baseURL = "https://api.instagram.com/v1/users/"

    let mediaEndpoint = "/media/recent/"
    let token = "25411745.5f8b700.0e6129e883e84d63ae56235e278309c7"
    
    var lastSearchURL: String?
    
//    var delegate: MediaFetcherDelegate?
//    
//    init(delegate:MediaFetcherDelegate){
//        self.delegate = delegate
//    }
    
    func getUserPhotos(userID: String) {
        get("\(baseURL)\(userID)\(mediaEndpoint)?access_token=\(token)")
    }
    
    func get(path: String) {
        let url = NSURL(string: path)
        lastSearchURL = path
        
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            print("Task completed")
            if let errorCode = error {
                self.delegate?.didFailToFetchMediaItems(errorCode)
                return;
            }
            if let data = data {
                do {
                    if let jsonResult =  try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String: AnyObject] {
                        let jsonResult = jsonResult
                        let results: NSArray = jsonResult["data"] as! NSArray
                        self.delegate?.didFetchMediaItems(results)
                    }
                }  catch {
                    print("error")
                }
            }
            })
        dataTask.resume()
    }
}
