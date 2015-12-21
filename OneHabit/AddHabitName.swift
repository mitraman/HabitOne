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
    
    // Update model 
    
    @IBAction func habitNameChanged(sender: UITextField) {
        habitName = sender.text!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == nextSegue {
            print(segue.destinationViewController)
            let vc = segue.destinationViewController as! AddHabitFrequency
            vc.habitName = habitName
            
        }
    }

    
}
