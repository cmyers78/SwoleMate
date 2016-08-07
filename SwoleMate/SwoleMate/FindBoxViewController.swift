//
//  FindBoxViewController.swift
//  SwoleMate
//
//  Created by Christopher Myers on 8/5/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit
import MapKit

class FindBoxViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var selectedPin : MKPlacemark? = nil
    var mapName : String = ""
    
    var locationManager = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        
        self.findUserLocation()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func findUserLocation() {
        
        let status = CLAuthorizationStatus.AuthorizedAlways
        
        if status != .Denied {
            self.mapView.showsUserLocation = true
            self.locationManager.requestLocation()
            print(locationManager.location)
        }
    }
    
    // Delegate methods
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        //self.locationManager.startUpdatingLocation()
        self.findUserLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error.localizedDescription)
    }


}

