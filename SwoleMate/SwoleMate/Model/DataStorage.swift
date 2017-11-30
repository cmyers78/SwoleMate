//
//  DataStorage.swift
//  MapTestCF
//
//  Created by Christopher Myers on 7/28/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit
import MapKit

class DataStorage: NSObject {
    
    static let sharedInstance = DataStorage()
    
    fileprivate override init() {
        
    }
    
    var boxesArray = [Box]()
    
    func addMKBox(_ box : Box) {
        self.boxesArray.append(box)
        print(box.boxName + " MK")
    }
    
    func numberOfBoxes() -> Int {
        return self.boxesArray.count
    }
    func boxesAtIndex(_ index : Int) -> Box? {
        if self.boxesArray.count >= 0 && index < self.boxesArray.count {
            return self.boxesArray[index]
        }
        return nil
    }
    
    
    func removeBoxes() {
        self.boxesArray.removeAll()
    }

}
