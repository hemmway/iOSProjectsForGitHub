//
//  AddWonderViewController.swift
//  LoveWonders
//
//  Created by Ivan Kurhanskyi on 9/25/16.
//  Copyright © 2016 Ivan Kurhanskyi. All rights reserved.
//

import UIKit
import CoreData

class AddWonderViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var topSaveConfirmationLabel: UILabel!
    @IBOutlet weak var wonderNameTextField: UITextField!
    @IBOutlet weak var wonderLatitudeTextField: UITextField!
    @IBOutlet weak var wonderLongitudeTextField: UITextField!
    @IBOutlet weak var wonderNotesTextView: UITextView!
    @IBOutlet weak var photoButtonLabel: UIButton!
    @IBOutlet weak var cameraButtonLabel: UIButton!
    
    
    var wonderName: String = ""
    var wonderLatitude: Double = 0.0
    var wonderLongitude: Double = 0.0
    var wonderNotes: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Adding save button for Add Wonder
        
        let saveRightBarButton = UIBarButtonSystemItem.Save
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: saveRightBarButton,
            target: self, action: #selector(AddWonderViewController.addSaveButtonAction(_:)))
        
        topSaveConfirmationLabel.alpha = 0
        
        wonderNotesTextView.text = "..."
        
        photoButtonLabel.alpha = 0
        cameraButtonLabel.alpha = 0

    }
    
    @IBAction func addSaveButtonAction(sender: AnyObject) {
        wonderName = wonderNameTextField.text!
        wonderLatitude = Double(wonderLatitudeTextField.text!) ?? 0.0
        wonderLongitude = Double(wonderLongitudeTextField.text!) ?? 0.0
        wonderNotes = wonderNotesTextView.text!
        
        //Save the wonder record to Core Data
        
        let wondersAppDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let wondersContext: NSManagedObjectContext = wondersAppDel.managedObjectContext
        let newWonder =  NSEntityDescription.insertNewObjectForEntityForName("Wonders", inManagedObjectContext: wondersContext) as! Wonders
        
        newWonder.wonderName = wonderName
        newWonder.wonderLatitude = wonderLatitude
        newWonder.wonderLongitude = wonderLongitude
        newWonder.wonderShow = true
        newWonder.wonderType = "MY"
        newWonder.wonderNotes = wonderNotesTextView.text
        
         do {
            try wondersContext.save()
            topSaveConfirmationLabel.alpha = 1
            topSaveConfirmationLabel.text = "Saved: " + wonderName
            
            photoButtonLabel.alpha = 1
            cameraButtonLabel.alpha = 1
        } catch {
            topSaveConfirmationLabel.alpha = 1
            topSaveConfirmationLabel.text = "Error: " + wonderName
            print("Couldn't ave \(error)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Prepare for Segue to Photos to pass wonder name value
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addToPhotos" {
            let vc = segue.destinationViewController as! PhotosViewController
            vc.photosWonderName = wonderName
            vc.photosSourceType = "Photos"
        }
        
        if segue.identifier == "addToCamera" {
            let vc = segue.destinationViewController as! PhotosViewController
            vc.photosWonderName = wonderName
            vc.photosSourceType = "Camera"
        }
    }

    // Keyboard Control
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        wonderNameTextField.resignFirstResponder()
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}
