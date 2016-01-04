//
//  ChartTest.swift
//  OneHabit
//
//  Created by MitraPandey on 31/12/2015.
//  Copyright © 2015 MitraPandey. All rights reserved.
//

import UIKit
import Charts
import HabitFramework

class CompletionChart: UIViewController {
    
    @IBOutlet var viewPieChart: PieChartView!
    
    struct Metric {
        var hits = 0
        var misses = 0
    }
    



    func loadTestData() -> [HabitFramework.Statistics?] {
        
        return [
            HabitFramework.Statistics(name: "test1", timeStamp: NSDate(timeIntervalSince1970: 1448973240)),
            HabitFramework.Statistics(name: "test1", timeStamp: NSDate(timeIntervalSince1970: 1449146040)),
            HabitFramework.Statistics(name: "test1", timeStamp: NSDate(timeIntervalSince1970: 1449232440)),
            HabitFramework.Statistics(name: "test1", timeStamp: NSDate(timeIntervalSince1970: 1449491640)),
            HabitFramework.Statistics(name: "test1", timeStamp: NSDate(timeIntervalSince1970: 1449664440)),
            HabitFramework.Statistics(name: "test1", timeStamp: NSDate(timeIntervalSince1970: 1450096440)),
            HabitFramework.Statistics(name: "test1", timeStamp: NSDate(timeIntervalSince1970: 1450182840))
        ]
    }
    
    override func viewDidLoad() {
        viewPieChart.usePercentValuesEnabled = true
        
        /*
        let stats = loadStatistics()
        if( stats != nil ) {
            print(stats)
            //print(history[history.endIndex-1])
        }
        */
        
        let stats = loadTestData()
        let startDate = stats[0]?.timeStamp
        let count = countStats(stats, startDate: startDate!, endDate: NSDate())

        let total = count.hits + count.misses
        let missPercent = Double(count.misses) / Double(total)
        let hitPercent = Double(count.hits) / Double(total)
        let yVals1 = [BarChartDataEntry(value: missPercent, xIndex: 0), BarChartDataEntry(value: hitPercent, xIndex: 1)]
        let dataSet = PieChartDataSet(yVals: yVals1, label: "Your Habit Completions")
        dataSet.colors = [UIColor.blueColor(), UIColor.redColor()]
        viewPieChart.data = ChartData(xVals: ["Missed", "Hit"], dataSet: dataSet)


    }

    //TODO: Move this to the HabitFramework module
    func loadStatistics() -> [HabitFramework.Statistics]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Statistics.ArchiveURL.path!) as? [Statistics]
    }
    
    // Assumes that the statistics are in order of date (earliest to latest)
    func countStats(stats: [HabitFramework.Statistics?], startDate: NSDate, endDate: NSDate) -> Metric {
        // Iterate through the array and count the days that have been hit vs. missed
        var lastDate = startDate
        var countStarted = false
        
        var hits = 0;
        var misses = 0;

        for stat in stats {
            // Check if this statistic is later than our start date (but not the same)
            if( stat != nil && !countStarted && stat!.timeStamp.compare(startDate) == NSComparisonResult.OrderedDescending ) {
                countStarted = true
            }
            if( stat != nil && countStarted ) {
                let daysMissed = daysBetween(lastDate, toDate: stat!.timeStamp)
                if( daysMissed == 1 ) {
                    hits++
                }else if( daysMissed > 0 ) {
                    misses += (daysMissed - 1)
                }
                
                lastDate = stat!.timeStamp
            }
        }
        
        return Metric(hits: hits, misses: misses)
    }
    
    func daysBetween(fromDate: NSDate, toDate: NSDate) -> Int {
        let dayDiff = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: fromDate, toDate: toDate, options: NSCalendarOptions.init(rawValue: 0))
        return dayDiff.day
    }
    
    /*
    - (int)daysBetween:(NSDate *)dt1 and:(NSDate *)dt2 {
    NSUInteger unitFlags = NSDayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:dt1 toDate:dt2 options:0];
    return [components day]+1;
    }
*/

}
