//
//  APIController.swift
//  SwoleMateMapTest
//
//  Created by Christopher Myers on 7/25/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class APIController: NSObject, CLLocationManagerDelegate  {
    
    
    
    let session = NSURLSession.sharedSession()
    
    func findMKBox(lat : Double, long: Double) {
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "crossfit"
        
        let span = MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4)
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
    
//    
//    func fetchGoogleBox(/* will add latitude and longitude parameters later*/) {
//        
//        let initialCount = DataStorage.sharedInstance.numberOfBoxes()
//        print(initialCount)
//        
//        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=40.564978,-111.838973&radius=15000&key=AIzaSyBwcr7URkxBOGP_YrC-e61a6I2qTjeyMII&keyword=crossfit"
//        
//        if let url = NSURL(string: urlString) {
//            
//            let task = session.dataTaskWithURL(url, completionHandler: {
//                (data, response, error) in
//                
//                if error != nil {
//                    print(error?.localizedDescription)
//                    return
//                }
//                
//                if let jsonDictionary = self.parseJSON(data) {
//                    
//                    //print(jsonDictionary)
//                    
//                    if let resultsArray = jsonDictionary["results"] as? JSONArray {
//                        
//                        for dict in resultsArray {
//                            
//                            let aBox = Box()
//                            
//                            if let name = dict["name"] as? String {
//                                aBox.boxName = name
//                            }
//                            
//                            if let vicinity = dict["vicinity"] as? String {
//                                aBox.boxAddressStreet = vicinity
//                                print(aBox.boxAddressStreet)
//                                
//                            }
//                            
//                            if let geometryDict = dict["geometry"] as? JSONDictionary {
//                                
//                                if let locationDict = geometryDict["location"] as? JSONDictionary {
//                                    
//                                    if let latitude = locationDict["lat"] as? Double {
//                                        aBox.boxLat = latitude
//                                    }
//                                    
//                                    if let longitude = locationDict["lng"] as? Double {
//                                        aBox.boxLong = longitude
//                                    }
//                                }
//                            
//                            }
//                            print(aBox.boxName)
//                            print(aBox.boxLat)
//                            print(aBox.boxLong)
//                            print()
//                            print()
//                            
//                            DataStorage.sharedInstance.addGoogleBox(aBox)
//                        }
//                        
//                        DataStorage.sharedInstance.parseGoogleBoxes()
//                        
//                        let finalCount = DataStorage.sharedInstance.numberOfBoxes()
//                        print(finalCount)
//                    }
//                    
//              // postNotfication
//                    
//                } else {
//                    print("I could not parse the dictionary")
//                }
//            
//            })
//            task.resume()
//
//        } else {
//            print("Not a valid url string")
//        }
//    }
//    
//    func parseJSON(data : NSData?) -> JSONDictionary? {
//        
//        var theDictionary : JSONDictionary? = nil
//        
//        if let data = data {
//            
//            do {
//                if let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? JSONDictionary {
//                    
//                    theDictionary = jsonDictionary
//                    //print (jsonDictionary)
//                } else {
//                    print ("I could not print the dictionary")
//                }
//            }
//            
//            catch {
//                
//            }
//        } else {
//            print("I could not unwrap the data")
//        }
//        
//        return theDictionary
//    }
}
