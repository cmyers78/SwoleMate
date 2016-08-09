//
//  WorkoutDetailViewController.swift
//  SwoleMate
//
//  Created by Christopher Myers on 8/9/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class WorkoutDetailViewController: UIViewController, AVPlayerViewControllerDelegate {
    
    var videoURL : NSURL?

    var receivedWorkout = Workout()
    
    @IBOutlet weak var workoutNameLabel: UILabel!
    
    @IBOutlet weak var workDescLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.workoutNameLabel.text = self.receivedWorkout.workoutName
        self.workDescLabel.text = self.receivedWorkout.workoutDescription
    }

    
    
    @IBAction func videoTapped(sender: UIButton) {
        
        self.videoURL = NSBundle.mainBundle().URLForResource( self.receivedWorkout.workoutVideo, withExtension: "mp4")
        
        self.performSegueWithIdentifier("videoSegue", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "videoSegue" {
            
            let destinationVC = segue.destinationViewController as! AVPlayerViewController
            
            destinationVC.player = AVPlayer(URL: self.videoURL!)
        }
    }

    
}
