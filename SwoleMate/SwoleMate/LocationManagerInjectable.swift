//
//  LocationManagerInjectable.swift
//  SwoleMate
//
//  Created by Abbey Jackson on 2017-10-08.
//  Copyright © 2017 Dragoman Developers, LLC. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationManagerInjectable {
    /**
     This function will allow you to inject the CLLocationManager instance that is used by conforming classes.
     Note you can also make the protocol contain a variable instead of a function however it is better practice
     to have dependency variables be private and used directly only by the class that owns them. Thus instead of
     allowing the variable to be set directly you use a function.
     */
    func set(locationManager: CLLocationManager)
}
