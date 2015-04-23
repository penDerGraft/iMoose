//
//  AnimalMapViewController.swift
//  iMoose
//
//  Created by Brent Pendergraft on 4/22/15.
//  Copyright (c) 2015 Bpenderg. All rights reserved.
//

import UIKit
import MapKit
import CoreData

// Need to create extention for NSManagedObject (if possible)

class AnimalMapViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }
    
    var animalLocations = [MKAnnotation]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
    
        let managedContext = appDelegate.managedObjectContext!
    
        let fetchRequest = NSFetchRequest(entityName:"Animal")
    
        var error: NSError?
    
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest, error: &error) as? [Animal]
    
        if let results = fetchedResults {
            animalLocations = results
            mapView.addAnnotations(animalLocations)
            mapView.showAnnotations(animalLocations, animated: true)
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
    }
    
    
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        var view = mapView.dequeueReusableAnnotationViewWithIdentifier(Constants.AnnotationViewReuseIdentifier)
        
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: Constants.AnnotationViewReuseIdentifier)
            view.canShowCallout = true
        } else {
            view.annotation = annotation
        }
        
        view.leftCalloutAccessoryView = nil
        view.rightCalloutAccessoryView = nil
        if let point = annotation as? Animal {
            if UIImage(data: point.photo) != nil {
                view.leftCalloutAccessoryView = UIImageView(frame: Constants.LeftCalloutFrame)
            }
            view.rightCalloutAccessoryView = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIButton

        }
        
        return view
    }
    
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        if let point = view.annotation as? Animal {
            if let thumbnailImageView = view.leftCalloutAccessoryView as? UIImageView {
                if UIImage(data: point.photo) != nil {
                    thumbnailImageView.image = UIImage(data: point.photo)
                }
            }
        }
    }
    
    
    private struct Constants {
        static let LeftCalloutFrame = CGRect(x: 0, y: 0, width: 59, height: 59)
        static let AnnotationViewReuseIdentifier = "animal"
        static let ShowImageSegue = "Show Details"
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
