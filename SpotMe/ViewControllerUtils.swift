//
//  ViewControllerUtils.swift
//  SpotMe
//
//  Created by Joel Neukom on 22/07/15.
//  Copyright (c) 2015 TeamD. All rights reserved.
//

import UIKit

class ViewControllerUtils {
    class func showPopup(title: String, message: String, controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        controller.presentViewController(alertController, animated: true, completion: nil)
    }
}