//
//  TravelWODViewController.swift
//  SwoleMate
//
//  Created by Christopher Myers on 8/5/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class TravelWODViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var workoutArray = [Workout]()
    
    var theWorkout = Workout()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.workoutArray.append(Workout(name: "The Couch Stretch", workDesc: "The couch stretch involves pressing your foot...", video: "tw-couch", category: "Stretching Exercise", image: "couch"))
        
        self.workoutArray.append(Workout(name: "The Wall Walk", workDesc: "add description later", video: "tw-wallwalk", category: "Body Weight Exercise", image: "wallwalk"))
        self.workoutArray.append(Workout(name: "The Aerobic Complex", workDesc: "Burpee, Broad Jump, Air Squats x 2 for 10 rounds", video: "tw-aero", category: "Aerobic Exercise", image: "aero"))
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.workoutArray.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TravelWODTableViewCell
        
        self.theWorkout = self.workoutArray[indexPath.row]
        
        cell.categoryLabel.text = self.theWorkout.workoutCategory
        cell.nameLabel.text = self.theWorkout.workoutName
        
        cell.imageLabel.image = UIImage(named: self.theWorkout.workoutImageName)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
}

