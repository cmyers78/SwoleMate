//
//  Workout.swift
//  SwoleMate
//
//  Created by Christopher Myers on 8/8/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class Workout: NSObject {
    
    var workoutName : String = ""
    var workoutDescription : String = ""
    var workoutImageName : String = ""
    var workoutVideo : String = ""
    
    
    override init() {
      super.init()
    }
    
    init(name : String, workDesc : String, image : String, video : String) {
        
        self.workoutName = name
        self.workoutDescription = workDesc
        self.workoutImageName = image
        self.workoutVideo = video
    }
}
