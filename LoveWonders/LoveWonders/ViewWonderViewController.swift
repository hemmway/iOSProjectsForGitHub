//
//  ViewWonderViewController.swift
//  LoveWonders
//
//  Created by Ivan Kurhanskyi on 9/25/16.
//  Copyright © 2016 Ivan Kurhanskyi. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import CoreLocation

class ViewWonderViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var wonderNameLabel: UILabel!
    @IBOutlet weak var wonderLatitudeLabel: UILabel!
    @IBOutlet weak var wonderLongitudeLabel: UILabel!
    @IBOutlet weak var wonderTextView: UITextView!

    @IBOutlet weak var wonderMapView: MKMapView!
    @IBOutlet weak var wonderImageButtonOutlet: UIButton!
    @IBOutlet weak var numberOfPhotosLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        wonderNameLabel.text = viewSelectedWonderName
        
        //Converting Latitude + Longitude from Double to String
        let cellLatitudeDouble: Double = viewSelectedWonderLatitude as Double!
        let cellLatitudeString: String = String(format: "%.6f", cellLatitudeDouble)
        
        let cellLongitudeDouble: Double = viewSelectedWonderLongitude as Double!
        let cellLongitudeString: String = String(format: "%.6f", cellLongitudeDouble)
        
        wonderLatitudeLabel.text = cellLatitudeString
        wonderLongitudeLabel.text = cellLongitudeString
        
        wonderTextView.text = viewSelectedWonderNotes
        
        // Convert @lat and @lot values to a map location

        let latitude: CLLocationDegrees = viewSelectedWonderLatitude
        let longitude: CLLocationDegrees = viewSelectedWonderLongitude
        
        let deltaLatitude: CLLocationDegrees = 0.01
        let deltaLongitude: CLLocationDegrees = 0.01
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(deltaLatitude, deltaLongitude)
        
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        wonderMapView.setRegion(region, animated: true)
        
        //Annotation are pins with text bubbles on the map
        let wonderAnotation = MKPointAnnotation()
        wonderAnotation.coordinate = location
        wonderAnotation.title = viewSelectedWonderName
        
        wonderMapView.addAnnotation(wonderAnotation)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        // retrieve the Photos entity 1st photo & photo image & total number of Photos
        
        //get Image Data from Core Data
        let photosAppDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let photosContext: NSManagedObjectContext = photosAppDel.managedObjectContext
        let photosFetchRequest = NSFetchRequest(entityName: "Photos")
        
        
        // Create a predicate that selects on the "wonderName" property of the Core Data object
        photosFetchRequest.predicate = NSPredicate(format: "wonderName = %@", viewSelectedWonderName) //select 1 wonder record only
        
        var photos: [Photos] = [] //array to hold 1 wonder photo
        
        do {
            let photosFetchResults = try photosContext.executeFetchRequest(photosFetchRequest) as? [Photos]
            photos = photosFetchResults!
        } catch {
            print("Could not catch \(error)")
        }
        
        numberOfPhotosLabel.text = String(photos.count)
        
        if photos.count == 0 {
            if let image = UIImage(named: "photo_default") {
                wonderImageButtonOutlet.setImage(image, forState: .Normal)
            }
        } else  {
            let photo: Photos = photos[0] //get the 1st photo image
            
            if let thumbnail = UIImage(data: photo.wonderPhoto!) {
                wonderImageButtonOutlet.setImage(thumbnail, forState: .Normal)
            } else {
                if let image = UIImage(named: "photo_default") {
                    wonderImageButtonOutlet.setImage(image, forState: .Normal)
                }
            }
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

}
