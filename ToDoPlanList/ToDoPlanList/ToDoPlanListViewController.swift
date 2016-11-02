//
//  ToDoPlanListViewController.swift
//  ToDoPlanList
//
//  Created by Ivan Kurhanskyi on 10/27/16.
//  Copyright © 2016 Ivan Kurhanskyi. All rights reserved.
//

import UIKit

class ToDoPlanListViewController: UITableViewController {
    
    var items: [ToDoPlanListItem]
    
    @IBAction func addItem() {
        let newRowIndex = items.count
        
        let item = ToDoPlanListItem()
        item.text = "I am a new row"
        item.checked = false
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        items = [ToDoPlanListItem]()
        
        let row0item = ToDoPlanListItem()
        row0item.text = ""
        row0item.checked = false
        items.append(row0item)
        
        let row1item = ToDoPlanListItem()
        row1item.text = ""
        row1item.checked = false
        items.append(row1item)
        
        let row2item = ToDoPlanListItem()
        row2item.text = ""
        row2item.checked = false
        items.append(row2item)
        
        let row3item = ToDoPlanListItem()
        row3item.text = ""
        row3item.checked = false
        items.append(row3item)
        
        let row4item = ToDoPlanListItem()
        row4item.text = ""
        row4item.checked = false
        items.append(row4item)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoPlanListItem", for: indexPath)
        
        let item = items[indexPath.row]
        
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {

            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
            
        }
            tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func configureCheckmark (for cell: UITableViewCell, with item: ToDoPlanListItem) {
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    func configureText (for cell: UITableViewCell, with item: ToDoPlanListItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        
        label.text = item.text
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
