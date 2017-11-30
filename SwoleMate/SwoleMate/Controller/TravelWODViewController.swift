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
        
        self.workoutArray.append(Workout(name: "The Couch Stretch", workDesc: "The couch stretch involves bending your knee onto the ground and placing the top of your foot against the wall.  If the pressure is too great, lean forward to reduce.", video: "tw-couch", category: "Stretching Exercise", image: "couch"))
        
        self.workoutArray.append(Workout(name: "The Wall Walk", workDesc: "From a plank position with your feet against a wall or door, slowly walk your feet up the wall.  Rest & repeat for 10 rounds.", video: "tw-wallwalk", category: "Body Weight Exercise", image: "wallwalk"))
        self.workoutArray.append(Workout(name: "The Aerobic Complex", workDesc: "For 10 rounds, perform one Burpee, one Broad Jump, and two Air Squats.", video: "tw-aero", category: "Aerobic Exercise", image: "aero"))
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.workoutArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TravelWODTableViewCell
        
        self.theWorkout = self.workoutArray[indexPath.row]
        
        cell.categoryLabel.text = self.theWorkout.workoutCategory
        cell.nameLabel.text = self.theWorkout.workoutName
        
        cell.imageLabel.image = UIImage(named: self.theWorkout.workoutImageName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.theWorkout = self.workoutArray[indexPath.row]
        
        self.performSegue(withIdentifier: "workoutSegue", sender: nil)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "workoutSegue" {
            
            if let controller = segue.destination as? WorkoutDetailViewController {
                
                controller.receivedWorkout = self.theWorkout
            }
                
            else {
                print("Your segue identifier is incorrect")
            }
        }
    }
    
    @IBAction func infoCreditsTapped(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "creditsSegue", sender: self)
    }
    
    
    @IBAction func unwindSegue (_ segue: UIStoryboardSegue) {
        
    }

    
}

