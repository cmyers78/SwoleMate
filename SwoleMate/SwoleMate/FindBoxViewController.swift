//
//  FindBoxViewController.swift
//  SwoleMate
//
//  Created by Christopher Myers on 8/5/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit
import MapKit

extension FindBoxViewController: LocationManagerInjectable {
    
    func set(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        /**
         Here you could set the value of a `var locationManager: CLLocationManager` to the value of manager
         and then on `didSet` for the property you could call the set up function. Or you could all the setup
         function here and use the local property rather than pass it through...There are many ways of doing it.
         
         Because you are performing actions using the location manager when your buttons are tapped you will
         want to store the manager as a local property, not pass it through. If you were going to pass it through
         though your functions would all take the manager for example:
             func setUpCLLocationManager(_ manager: CLLocationManager)
             func findUserLocation(_ manager: CLLocationManager)
         */
        setUpCLLocationManager()
    }
    
    func setUpCLLocationManager() {
        /**
         Note I just copied and pasted your code, I actually have not worked enough with CLLocationManager to
         know what changes you would need to make to your delegate handling but it would be a good exercise for
         you to finish what I've started on this branch.
         */
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
    }
}

class FindBoxViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var selectedPin : MKPlacemark? = nil
    var mapName : String = ""
    
    let controller = APIController()
    
    fileprivate var locationManager: CLLocationManager?
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.findUserLocation()
        
    }
    
    // MARK : Custom Functions

    func findUserLocation() {
        
        let status = CLAuthorizationStatus.authorizedAlways
        
        if status != .denied {
            locationManager?.startUpdatingLocation()
            self.mapView.showsUserLocation = true
            locationManager?.requestLocation()
            print(locationManager?.location)
            
            locationManager?.stopUpdatingLocation()
        }
    }
    
    func dropPin() {
        print("drop pin called")
        
        if DataStorage.sharedInstance.numberOfBoxes() > 0 {
            for box in DataStorage.sharedInstance.boxesArray {
                
                self.addPin(box.boxLat, pinLong: box.boxLong, title: box.boxName, address: box.addressFormat)
            }
            
        } else {
            
            self.alert()
        }
    }
    
    func alert() {
        
        let alert = UIAlertController(title: "GYM NOT FOUND", message: "There are no gyms in your area. Try our Travel WOD.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .default) {
                                            (action) in
        }
        
        // Add the cancel action
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK : Annotations
    
    func addPin(_ pinLat : Double, pinLong : Double, title : String, address : String) {
        
        let location = CLLocationCoordinate2D(latitude: pinLat, longitude: pinLong)
        let annotation = CustomBoxMKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title
        annotation.subtitle = address
        
        self.mapView.addAnnotation(annotation)
    }

    
    // MARK: Delegate methods
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        self.findUserLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.count > 0 {
            let location = locations.last
            print(location?.coordinate.latitude)
            print(location?.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            if let center = location?.coordinate {
                let region = MKCoordinateRegion(center: center, span: span)
                
                self.mapView.setRegion(region, animated: true)
                self.mapView.showsUserLocation = true
                //self.locationManager.startUpdatingLocation()
            }
        }
    
        if let loc = locationManager?.location {
            
            print(loc.coordinate)
            
            let lat = loc.coordinate.latitude
            let long = loc.coordinate.longitude
            
            controller.findMKBox(lat, long: long)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.dropPin), name: NSNotification.Name(rawValue: kNOTIFY), object: nil)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        if annotation.isKind(of: CustomBoxMKPointAnnotation.self) {
            let identifier = "kettleBell"
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            if let annotationView = annotationView {
                
                annotationView.canShowCallout = true
                
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
                imageView.contentMode = .scaleAspectFit
                
                imageView.image = UIImage(named: "kettlebellx24")
                
                let smallSquare = CGSize(width: 30, height: 30)
                let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
                button.setBackgroundImage(UIImage(named: "carX32"), for: UIControlState())
                button.addTarget(self, action: #selector(self.getDirections), for: .touchUpInside)
                annotationView.leftCalloutAccessoryView = button
                
                annotationView.image = imageView.image
                
                return annotationView
            }
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        //print("POPUP ANNOTATE")
        // I need to set selectedPin equal to the pin's coordinates
        if let coordinate = view.annotation?.coordinate {
            
            let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
            self.selectedPin = placemark
            
            if let mName = view.annotation?.title {
                self.mapName = mName!
            }
        }
    }
    
    // MARK : Annotation-related Functions
    
    func getDirections() {
        print("button tapped")
        
        let mapItem = MKMapItem(placemark: self.selectedPin!)
        mapItem.name = self.mapName
        if let lat = self.selectedPin?.coordinate.latitude, let long = self.selectedPin?.coordinate.longitude {
            
            let regionDistance : CLLocationDistance = 7500
            
            let coord = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let regionSpan = MKCoordinateRegionMakeWithDistance(coord, regionDistance, regionDistance)
            
            let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span), MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving ] as [String : Any]
            
            mapItem.openInMaps(launchOptions: options)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

    @IBAction func findUserTapped(_ sender: UIButton) {
        
        /**
         Because of this implementation you would probably need to have the location manager instance stored
         locally because when this button is tapped you have no way of passing the instance in.
         */
        self.findUserLocation()
        
    }
    
    @IBAction func reloadBoxesTapped(_ sender: UIButton) {
        
        DataStorage.sharedInstance.removeBoxes()
        
        self.mapView.setCenter(mapView.region.center, animated: true)
        
        if let findNew = locationManager?.location {
            
            let lat = findNew.coordinate.latitude
            let longitude = findNew.coordinate.longitude
            
            
            controller.findMKBox(lat, long: longitude)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.dropPin), name: NSNotification.Name(rawValue: kNOTIFY), object: nil)
        
    }
    

}

