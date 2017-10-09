//
//  AppDelegate.swift
//  SwoleMate
//
//  Created by Christopher Myers on 8/5/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit
import MapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MKMapViewDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    
    /**
     I notice you have an instance of CLLocationManager created here in AppDelegate and also created in
     FindBoxViewController. This is part of what dependency injection helps avoid. As long as FindBoxViewController
     is retained in memory you will have memory allocated for two instances of CLLocationManager. The better
     solution is to create one and then inject it into the classes that need it.
     */
    let manager = CLLocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        manager.delegate = self
        manager.distanceFilter = kCLDistanceFilterNone
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        
        /**
         Your project is based on a tab bar, so what we are doing here is we are taking our instance of
         CLLocationManager and we are injecting it into every child view controller in the tab bar which
         needs it. We know which ones need it because they conform to the LocationManagerInjectable protocol.
         This is called "setting injection" where a method is used to set the value of the injected dependency.
         
         If you were not using storyboards, or if you were creating a manager class which used the
         CLLocationManager instance you could use "constructor injection" also known as "initializer injection"
         where the dependency is injected via the init function. Example:
             class FindBoxViewController() {
                 init(locationManager: CLLocationManager) {
                     self.locationManger = locationManager
                 }
             }
         
         Constructor injection is preferred of all the types because your instance of the class will always be
         completely set up with everything it needs as soon as it is initialized. Using storyboards you can not
         do it but if for example you are using MVVM architecture all of your view models should use constructor
         injection.
             class FindBoxViewModel() {
                 private var locationManager: CLLocationManager
                 init(locationManager: CLLocationManager) {
                     self.locationManger = locationManager
                 }
             }
             class FindBoxViewController() {
                 private var viewModel: FindBoxViewModel?
                 set(locationManager: CLLocationManager) {
                     self.locationManger = locationManager
                     self.viewModel = FindBoxViewModel(locationManager: locationManager)
                 }
             }
         
         By using injection we can test these classes in isolation by injecting mocks for the dependencies.
         This would be called unit testing. When you test files letting them be set up the same way they are
         set up when running the app (with "real" classes) these are called integration tests.
         */
        if let tab = window?.rootViewController as? UITabBarController {
            for child in tab.viewControllers ?? [] {
                if let top = child as? LocationManagerInjectable {
                    top.set(locationManager: manager)
                }
            }
        }
        
        // Override point for customization after application launch.
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.manager.startUpdatingLocation()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

