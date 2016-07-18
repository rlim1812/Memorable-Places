//
//  ViewController.swift
//  Memorable Places
//
//  Created by Ryan Lim on 7/17/16.
//  Copyright © 2016 Ryan Lim. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

//declare array to hold locations
var locationsArray = [CLLocationCoordinate2D]()
var addressesArray = [String]()
var locationIndex = 0

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{

    @IBOutlet weak var map: MKMapView!
    
    var singleLocation = CLLocation()
    var locationManager =  CLLocationManager()
    
    var arbitraryCount = Int()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        arbitraryCount = 0
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(self.action(_:)))
        uilpgr.minimumPressDuration = 2
        map.addGestureRecognizer(uilpgr)
        
    }
    
    func action (gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.locationInView(map)
        var newCoordinate: CLLocationCoordinate2D = self.map.convertPoint(location, toCoordinateFromView: self.map)
        var coordinateAlreadyExists: Bool = false
        var newLat = newCoordinate.latitude
        var newLon = newCoordinate.longitude
        
        for oneLocation in locationsArray {
            var oneLat = oneLocation.latitude
            var  oneLon = oneLocation.longitude
        
            if oneLat == newLat && oneLon == newLon {
                coordinateAlreadyExists = true
            }
        }
        
        if coordinateAlreadyExists != true {
            locationsArray.append(newCoordinate)
            print("Gesture Recognized")
            print("First time")
            print(locationsArray)
            var locationFromCoordinate = CLLocation(latitude: newLat, longitude: newLon)
            CLGeocoder().reverseGeocodeLocation(locationFromCoordinate) { (placemark, error) -> Void in
                if error != nil {
                    print(error)
                } else {
                    if let p = placemark!.first {
                        var subThoroughFare:String = ""
                        if p.subThoroughfare != nil {
                            subThoroughFare = p.subThoroughfare!
                        }
                        var thoroughfare = ""
                        if p.thoroughfare != nil {
                            thoroughfare = p.thoroughfare!
                        }
                        var subLocality = ""
                        if p.subLocality != nil {
                            subLocality = p.subLocality!
                        }
                        var subAdministrativeArea = ""
                        if p.subAdministrativeArea != nil {
                            subAdministrativeArea = p.subAdministrativeArea!
                        }
                        var postalCode = ""
                        if p.postalCode != nil {
                            postalCode = p.postalCode!
                        }
                        var country = ""
                        if p.country != nil {
                            country = p.country!
                        }
                        addressesArray.append("\(subThoroughFare) \(thoroughfare) \n \(subLocality) \(subAdministrativeArea) \n \(postalCode) \n \(country)")
                        print (addressesArray)
                        print("first time")
                    }

                }
                
            }
            
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if arbitraryCount == 0 {
            singleLocation = locations[0]
        
            let latitude = singleLocation.coordinate.latitude
            let longitude = singleLocation.coordinate.longitude
            
            let latDelta: CLLocationDegrees = 0.05
            let lonDelta: CLLocationDegrees = 0.05
        
            let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            let userLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(userLocation, span)
            map.setRegion(region, animated: true)
            arbitraryCount++
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if arbitraryCount > 0 {
                let latDelta: CLLocationDegrees = 0.05
                let lonDelta: CLLocationDegrees = 0.05
                
                let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
                let region: MKCoordinateRegion = MKCoordinateRegionMake(locationsArray[locationIndex], span)
                map.setRegion(region, animated: true)
        }
    }

}

