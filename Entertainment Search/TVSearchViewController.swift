//
//  TVSearchViewController.swift
//  Entertainment Search
//
//  Created by Chris George on 6/27/15.
//  Copyright (c) 2015 iD Tech. All rights reserved.
//

import UIKit

class TVSearchViewController: UIViewController {

    @IBOutlet var TVSearchTitleTextField: UITextField!
    @IBOutlet var TVSearchSeasonTextField: UITextField!
    @IBOutlet var TVSearchEpisodeNumberTextField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!
    
    // we will assign the result tv show object from searchIMDb function to this property. then use it in prepare for segue
    var searchResultTVShow: TVShow?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /* function summary: when the search button is pressed, do some stuff, then check which fields are empty and filled. based on that, create the url we will be retrieving the data from. then call our func that does the search and updates the ui */
    
    @IBAction func doSearch(sender: AnyObject) {
        // close all keyboards
        self.closeKeyboards()
        
        // make the loading circle start spinning
        self.activityIndicator.startAnimating()
        
        // disable search button so cant press multiple times
        self.searchButton.enabled = false
        
        // text versions of the text field text to put into the urlstring that we will search
        let validURLTitle = TVSearchTitleTextField.text.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let validURLSeason = TVSearchSeasonTextField.text
        let validURLEpisodeNum = TVSearchEpisodeNumberTextField.text
        
        // if there is no text in the season text field or the episode number field do something
        if TVSearchSeasonTextField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).isEmpty &&
        TVSearchEpisodeNumberTextField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).isEmpty {
            
            let urlString = "http://www.omdbapi.com/?t=\(validURLTitle!)"
            
            // this function just abstracts a layer above the searchIMDb function to be more readable because we are checking text fields.
            searchIMDbTVAndUpdateUIForString(urlString)
            
        }
        // else if the season text field is not empty and the episode number field still is, do something
        else if TVSearchSeasonTextField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).isEmpty == false &&
            TVSearchEpisodeNumberTextField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).isEmpty {
                
            let urlString = "http://www.omdbapi.com/?t=\(validURLTitle!)&Season=\(validURLSeason)"
                
            searchIMDbTVAndUpdateUIForString(urlString)
        }
        // else if both the season text field and the episode number text field are not empty, do something
        else if TVSearchSeasonTextField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).isEmpty == false &&
            TVSearchEpisodeNumberTextField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).isEmpty == false {
                
            let urlString = "http://www.omdbapi.com/?t=\(validURLTitle!)&Season=\(validURLSeason)&Episode=\(validURLEpisodeNum)"
                
            searchIMDbTVAndUpdateUIForString(urlString)
        }
        // else if the season text field is empty and the episode one has something in it
        else if TVSearchSeasonTextField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).isEmpty  &&
            TVSearchEpisodeNumberTextField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).isEmpty == false {
                
            let urlString = "http://www.omdbapi.com/?t=\(validURLTitle!)&Episode=\(validURLEpisodeNum)"
                
            searchIMDbTVAndUpdateUIForString(urlString)
        }
    }
    
    // this function searches imdb then updates the ui
    /* this function allows the searchIMDb function to be reused with different url strings. we want this because the url string will be different based on what text fields are filled in and which ones are empty */
    func searchIMDbTVAndUpdateUIForString(conditionalURLString: String) {
        searchIMDbForTV(urlString: conditionalURLString, { (tvShow) -> Void in
            // we do this on the main thread because we only want to perform the segue after the data has loaded
            dispatch_async(dispatch_get_main_queue()) {
                self.searchResultTVShow = tvShow
                
                // if we get a valid tv show assigned
                if (self.searchResultTVShow != nil) {
                    self.performSegueWithIdentifier("ShowTVResult", sender: self)
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

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowTVResult" {
            // assign destination view controllers properties from our search result tv show
            let tvResultController = segue.destinationViewController as! TVResultViewController
            tvResultController.tvTitle = searchResultTVShow?.title
            tvResultController.tvRating = searchResultTVShow?.rating
            tvResultController.tvPlot = searchResultTVShow?.plot
            tvResultController.tvPosterString = searchResultTVShow?.posterString
            tvResultController.resultShow = searchResultTVShow
        }
    }

    
    // MARK: - alert view 
    
    func makeAndShowAlertView() {
        let alert = UIAlertController(title: "Error", message: "Could not find TV show. Please try again.", preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        closeKeyboards()
    }
    
    
    func closeKeyboards() {
        self.TVSearchEpisodeNumberTextField.resignFirstResponder()
        self.TVSearchSeasonTextField.resignFirstResponder()
        self.TVSearchTitleTextField.resignFirstResponder()
    }

}
