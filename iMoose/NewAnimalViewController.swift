//
//  NewAnimalViewController.swift
//  iMoose
//
//  Created by Brent Pendergraft on 4/20/15.
//  Copyright (c) 2015 Bpenderg. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class NewAnimalViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    var coordinates = CLLocationCoordinate2D (
        latitude: 0.0,
        longitude: 0.0
    )
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        } else {
            println("Location services are not enabled");
        }
       
    }
    
    // MARK: - CoreLocation Delegate Methods
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        locationManager.stopUpdatingLocation()
        if ((error) != nil) {
            print(error)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        let locArray = locations as NSArray
        let location = locations.last as! CLLocation
        
        coordinates = location.coordinate
        
//        lat = location.coordinate.latitude
//        long = location.coordinate.longitude
//        println(lat)
//        println(long)                
    }
    
    
    @IBOutlet weak var speciesTextBox: UITextField!
    @IBOutlet weak var colorTextBox: UITextField!
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var weightLabel: UILabel!

    
    
    @IBAction func saveAnimal(sender: UIButton) {
        let species = speciesTextBox.text
        let color = colorTextBox.text
        let weight = weightSlider.value
        
        //delegate init
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //entity init
        let entity =  NSEntityDescription.entityForName("Animal",
            inManagedObjectContext:
            managedContext)
        
        let animal = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        animal.setValue(species, forKey: "species")
        animal.setValue(color, forKey: "color")
        animal.setValue(weight, forKey: "weight")
        
        if coordinates.latitude != 0.0 {
            animal.setValue(coordinates.latitude, forKey: "latitude")
        }
        
        if coordinates.longitude != 0.0 {
            animal.setValue(coordinates.longitude, forKey: "longitude")
        }
        
        println(coordinates.latitude)
        println(coordinates.longitude)
        
        
        var error: NSError?
        
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
    }
    
    @IBAction func sliderChange() {
        let nf = NSNumberFormatter()
        let sliderValue = nf.stringFromNumber(weightSlider.value)
        weightLabel.text = sliderValue
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
