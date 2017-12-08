//
//  TVResultViewController.swift
//  Entertainment Search
//
//  Created by Chris George on 6/27/15.
//  Copyright (c) 2015 iD Tech. All rights reserved.
//

import UIKit

class TVResultViewController: UIViewController {

    @IBOutlet var TVResultPosterImageView: UIImageView!
    @IBOutlet var TVResultTitleLabel: UILabel!
    @IBOutlet var TVResultRatingLabel: UILabel!
    @IBOutlet var TVResultPlotLabel: UILabel!
    
    var resultShow: TVShow?
    
    // temporary variables so we can assign to these in the TVSearchViewController's prepareforsegue method
    var tvTitle: String?
    var tvRating: String?
    var tvPlot: String?
    var tvPosterString: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TVResultTitleLabel.text = tvTitle
        self.TVResultRatingLabel.text = tvRating
        self.TVResultPlotLabel.text = tvPlot
        
        // converting the tvPosterString property to an image and assigning the TVResultPosterImageView's image property to the image 
        if let tvPosterString = self.tvPosterString,
        let posterURL = NSURL(string: tvPosterString),
        let posterData = NSData(contentsOfURL: posterURL) {
            let posterImage = UIImage(data: posterData)
            self.TVResultPosterImageView.image = posterImage
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addTVShowToFavorites() {
        let alert = UIAlertController(title: "Add to favorites?", message: "Are you sure you want to add this TV Show to your favorites?", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            if let showObj = self.resultShow {
                favoriteTVShows.append(showObj)
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
