//
//  AnalyticsPageController.swift
//  OneHabit
//
//  Created by MitraPandey on 01/01/2016.
//  Copyright © 2016 MitraPandey. All rights reserved.
//

import UIKit

class AnalyticsPageViewController : UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var targetIndex = 0;
    var currIndex = 0;
    
    var pageViewControllers : [UIViewController] = []
    override func viewDidLoad() {
        
        dataSource = self
        delegate = self
        // Load the analytics view controllers into the page view
        pageViewControllers.append((storyboard?.instantiateViewControllerWithIdentifier("piechart"))!)
        
        // set the initial view controller
        setViewControllers(pageViewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        pageViewControllers.append((storyboard?.instantiateViewControllerWithIdentifier("metrics"))!)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if( currIndex < pageViewControllers.count-1) {
            return pageViewControllers[currIndex+1]
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if( currIndex > 0 ){
            return pageViewControllers[currIndex-1]
        }
        return nil
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return currIndex
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageViewControllers.count
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        currIndex = targetIndex;

    }
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        // Where is the user trying to go?
        var i = 0
        for vc in pageViewControllers {
            if( vc == pendingViewControllers[pendingViewControllers.count-1] ) {
                targetIndex = i
            }
            i++
        }
    }
}
