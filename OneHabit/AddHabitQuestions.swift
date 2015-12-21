//
//  AddHabitQuestions.swift
//  OneHabit
//
//  Created by MitraPandey on 21/12/2015.
//  Copyright © 2015 MitraPandey. All rights reserved.
//

import UIKit

class AddHabitQuestions : UIViewController {
    
    let nextSegue = "done"
    
    @IBOutlet weak var habitLabel: UILabel!
    var habitName = ""
    var habitFrequency = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        habitLabel.text = habitName
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == nextSegue {
            
            // Save the data in the property store
            var habit = HabitModel(name: habitName, frequency: habitFrequency)
            saveHabit(habit!)

        }
    }
    
    func saveHabit(habit: HabitModel) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(habit, toFile: HabitModel.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save habit data...")
        }
    }

}
