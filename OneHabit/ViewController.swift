//
//  ViewController.swift
//  OneHabit
//
//  Created by MitraPandey on 17/12/2015.
//  Copyright © 2015 MitraPandey. All rights reserved.
//

import UIKit
import HabitFramework

class ViewController: UIViewController {

    var habit : HabitFramework.HabitModel?
    var history = [Statistics]()
    var timer = NSDate()

    
    @IBOutlet weak var habitCompleteButton: UIButton!
    @IBOutlet weak var labelTimer: UILabel!
    
    @IBAction func habitCompleteButtonPressed(sender: AnyObject) {
        print("habit complete")
        
        // Create a stat object and save it to the stats store
        let stat = HabitFramework.Statistics(name: (habit?.name)!, timeStamp: NSDate())
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
            //print(habit?.name)
            habitCompleteButton.setTitle(habit?.name, forState: UIControlState.Normal)
            //print(habit?.frequency)
            print(habit?.startDate)
            
            // If the habit has already been marked as complete for this time period
            // indicate this to the user and provide an undo button 
            let stats = loadStatistics()
            history = (stats != nil) ? stats! : history
        }
        
        // Setup the countdown timer
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        let today = NSDate()
        let targetDate = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.dateBySettingHour(23, minute: 59, second: 59, ofDate: today, options: NSCalendarOptions.MatchFirst)
        let timeRemaining = targetDate?.timeIntervalSinceDate(today)
        
        print(timeRemaining)
        let minutes = timeRemaining! / 60
        let hours = timeRemaining! / 3600
        
        print(hours)

        //labelTimer.text = formatter.stringFromDate(targetDate!) + " remaining"
        //labelTimer.text = String( + " remaining"
        
        //startCountdown()
        
    }
    
    func startCountdown() {
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: "countdownTick:", userInfo: nil, repeats: true)
    }
    
    func countdownTick(sender: NSTimer!) {
        print("tick")
    }
    
    override func viewDidAppear(animated: Bool) {
        // If there is no habit set, send the user to the initial add habit wizard
        if( habit == nil) {
            performSegueWithIdentifier("firstrun", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadHabit() -> HabitFramework.HabitModel? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(HabitFramework.HabitModel.ArchiveURL.path!) as? HabitFramework.HabitModel
    }
    
    func loadStatistics() -> [Statistics]? {
                print(Statistics.ArchiveURL.path)
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Statistics.ArchiveURL.path!) as? [Statistics]        
    }
    
    @IBAction func unwindToHome(sender: UIStoryboardSegue)
    {
//        let sourceViewController = sender.sourceViewController as! AddHabitFrequency
        // Pull any data from the view controller which initiated the unwind segue.
//        print(sourceViewController.habitName)
        habit = loadHabit()
        habitCompleteButton.setTitle(habit?.name, forState: UIControlState.Normal)
    }

}

