//
//  MovieResultViewController.swift
//  Entertainment Search
//
//  Created by Chris George on 6/27/15.
//  Copyright (c) 2015 iD Tech. All rights reserved.
//

import UIKit

class MovieResultViewController: UIViewController {

    @IBOutlet var movieResultPosterImageView: UIImageView!
    @IBOutlet var movieResultTitleLabel: UILabel!
    @IBOutlet var movieResultRatingLabel: UILabel!
    @IBOutlet var movieResultPlotLabel: UILabel!
    
    var resultMovie: Movie?

    // I pass movie data to the outlet properties via these variables. as seen in viewDidLoad()
    var movieTitle: String?
    var movieRating: String?
    var moviePlot: String?
    var moviePosterString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.movieResultTitleLabel.text = self.movieTitle
        self.movieResultRatingLabel.text = self.movieRating
        self.movieResultPlotLabel.text = self.moviePlot
        
        // converting the moviePosterString property to an image and assigning the movieResultPosterImageView's image property to the image 
        if let moviePosterString = self.moviePosterString,
        let posterURL = NSURL(string: moviePosterString),
        let posterData = NSData(contentsOfURL: posterURL) {
            let posterImage = UIImage(data: posterData)
            self.movieResultPosterImageView.image = posterImage
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addMovieToFavorites() {
        let alert = UIAlertController(title: "Add to favorites?", message: "Are you sure you want to add this movie to your favorites?", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            if let movieObj = self.resultMovie {
                favoriteMovies.append(movieObj)
            }
        }
        let noAction = UIAlertAction(title: "NO", style: .Default, handler: nil)
        alert.addAction(okAction)
        alert.addAction(noAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
