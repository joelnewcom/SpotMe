//
//  MapViewController.swift
//  SpotMe
//
//  Created by Joel Neukom on 21/07/15.
//  Copyright (c) 2015 TeamD. All rights reserved.
//
import UIKit

class MapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.distanceFilter = 500
        self.locationManager.requestWhenInUseAuthorization()
        
        var camera = GMSCameraPosition.cameraWithLatitude(47.498995, longitude: 8.728665, zoom: 5)
        var mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.settings.compassButton = false
        mapView.settings.myLocationButton = false
        mapView.delegate = self
        self.view = mapView
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updateLocation(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateLocation(running: Bool) {
        let mapView = self.view as! GMSMapView
        let status = CLLocationManager.authorizationStatus()
        if running {
            if (CLAuthorizationStatus.AuthorizedWhenInUse == status) {
                locationManager.startUpdatingLocation()
            }
        } else {
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    func logout() {
        PFUser.logOut()
        FBSession.activeSession().closeAndClearTokenInformation()
    }
    
    @IBAction func clickLogout(sender: AnyObject) {
        self.logout()
        self.performSegueWithIdentifier("toLogin", sender: self)
    }


}