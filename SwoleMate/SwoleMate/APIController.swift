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
                    
                    if let test = item.placemark.addressDictionary?["FormattedAddressLines"] as? NSArray{
                        if test.count == 3 {
                            
                            theBox.boxAddressStreet = test[0] as! String
                            theBox.boxAddressCSZ = test[1] as! String
                            theBox.boxAddressCountry = test[2] as! String
                            
                        } else {
                            theBox.boxAddressStreet = test[0] as! String
                            theBox.boxAddressSuite = test[1]  as! String
                            theBox.boxAddressCSZ = test[2] as! String
                            theBox.boxAddressCountry = test[3] as! String
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
