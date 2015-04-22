//
//  AnimalsViewController.swift
//  iMoose
//
//  Created by Brent Pendergraft on 4/20/15.
//  Copyright (c) 2015 Bpenderg. All rights reserved.
//

import UIKit
import CoreData

class AnimalsViewController: UIViewController, UITableViewDataSource {

    
    @IBOutlet weak var TableView: UITableView!
    var animals = [NSManagedObject]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Animal")
        
        var error: NSError?
        
        let fetchedResults =
            managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            animals = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    
    
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return animals.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell")
                as! UITableViewCell
            
            let animal = animals[indexPath.row]
            let species = animal.valueForKey("species") as? String
            let color = animal.valueForKey("color") as? String
            let weight = animal.valueForKey("weight") as! Int
            
            var nf = NSNumberFormatter()
            let weightAsString = nf.stringFromNumber(weight)
            
            cell.textLabel!.text = species! + " - " + color! + " - " + weightAsString! + " lbs"
            
            return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "Cell")

        // Do any additional setup after loading the view.
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
