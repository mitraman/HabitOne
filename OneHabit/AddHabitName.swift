//
//  AddHabitName.swift
//  OneHabit
//
//  Created by MitraPandey on 17/12/2015.
//  Copyright © 2015 MitraPandey. All rights reserved.
//

import UIKit

class AddHabitName: UIViewController {
    
    private let nextSegue = "next"
    var habitName = ""
    var nextButtonActive = false

    
    @IBAction func habitNameChanged(sender: UITextField) {
        
        // Update the model with the new text for the habit
        habitName = sender.text!
        
        // Provided that the habitName is legal, display a 'next' button in the navigation bar
        if( sender.text!.isEmpty) {
            if( nextButtonActive ) {
                nextButtonActive = false
                self.navigationItem.rightBarButtonItem = nil;
            }
        }else {
            if( !nextButtonActive ) {
                nextButtonActive = true
                self.navigationItem.setRightBarButtonItem(UIBarButtonItem(title: "next", style: .Plain, target: self, action: "barButtonItemClicked:"), animated: true)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Pass the model data to the next page if a segue is called
        if segue.identifier == nextSegue {
            //print(segue.destinationViewController)
            let vc = segue.destinationViewController as! AddHabitFrequency
            vc.habitName = habitName
            
        }
    }
    
    func barButtonItemClicked(sender:UIBarButtonItem) {
        // The user has clicked the 'next' button, so segue to the next page
        performSegueWithIdentifier(nextSegue, sender: nil)
    }
}
