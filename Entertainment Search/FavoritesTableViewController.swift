//
//  FavoritesTableViewController.swift
//  Entertainment Search
//
//  Created by iD Student on 7/1/15.
//  Copyright (c) 2015 iD Tech. All rights reserved.
//

import UIKit

// GLOBAL FAVORITES ARRAY TO DISPLAY IN THE TABLE VIEW
var favoriteMovies = [Movie]()
var favoriteTVShows = [TVShow]()

class FavoritesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return favoriteMovies.count
        }
        if (section == 1) {
            return favoriteTVShows.count
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FavoriteCell", forIndexPath: indexPath) as! UITableViewCell
        
        if indexPath.section == 0 {
            cell.textLabel?.text = favoriteMovies[indexPath.row].title
        }
        if indexPath.section == 1 {
            cell.textLabel?.text = favoriteTVShows[indexPath.row].title
        }
        
        return cell
    }
    
    // THIS WAS KEY TO FIXING SECTION HEADER BUG. EMPTY STRINGS MAKE THE HEADERS DISAPPEAR
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            if favoriteMovies.count == 0 {
                return ""
            }
            else {
                return "Movies"
            }
        }
        if (section == 1) {
            if favoriteTVShows.count == 0 {
                return ""
            }
            else {
                return "TV Shows"
            }
        }
        return "Error"
    }
    


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            if indexPath.section == 0 {
                favoriteMovies.removeAtIndex(indexPath.row)
                tableView.reloadData()
            }
            if indexPath.section == 1 {
                favoriteTVShows.removeAtIndex(indexPath.row)
                tableView.reloadData()
            }
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
