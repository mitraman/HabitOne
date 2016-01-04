//
//  AddHabitQuestions.swift
//  OneHabit
//
//  Created by MitraPandey on 21/12/2015.
//  Copyright © 2015 MitraPandey. All rights reserved.
//

import UIKit
import HabitFramework

class AddHabitQuestions : UIViewController {
    
    let nextSegue = "done"
    
    @IBOutlet weak var habitLabel: UILabel!
    var habitName = ""
    var habitFrequency = ""
    
    
    @IBOutlet weak var SliderQuestion1: UISwitch!
    @IBOutlet weak var SliderQuestion2: UISwitch!
    
    @IBOutlet weak var LabelYes1: UILabel!
    @IBOutlet weak var LabelYes2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        habitLabel.text = habitName
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == nextSegue {
            
            // Save the data in the property store
            let habit = HabitFramework.HabitModel(name: habitName, frequency: habitFrequency, startDate: NSDate())
            saveHabit(habit!)
        }
    }
    
    func barButtonItemClicked(sender:UIBarButtonItem) {
        // The user has clicked the 'next' button, so segue to the next page
        performSegueWithIdentifier(nextSegue, sender: self)
    }

    
    func saveHabit(habit: HabitModel) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(habit, toFile: HabitModel.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save habit data...")
        }
    }
    
    func sliderUpdated() {
        if( SliderQuestion1.on && SliderQuestion2.on ) {
            self.navigationItem.setRightBarButtonItem(UIBarButtonItem(title: "done", style: .Plain, target: self, action: "barButtonItemClicked:"), animated: true)
        }
    }
    
    @IBAction func slider1Changed(sender: AnyObject) {
        sliderUpdated()
    }

    @IBAction func slider2Changed(sender: AnyObject) {
        sliderUpdated()
    }
}
