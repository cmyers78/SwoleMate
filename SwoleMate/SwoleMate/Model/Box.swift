//
//  Box.swift
//  MapTestCF
//
//  Created by Christopher Myers on 7/27/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class Box: NSObject {

    var boxName : String = ""
    var boxPhone : String = ""
    var boxURL : URL?
    var boxLat : Double = 0.0
    var boxLong : Double = 0.0
    var addressDict : NSDictionary?
    var addressFormat : String = ""
    
    override init() {
        super.init()
        
        self.boxName = ""
        self.boxPhone = ""
        self.boxLat = 0.0
        self.boxLong = 0.0
        self.addressFormat = ""
    }
    
    func logItems() {
        print(self.boxName)
        print(self.boxPhone)
        print(self.boxLat)
        print(self.boxLong)
        print(self.boxURL ?? "no URL")
    }
}
