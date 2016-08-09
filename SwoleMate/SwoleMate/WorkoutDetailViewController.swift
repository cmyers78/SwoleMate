//
//  WorkoutDetailViewController.swift
//  SwoleMate
//
//  Created by Christopher Myers on 8/9/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class WorkoutDetailViewController: UIViewController {

    var receivedWorkout = Workout()
    
    @IBOutlet weak var workoutNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.workoutNameLabel.text = self.receivedWorkout.workoutName
    }

    
}
