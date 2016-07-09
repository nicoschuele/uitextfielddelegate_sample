//
//  ViewController.swift
//  Text Delegation
//
//  Created by Nico Schuele on 09/07/16.
//  Copyright © 2016 Nico Schuele. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var msg: UITextField!
    @IBOutlet weak var allowEditingSwitch: UISwitch!
    @IBOutlet weak var keyboardStatusLabel: UILabel!
    @IBOutlet weak var editingStatusLabel: UILabel!
    @IBOutlet weak var testWordLabel: UILabel!
    @IBOutlet weak var clearButtonUsedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Subscribe to keyboard show/hide notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil)
        
        // Set current ViewController as delegate for the msg UITextField
        msg.delegate = self
    }
    
    // MARK: Keyboard notifications
    func keyboardWillShow(notification: NSNotification) {
        keyboardStatusLabel.text = "Keyboard is shown"
    }
    
    func keyboardWillHide(notification: NSNotification) {
        keyboardStatusLabel.text = "Keyboard is hidden"
    }
    
    // MARK: UITextFieldDelegate methods
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        // This method is used to prevent/allow editing
        if allowEditingSwitch.on {
            return true
        } else {
            return false
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Method triggered when editing begins
        editingStatusLabel.text = "Editing..."
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // This method 'intercepts' the letters currently typed (or pasted)
        clearButtonUsedLabel.text = "Clear button not used"
        
        var newString: String
        if let value = textField.text {
            newString = value + string
        } else {
            newString = string
        }
        
        if newString.containsString("test") {
            newString = (newString as NSString).stringByReplacingOccurrencesOfString("test", withString: "TESTED!")
            textField.text = newString
            testWordLabel.text = "You tried it!"
            return false
        }
        
        return true
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        // This method is triggered when the clear button within the UITextField is pressed
        clearButtonUsedLabel.text = "Clear button used"
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Method triggered by pressing the return button
        allowEditingSwitch.on = false
        view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        // Method triggered when editing ends
        editingStatusLabel.text = "Done editing"
    }
    
    // MARK: Various actions
    @IBAction func toggleAllowEditing(sender: AnyObject) {
        // Dismiss keyboard by ending editing
        view.endEditing(true)
        
        // Give focus to UITextField if allow editing is on
        if allowEditingSwitch.on {
            msg.becomeFirstResponder()
        }
    }
    
}

