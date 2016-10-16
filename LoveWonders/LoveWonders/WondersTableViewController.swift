//
//  WondersTableViewController.swift
//  LoveWonders
//
//  Created by Ivan Kurhanskyi on 9/20/16.
//  Copyright © 2016 Ivan Kurhanskyi. All rights reserved.
//

import UIKit
import CoreData

var viewSelectedWonderName: String = ""
var viewSelectedWonderLatitude: Double = 0.0
var viewSelectedWonderLongitude: Double = 0.0
var viewSelectedWonderNotes: String = ""

var editSelectedRow: Int = 0
var editSelectedWonderName: String = ""
var editSelectedWonderLatitude: Double = 0.0
var editSelectedWonderLongitude: Double = 0.0
var editSelectedWonderNotes: String = ""

class WondersTableViewController: UITableViewController {
    
    var wonders = [Wonders]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        let wondersAppDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let wondersContext: NSManagedObjectContext = wondersAppDel.managedObjectContext
        let wonderFetchRequest = NSFetchRequest(entityName: "Wonders")
        wonderFetchRequest.predicate = NSPredicate(format: "wonderShow = %@", true)
        let sortDescriptor = NSSortDescriptor(key: "wonderName", ascending: true)
        wonderFetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            if let wonderFetchedResults = try wondersContext.executeFetchRequest(wonderFetchRequest) as? [Wonders] {
                wonders = wonderFetchedResults
            } else {
                print("ELSE if let result = try.. FAILED")
            }
        } catch {
            fatalError("There was an error fethching the list of groups!")
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
        
        return wonders.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WonderCell", forIndexPath: indexPath)

        // Configure the cell...

        let myWonder = wonders[indexPath.row]
        cell.textLabel?.text = myWonder.wonderName
        
        let cellLatitudeDouble: Double = myWonder.wonderLatitude as Double!
        let cellLatitudeString: String = String(format: "%.6f", cellLatitudeDouble)
        
        let cellLongitudeDouble: Double = myWonder.wonderLongitude as Double!
        let cellLongitudeString: String = String(format: "%.6f", cellLongitudeDouble)
        
        cell.detailTextLabel?.text = "Lat: " + cellLatitudeString + "  Lon: " + cellLongitudeString
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let wondersAppDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let wondersContext: NSManagedObjectContext = wondersAppDel.managedObjectContext
            
            wondersContext.deleteObject(wonders[indexPath.row] as Wonders) //Delete from Core Data
            
            do {
                try wondersContext.save()
            } catch {
                print("Couldn't delete \(error)")
            }
            
            wonders.removeAtIndex(indexPath.row) //Delete from Array of Wonders
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            }
        }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let myWonder = wonders[indexPath.row]
        viewSelectedWonderName = myWonder.wonderName
        viewSelectedWonderLatitude = myWonder.wonderLatitude as Double
        viewSelectedWonderLongitude = myWonder.wonderLongitude as Double 
        viewSelectedWonderNotes = myWonder.wonderNotes
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let myWonder = wonders[indexPath.row]
        
        editSelectedRow = indexPath.row
        editSelectedWonderName = myWonder.wonderName
        editSelectedWonderLatitude = myWonder.wonderLatitude as Double
        editSelectedWonderLongitude = myWonder.wonderLongitude as Double
        editSelectedWonderNotes = myWonder.wonderNotes
    }

}
