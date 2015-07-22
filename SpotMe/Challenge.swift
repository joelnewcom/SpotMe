//
//  Challenge.swift
//  SpotMe
//
//  Created by Joel Neukom on 22/07/15.
//  Copyright (c) 2015 TeamD. All rights reserved.
//

import Foundation

class Challenge {
    var name : String
    var wayPoints : [PFGeoPoint]
    
    init (name: String) {
        self.name = name
        self.wayPoints = []
    }
    
    func addWayPoint(waypoint: PFGeoPoint) {
        wayPoints.append(waypoint)
    }
}