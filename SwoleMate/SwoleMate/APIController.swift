//
//  APIController.swift
//  SwoleMateMapTest
//
//  Created by Christopher Myers on 7/25/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit
import MapKit

class APIController: NSObject, CLLocationManagerDelegate  {
    
    let session = NSURLSession.sharedSession()
    
    func findMKBox(lat : Double, long: Double) {
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "crossfit"
        
        let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
        let coordinate = CLLocationCoordinate2DMake(lat, long)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler {
            (response, error) in
            
            if let response = response {
                print(response)
                
                for item in response.mapItems {
                    
                    let theBox = Box()
                    
                    if let name = item.name {
                        theBox.boxName = name
                    }
                    
                    if let phone = item.phoneNumber {
                        theBox.boxPhone = phone
                    }
                    
                    if let webAddress = item.url {
                        theBox.boxURL = webAddress
                    }
                    
                    
                    if let test = item.placemark.addressDictionary {
                        
                        theBox.addressDict = test
                        
                        if let locArray = test["FormattedAddressLines"] as? NSArray {
                            let address = locArray.componentsJoinedByString(", ")
                            
                            theBox.addressFormat = address
                        }
                        
                        
                        
                        
                        
                    }
                    
                    theBox.boxLat = item.placemark.coordinate.latitude
                    
                    theBox.boxLong = item.placemark.coordinate.longitude
                    
                    DataStorage.sharedInstance.addMKBox(theBox)
                }
                
                NSNotificationCenter.defaultCenter().postNotificationName(kNOTIFY, object: nil)
                
            } else {
                print("There was an error searching for: \(request.naturalLanguageQuery) error: \(error)")
                return
            }
        }
    }
    
}
