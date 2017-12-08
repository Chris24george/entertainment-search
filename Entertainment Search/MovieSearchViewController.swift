//
//  MovieSearchViewController.swift
//  Entertainment Search
//
//  Created by Chris George on 6/27/15.
//  Copyright (c) 2015 iD Tech. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {

    @IBOutlet var movieSearchTitleTextField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!
    
    // this is the movie object we will get back from doSearch. we will pass this on to next view to display content
    var searchResultMovie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doSearch(sender: AnyObject) {
        // close keyboard
        self.closeKeyboards()
        
        // make loading circle start spinning
        self.activityIndicator.startAnimating()
        
        // disable search button so cant press multiple times
        self.searchButton.enabled = false
        
        // create url string from properties then assign destination view controllers properties from data
        let validURLTitle = movieSearchTitleTextField.text.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let urlString = "http://www.omdbapi.com/?t=\(validURLTitle!)"
        
        searchIMDbMovieAndUpdateUIForString(urlString)
    }

    
    
    func searchIMDbMovieAndUpdateUIForString(urlString: String) {
        searchIMDbForMovie(urlString: urlString, { (movie) -> Void in
            // we do this on the main thread because we only want to perform the segue after the data has loaded
            dispatch_async(dispatch_get_main_queue()) {
                self.searchResultMovie = movie
                
                // if we get a valid move assigned
                if (self.searchResultMovie != nil) {
                    self.performSegueWithIdentifier("ShowMovieResult", sender: self)
                    // stop the loading circle
                    self.activityIndicator.stopAnimating()
                    // re-enable the search button
                    self.searchButton.enabled = true
                }
                else {
                    // show the error, stop the loading circle, and re-enable the button
                    self.makeAndShowAlertView()
                    self.activityIndicator.stopAnimating()
                    self.searchButton.enabled = true
                    println("not valid show")
                }

            }
        })

    }
    
    // MARK: - alert view
    
    func makeAndShowAlertView() {
        let alert = UIAlertController(title: "Error", message: "Could not find Movie. Please try again.", preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowMovieResult") {
            let movieResultController = segue.destinationViewController as! MovieResultViewController
            movieResultController.movieTitle = searchResultMovie?.title
            movieResultController.movieRating = searchResultMovie?.rating
            movieResultController.moviePlot = searchResultMovie?.plot
            movieResultController.moviePosterString = searchResultMovie?.posterString
            movieResultController.resultMovie = searchResultMovie
        }
    }
    

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        closeKeyboards()
    }
    
    
    func closeKeyboards() {
        self.movieSearchTitleTextField.resignFirstResponder()
    }

    
    
    


}
