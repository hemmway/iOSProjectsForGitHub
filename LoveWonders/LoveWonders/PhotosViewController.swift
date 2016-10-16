//
//  PhotosViewController.swift
//  LoveWonders
//
//  Created by Ivan Kurhanskyi on 10/2/16.
//  Copyright © 2016 Ivan Kurhanskyi. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import MobileCoreServices

class PhotosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var addImageLabel: UILabel!
    @IBOutlet weak var addImageSwitchLabel: UISwitch!
    @IBOutlet weak var saveImageConfirmationLabel: UILabel!
    
    @IBOutlet weak var wonderImage: UIImageView!
    
    var photosWonderName: String! //declare var and it will be populated from incoming segue
    var photosSourceType: String! //declare var Camera or Library to be used from incoming segue
    
    @IBAction func addWonderPhotoAction(sender: AnyObject) {
        
        accessCameraOrPhotoLibrary()
    }
    @IBAction func addImageToCoreDataAction(sender: AnyObject) {
        
        addImageToCoreData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addImageLabel.text = photosWonderName
        addImageSwitchLabel.alpha = 0
        saveImageConfirmationLabel.alpha = 0
        
        accessCameraOrPhotoLibrary()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func accessCameraOrPhotoLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if photosSourceType == "Photos" {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                imagePicker.mediaTypes = [kUTTypeImage as NSString as String]
                presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        
        if photosSourceType == "Camera" {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) { //chech if camera is available
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                imagePicker.cameraCaptureMode = .Photo
                presentViewController(imagePicker, animated: true, completion: nil)
            } else {
                noCamera()
                //end if isSourceTypeAvailable
                //end of if photosSourceType = "Camera"
                
            }
        }
    }
    
    //delegate to cancel photo selection from library
    
    func imagePickerControllerDidCancel(imagePicker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        //Media is image
        if mediaType.isEqualToString(kUTTypeImage as NSString as String) {
        
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            wonderImage.image = image
            wonderImage.contentMode = .ScaleAspectFit
        
        }
        // end of mediaType is Image
        addImageLabel.alpha = 1
        addImageSwitchLabel.alpha = 1
        addImageSwitchLabel.setOn(true, animated: true)
        saveImageConfirmationLabel.alpha = 0
        
        addImageToCoreData()
    }
    
    func addImageToCoreData() {
        
        let photosAppDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let photosContext: NSManagedObjectContext = photosAppDel.managedObjectContext
        
        if addImageSwitchLabel.on {
            
            let newImageData = UIImageJPEGRepresentation(wonderImage.image!, 1)
            let newPhoto = NSEntityDescription.insertNewObjectForEntityForName("Photos", inManagedObjectContext: photosContext) as! Photos
            
            newPhoto.wonderName = photosWonderName
            newPhoto.wonderPhoto = newImageData
            
            do {
                try
                    photosContext.save()
                saveImageConfirmationLabel.alpha = 1
                saveImageConfirmationLabel.text = "Saved Photo of: " + photosWonderName
            } catch _ {
                
            }
        }

    }
    
    func noCamera() {
        let alertVC = UIAlertController(title: "No Camera", message: "Hello, Your device doesn't have a camera!", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alertVC.addAction(okAction)
        presentViewController(alertVC, animated: true, completion: nil)
    }
    

}
