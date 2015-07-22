//
//  SignUpViewController.swift
//  SpotMe
//
//  Created by Joel Neukom on 22/07/15.
//  Copyright (c) 2015 TeamD. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.confirmPasswordTextField.delegate = self
        self.emailTextField.delegate = self
        self.signUpButton.enabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickSignUp(sender: AnyObject) {
        self.signUp()
    }
    
    @IBAction func updateData() {
        //self.errorLabel.hidden = true
        updateCreateAccountButtonState()
    }
    
    func updateCreateAccountButtonState() {
        self.signUpButton.enabled = (
            self.usernameTextField.text != "" &&
                self.passwordTextField.text != "" &&
                self.confirmPasswordTextField.text != "" &&
                self.emailTextField.text != "")
    }
    
    func signUp() {
        if let username = self.usernameTextField.text,
            password = self.passwordTextField.text,
            passwordConfirm = self.confirmPasswordTextField.text,
            email = self.emailTextField.text {
                if username != "" && password != "" && passwordConfirm != "" && email != "" {
                    if password == passwordConfirm {
                        var user = PFUser()
                        user.username = username
                        user.password = password
                        user.email = email
                        
                        user.signUpInBackgroundWithBlock() {
                            (succeeded: Bool, error: NSError?) -> Void in
                            if error == nil {
                                var alert = UIAlertController(title: "Success", message: "You successfully signed up for SpotMe", preferredStyle: UIAlertControllerStyle.Alert)
                                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
                                    self.performSegueWithIdentifier("signUptoMap", sender: self)
                                    })
                                self.presentViewController(alert, animated: true, completion: nil)
                            } else {
                                ViewControllerUtils.showPopup("Upps!", message: error!.localizedDescription, controller: self)
                            }
                        }
                    }
                    else {
                        ViewControllerUtils.showPopup("Upps!", message: "Passwords are not identical", controller: self)
                    }
                }
                else {
                    ViewControllerUtils.showPopup("Upps!", message: "Incomplete data", controller: self)
                }
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        }
        else if textField == confirmPasswordTextField {
            emailTextField.becomeFirstResponder()
        }
        else if textField == emailTextField {
            self.signUp()
        }
        
        return true
    }
}
