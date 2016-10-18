 //
//  WhereAmIViewController.swift
//  LoveWonders
//
//  Created by Ivan Kurhanskyi on 9/20/16.
//  Copyright © 2016 Ivan Kurhanskyi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class WhereAmIViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var whereAmIWonderName: UITextField!
    @IBOutlet weak var addConfirmationLabel: UILabel!
    
    @IBOutlet weak var whereAmIAddress: UILabel!
    
    @IBOutlet weak var whereAmILatitude: UILabel!
    @IBOutlet weak var whereAmILongitude: UILabel!
    
    
    @IBOutlet weak var photosButtonLabel: UIButton!
    @IBOutlet weak var cameraButtonLabel: UIButton!
    @IBOutlet weak var uploadButtonLabel: UIButton!
    @IBOutlet weak var uploadImageView: UIImageView!
    
    @IBOutlet weak var whereAmIMapView: MKMapView!
    
    var manager: CLLocationManager!
    var wonderName: String = ""
    var wonderNotes: String = ""
    
    //Social Media Variables
    var wonderSocialMediaText = " "
    var wonderSaved: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        whereAmIWonderName.delegate = self //used for the keyboard controls: Return and Touch Elswhere
        
        whereAmIWonderName.text = ""
        addConfirmationLabel.alpha = 0
        photosButtonLabel.alpha = 0
        cameraButtonLabel.alpha = 0
        uploadButtonLabel.alpha = 0
        uploadImageView.alpha = 0
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization() //must add to info.plist
        manager.startUpdatingLocation()
        
        // This starts the location updates, then when updating locations, store them in the location manager locations[] array in the corresponding function below
        
        let saveRightBarButton = UIBarButtonSystemItem.Save
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: saveRightBarButton, target: self, action: #selector(WhereAmIViewController.whereAmISaveButtonAction(_:)))
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if wonderSaved == true {
            var wonderPhotosArray: [Photos] = [] //array to hold wonder multiple photos
            
            let wonderPhotosAppDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let wonderPhotosContext: NSManagedObjectContext = wonderPhotosAppDel.managedObjectContext
            let wonderPhotosFetchRequest = NSFetchRequest(entityName: "Photos")
            wonderPhotosFetchRequest.predicate = NSPredicate(format: "wonderName = %@", wonderName)
            
            do {
                let wonderPhotosFetchResults = try wonderPhotosContext.executeFetchRequest(wonderPhotosFetchRequest) as? [Photos]
                wonderPhotosArray = wonderPhotosFetchResults!
            } catch {
                print("Couldn't fetch \(error)")
            }
            
            if wonderPhotosArray.count > 0 {
                let endIndexOfWonderPhotoArray = wonderPhotosArray.count - 1 //last photo takern, use -1 because array start at 0
                let wonderPhoto: Photos = wonderPhotosArray[endIndexOfWonderPhotoArray] as Photos
                let wonderPhotoImage = UIImage(data: wonderPhoto.wonderPhoto! as NSData)
                
                if (wonderPhotoImage != nil) {
                    uploadImageView.image = wonderPhotoImage
                } else {
                    let wonderDefaultPhotoImage = UIImage(named: "photo_default")
                    uploadImageView.image = wonderDefaultPhotoImage
                }
            }       // end if wonderPhotosArray has 1 or more photos
        }           // end if wonderSaved == true
    }               // end viewWillAppear
    
    
    @IBAction func findMeButtonAction(sender: AnyObject) {
        
        manager.requestWhenInUseAuthorization()
        whereAmIMapView.removeAnnotations(whereAmIMapView.annotations)
        manager.startUpdatingLocation()
    }
    
        @IBAction func whereAmISaveButtonAction(sender: AnyObject) {
            
            if whereAmIWonderName.text!.isEmpty {
                showAlert("Invalid Wonder Name", alertMessage: "Wonder Name Cannot Be Blank!")
            } else {
            
            wonderName = whereAmIWonderName.text!
            
            // Save wonder record to Core Data
            
            let wondersAppDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let wondersContext: NSManagedObjectContext = wondersAppDel.managedObjectContext
            let newWonder = NSEntityDescription.insertNewObjectForEntityForName("Wonders", inManagedObjectContext: wondersContext) as! Wonders
            
            newWonder.wonderName = wonderName
            newWonder.wonderLatitude = Double(whereAmILatitude.text!) ?? 0.0
            newWonder.wonderLongitude = Double(whereAmILongitude.text!) ?? 0.0
            newWonder.wonderShow = true
            newWonder.wonderType = "MY"
            newWonder.wonderNotes = whereAmIAddress.text!
            
            do {
                try wondersContext.save()
                addConfirmationLabel.alpha = 1
                addConfirmationLabel.text = "Saved:" + wonderName
                
                photosButtonLabel.alpha = 1
                cameraButtonLabel.alpha = 1
                uploadButtonLabel.alpha = 1
                uploadImageView.alpha = 1
                
                wonderSaved = true
            } catch {
                addConfirmationLabel.alpha = 1
                addConfirmationLabel.text = "Error:" + wonderName
            }
        }
    }
    
    @IBAction func uploadButtonAction(sender: AnyObject) {
        
        var wonderItems: [AnyObject]?
        let wondersURL: NSURL = NSURL(string: "https://github.com/hemmway")!
        let wondersSignature = "\nLoveWonders! \(wondersURL)"
        
        if (uploadImageView.image != nil) {
            wonderItems = [wonderName, wonderSocialMediaText, uploadImageView.image!, wondersSignature]
        } else {
            wonderItems = [wonderName, wonderSocialMediaText, wondersSignature]
        }
        
        let activityController = UIActivityViewController(activityItems: wonderItems!, applicationActivities: nil)
        
        self.presentViewController(activityController, animated: true, completion: nil)
        
    }   //end uploadButtonAction
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let myLocation: CLLocation = locations[0]
        
        let myLatitude: CLLocationDegrees = myLocation.coordinate.latitude
        let myLongitude: CLLocationDegrees = myLocation.coordinate.longitude
        let myDeltaLatitude: CLLocationDegrees = 0.01
        let myDeltaLongitude: CLLocationDegrees = 0.01
        let mySpan: MKCoordinateSpan = MKCoordinateSpanMake(myDeltaLatitude, myDeltaLongitude)
        let myCurrentLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLatitude, myLongitude)
        let myRegion: MKCoordinateRegion = MKCoordinateRegionMake(myCurrentLocation, mySpan)
        whereAmIMapView.setRegion(myRegion, animated: true)
        
        manager.startUpdatingLocation()
        
        let wonderAnnotation = MKPointAnnotation()
        wonderAnnotation.coordinate = myCurrentLocation
        wonderAnnotation.title = "Here You Are!"
        whereAmIMapView.addAnnotation(wonderAnnotation)
        
        whereAmILatitude.text = "\(myLatitude)"
        whereAmILongitude.text = "\(myLongitude)"
        
        CLGeocoder().reverseGeocodeLocation(myLocation, completionHandler: {(placemarks, error) in
            if ((error) != nil) { print("Error: \(error)") }
            else {
                let p = CLPlacemark(placemark: (placemarks?[0] as CLPlacemark!))
                
                var subThoroughfare: String = ""
                var thoroughfare: String = ""
                var subLocality: String = ""
                var subAdministrativeArea: String = ""
                var postalCode: String = ""
                var country: String = ""
                
                if ((p.subThoroughfare) != nil) {
                    subThoroughfare = (p.subThoroughfare)!
                }
                if ((p.thoroughfare) != nil) {
                    thoroughfare = p.thoroughfare!
                }
                if ((p.subLocality) != nil) {
                    subLocality = p.subLocality!
                }
                if ((p.subAdministrativeArea) != nil) {
                    subAdministrativeArea = p.subAdministrativeArea!
                }
                if ((p.postalCode) != nil) {
                    postalCode = p.postalCode!
                }
                if ((p.country) != nil) {
                    country = p.country!
                }
                
                self.whereAmIAddress.text = "\(subThoroughfare) \(thoroughfare)\n\(subLocality) \(subAdministrativeArea) \(postalCode)\n\(country)"
                
                self.wonderSocialMediaText = "\n" + subAdministrativeArea + " " + country // or anything you like
                }   // end else no error
            }       // end CLGeocoder reverseGeocoderLoacation
        )           // end CLGeocoder
        
        
    }
    
    // Keyboard Control Functions: Return & Touch Outside
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        whereAmIWonderName.resignFirstResponder()
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Show Alert
    
    func showAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: "\(alertMessage)", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {
            action in self.dismissViewControllerAnimated(true, completion: nil) }
        ))
            self.presentViewController(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "whereAmIToPhotos" {
            let vc = segue.destinationViewController as! PhotosViewController
            vc.photosWonderName = wonderName
            vc.photosSourceType = "Photos"
        }
        
        if segue.identifier == "whereAmIToCamera" {
            let vc = segue.destinationViewController as! PhotosViewController
            vc.photosWonderName = wonderName
            vc.photosSourceType = "Camera"
        }
    }
    
}
