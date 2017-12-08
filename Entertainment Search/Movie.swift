//
//  Movie.swift
//  Entertainment Search
//
//  Created by iD Student on 6/29/15.
//  Copyright (c) 2015 iD Tech. All rights reserved.
//

import Foundation
import UIKit

struct Movie {
    
    var title           : String?
    var rating          : String?
    var plot            : String?
    var posterString    : String?
    
    init(movieDictionary: [String: AnyObject]) {
        if let title = movieDictionary["Title"] as? String {
            self.title = title
        }
        if let rating = movieDictionary["imdbRating"] as? String {
            self.rating = rating
        }
        if let plot = movieDictionary["Plot"] as? String {
            self.plot = plot
        }
        if let posterString = movieDictionary["Poster"] as? String {
            self.posterString = posterString
        }
    }
    
}