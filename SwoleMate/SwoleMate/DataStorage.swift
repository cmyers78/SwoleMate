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
    
    private override init() {
        
    }
    
    var boxesArray = [Box]()
    
    func addMKBox(box : Box) {
        self.boxesArray.append(box)
        print(box.boxName + " MK")
    }
    
    func numberOfBoxes() -> Int {
        return self.boxesArray.count
    }
    
    func boxesAtIndex(index : Int) -> Box? {
        if self.boxesArray.count >= 0 && index < self.boxesArray.count {
            return self.boxesArray[index]
        }
        return nil
    }

}
