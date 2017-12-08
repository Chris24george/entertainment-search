//
//  TVShow.swift
//  Entertainment Search
//
//  Created by iD Student on 6/29/15.
//  Copyright (c) 2015 iD Tech. All rights reserved.
//

import Foundation
import UIKit

struct TVShow {
    
    var title           : String?
    var rating          : String?
    var plot            : String?
    var posterString    : String?
    
    init(tvDictionary: [String: AnyObject]) {
        if let title = tvDictionary["Title"] as? String {
            self.title = title
        }
        if let rating = tvDictionary["imdbRating"] as? String {
            self.rating = rating
        }
        if let plot = tvDictionary["Plot"] as? String {
            self.plot = plot
        }
        if let posterString = tvDictionary["Poster"] as? String {
            self.posterString = posterString
        }
    }
    
}
