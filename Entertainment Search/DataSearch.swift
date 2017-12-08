//
//  DataSearch.swift
//  Entertainment Search
//
//  Created by iD Student on 6/29/15.
//  Copyright (c) 2015 iD Tech. All rights reserved.
//

import Foundation
import UIKit

let sharedSession = NSURLSession.sharedSession()

// this function will get the tv show from the internet and then the use the tvshow obj in the completion handler
func searchIMDbForTV(#urlString: String, completionHandler: (TVShow?) -> Void) {
    if let url = NSURL(string: urlString) {
        let task = sharedSession.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            let tvDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! [String:AnyObject]
            
            // if we get an error returned in json
            if let error = tvDictionary["Error"] as? String {
                // pass in nil so that when we try to assign in tvsearchviewcontroller, our tvShow param will be nil
                completionHandler(nil)
            }
            else {
                let tvShow = TVShow(tvDictionary: tvDictionary)
                completionHandler(tvShow)
            }
        })
        task.resume()
    }
}

// this function will get the movie from the internet and then use the movie object in the completion handler
func searchIMDbForMovie(#urlString: String, completionHandler: (Movie?) -> Void) {
    if let url = NSURL(string: urlString) {
        let task = sharedSession.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            let movieDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! [String: AnyObject]
            
            // if we get an error returned in json
            if let error = movieDictionary["Error"] as? String {
                completionHandler(nil)
            }
            else {
                let movie = Movie(movieDictionary: movieDictionary)
                completionHandler(movie)
            }
            
        })
        task.resume()
    }
}