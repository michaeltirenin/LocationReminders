//
//  EditRemindersViewController.swift
//  LocationReminders
//
//  Created by Michael Tirenin on 8/23/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

import UIKit
import CoreData

class EditRemindersViewController: UIViewController, UITextFieldDelegate {
    
    var context : NSManagedObjectContext!
    var reminder : Reminder?
    
    @IBOutlet weak var coordinatesLabel: UILabel!
    @IBOutlet weak var reminderTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Edit Reminder Messages"
        
        self.reminderTitleTextField.delegate = self
        
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.context = appDelegate.managedObjectContext
        
        var request = NSFetchRequest(entityName: "Reminder")
        request.returnsObjectsAsFaults = false
        
        var reminder : NSArray = context.executeFetchRequest(request, error: nil)
        
        var reminders = reminder[0] as NSManagedObject
        
        self.coordinatesLabel.text = ("(" + reminders.valueForKeyPath("latitude").stringValue + ", " + reminders.valueForKeyPath("longitude").stringValue + ")") as String
        self.reminderTitleTextField.text = reminders.valueForKeyPath("reminder") as String
        
        println(self.coordinatesLabel.text)
        println(self.reminderTitleTextField.text)
        println(reminder.count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func saveButton(sender: UIBarButtonItem) {
        
//        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
//        self.context = appDelegate.managedObjectContext

        self.reminder?.reminder = self.reminderTitleTextField.text
        
        var error : NSError?
        //self.reminder?.managedObjectContext.save(nil)
        self.context.save(&error)
        
        if error != nil {
            println(error?.localizedDescription)
        }
        
        self.navigationController.popToRootViewControllerAnimated(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // resigns keyboard if any touch happens in white space
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        for control in self.view.subviews {
            if let theControl = control as? UITextField {
                theControl.resignFirstResponder()
            }
        }
    }
}