//
//  LocationService.swift
//  hackUSTapp
//
//  Created by エリック on 2017/04/22.
//  Copyright © 2017年 エリック. All rights reserved.
//


import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate{
    
    static let instance = LocationService()
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    
    override init () {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 50
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        self.currentLocation = locationManager.location?.coordinate
    }
}

