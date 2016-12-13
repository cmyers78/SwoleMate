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
    
    var videoURL : URL?

    var receivedWorkout = Workout()
    
    @IBOutlet weak var workoutNameLabel: UILabel!
    
    @IBOutlet weak var workDescLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.workoutNameLabel.text = self.receivedWorkout.workoutName
        self.workDescLabel.text = self.receivedWorkout.workoutDescription
    }

    
    
    @IBAction func videoTapped(_ sender: UIButton) {
        
        self.videoURL = Bundle.main.url( forResource: self.receivedWorkout.workoutVideo, withExtension: "mp4")
        
        self.performSegue(withIdentifier: "videoSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "videoSegue" {
            
            let destinationVC = segue.destination as! AVPlayerViewController
            
            destinationVC.player = AVPlayer(url: self.videoURL!)
        }
    }

    
}
