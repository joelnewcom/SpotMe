//
//  LoginViewController.swift
//  SpotMe
//
//  Created by Joel Neukom on 21/07/15.
//  Copyright (c) 2015 TeamD. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let permissions = ["public_profile"]
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Try Autologin
        // self.facebookLogin()
        
        self.navigationItem.hidesBackButton = true
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        updateLoginButtonState()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func clickLoginWithFacebook(sender: AnyObject) {
        self.facebookLogin()
    }
    @IBAction func clickLogin(sender: AnyObject) {
        self.parseLogin()
    }
    
    @IBAction func usernameEditingChanged(sender: AnyObject) {
        updateLoginButtonState()
        errorLabel.hidden = true
    }
    @IBAction func passwordEditingChanged(sender: AnyObject) {
        updateLoginButtonState()
        errorLabel.hidden = true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
            self.parseLogin()
        }
        return true
    }
    
    func facebookLogin() {
        PFFacebookUtils.logInWithPermissions(self.permissions,
            block: {
                (user: PFUser?, error: NSError?) -> Void in
                if user == nil {
                    NSLog("Uh oh. The user cancelled the Facebook login.")
                } else if user!.isNew {
                    NSLog("User signed up and logged in through Facebook! \(user)")
                    dispatch_async(dispatch_get_main_queue()) {
                        self.performSegueWithIdentifier("logintoMap", sender: self)
                    }
                } else {
                    NSLog("User logged in through Facebook! \(user)")
                    dispatch_async(dispatch_get_main_queue()) {
                        self.performSegueWithIdentifier("logintoMap", sender: self)
                    }
                }
        })
    }
    
    func parseLogin() {
        if let username = usernameTextField.text, let password = passwordTextField.text {
            if username != "" && password != "" {
                PFUser.logInWithUsernameInBackground(username, password: password) {
                    (user: PFUser?, error: NSError?) -> Void in
                    if user != nil {
                        // user exists
                        dispatch_async(dispatch_get_main_queue()) {
                            self.performSegueWithIdentifier("logintoMap", sender: self)
                        }
                    }
                    else {
                        // usesr doesn't exist
                        dispatch_async(dispatch_get_main_queue()) {
                            ViewControllerUtils.showPopup("Upps", message: "Login incorrect", controller: self)
                        }
                    }
                }
            }
            else {
                ViewControllerUtils.showPopup("Upps", message: "Login incorrect", controller: self)
            }
        }
    }
    

    
    func updateLoginButtonState() {
        loginButton.enabled = (usernameTextField.text! != "" && passwordTextField.text! != "")
    }
}
