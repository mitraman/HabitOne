//
//  ViewController.swift
//  OneHabit
//
//  Created by MitraPandey on 17/12/2015.
//  Copyright © 2015 MitraPandey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var habit : HabitModel?
    var history = [Statistics]()
    
    @IBOutlet weak var habitCompleteButton: UIButton!
    
    @IBAction func habitCompleteButtonPressed(sender: AnyObject) {
        print("habit complete")
        
        // Create a stat object and save it to the stats store
        let stat = Statistics(name: (habit?.name)!, timeStamp: NSDate())
        history.append(stat!)
        
        print(history)
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(history, toFile: Statistics.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save stats...")
        }


        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Try to load the habit model from the prop store
        habit = loadHabit()
        print(habit)
        if( habit == nil ) {
            print("no habit found")
        }else {
            print(habit?.name)
            habitCompleteButton.setTitle(habit?.name, forState: UIControlState.Normal)
            print(habit?.frequency)
            
            // If the habit has already been marked as complete for this time period
            // indicate this to the user and provide an undo button 
            let stats = loadStatistics()
            if( stats != nil ) {
                print(stats)
                //print(history[history.endIndex-1])
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        // If there is no habit set, send the user to the initial add habit wizard
        if( habit == nil) {
            performSegueWithIdentifier("startwizard", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadHabit() -> HabitModel? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(HabitModel.ArchiveURL.path!) as? HabitModel

    }
    
    func loadStatistics() -> [Statistics]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Statistics.ArchiveURL.path!) as? [Statistics]
        
    }



}

