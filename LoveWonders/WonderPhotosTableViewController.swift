//
//  WonderPhotosTableViewController.swift
//  LoveWonders
//
//  Created by Ivan Kurhanskyi on 10/5/16.
//  Copyright © 2016 Ivan Kurhanskyi. All rights reserved.
//

import UIKit
import CoreData

class WonderPhotosTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    var wonderPhotosArray: [Photos] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        let wonderPhotosAppDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let wonderPhotosContext: NSManagedObjectContext = wonderPhotosAppDel.managedObjectContext
        let wonderPhotosFetchRequest = NSFetchRequest(entityName: "Photos")
        
        // Create a predicate that selects on the "wonderName" property of the Core Data object
        wonderPhotosFetchRequest.predicate = NSPredicate(format: "wonderName = %@", viewSelectedWonderName) //select 1 wonder record only
        
        do {
            let wonderPhotosFetchResults = try wonderPhotosContext.executeFetchRequest(wonderPhotosFetchRequest) as? [Photos]
            wonderPhotosArray = wonderPhotosFetchResults!
        } catch {
            print("Could not catch \(error)")
        }
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return wonderPhotosArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WonderPhotoCell", forIndexPath: indexPath)

        // Configure the cell...
        
        let wonderPhoto: Photos = wonderPhotosArray[indexPath.row]
        let wonderPhotoName = wonderPhoto.wonderName
        let wonderPhotoImage = UIImage(data: wonderPhoto.wonderPhoto! as NSData)
        
        if let nameLabel = cell.viewWithTag(101) as? UILabel {
            nameLabel.text = wonderPhotoName
        }
        
        if let wonderPhotoImageView = cell.viewWithTag(100) as? UIImageView {
            wonderPhotoImageView.image = wonderPhotoImage
        }

        return cell
    }
    
    // the following function expands the image view to full screen (frame.size.height)
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.frame.size.height
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
