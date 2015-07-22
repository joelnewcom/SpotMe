//
//  ChallengesViewController.swift
//  SpotMe
//
//  Created by Joel Neukom on 22/07/15.
//  Copyright (c) 2015 TeamD. All rights reserved.
//

import Foundation

class ChallengesViewController: UIViewController {
    
    static let challengeItemClass = "Challenges"
    static let wayPointItemClass = "WayPoints"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func createDummyPoints() {
        var challenge = Challenge(name: "test")
        challenge.addWayPoint(PFGeoPoint(latitude: 5, longitude: 1))
        challenge.addWayPoint(PFGeoPoint(latitude: 7, longitude: 3))
        challenge.addWayPoint(PFGeoPoint(latitude: 54, longitude: 87))
        self.createChallenge(challenge)
    }
    
    class func createChallenge(challenge: Challenge) {
        var pfChallenge = PFObject(className: self.challengeItemClass)
        pfChallenge["name"] = challenge.name
        pfChallenge.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if success {
                println("item was successfully saved")
                for wayPoint in challenge.wayPoints {
                    var pfWayPoint = PFObject(className: self.wayPointItemClass)
                    pfWayPoint["location"] = wayPoint
                    pfWayPoint["challenge"] = pfChallenge
                    pfWayPoint.saveInBackgroundWithBlock {
                        (success: Bool, error: NSError?) -> Void in
                        if success {
                            println("waypoints were successfully saved")
                        }
                        else {
                            println("waypoints were NOT saved")
                        }
                    }
                }
            }
            else {
                println("item was NOT saved")
            }
        }
        
    }
    class func readChallenge(challengeName: String) {
            
    }
}