//
//  SetHabitFrequency.swift
//  OneHabit
//
//  Created by MitraPandey on 21/12/2015.
//  Copyright © 2015 MitraPandey. All rights reserved.
//

import UIKit

class AddHabitFrequency: UIViewController {
    
    var habitName = ""
    let nextSegue = "next"
    
    @IBOutlet weak var habitLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        habitLabel.text = habitName
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == nextSegue {
            print(segue.destinationViewController)
            let vc = segue.destinationViewController as! AddHabitQuestions
            vc.habitName = habitName
        }
    }

    
}
