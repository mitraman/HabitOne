//
//  HabitButton.swift
//  OneHabit
//
//  Created by MitraPandey on 01/01/2016.
//  Copyright © 2016 MitraPandey. All rights reserved.
//

import UIKit

public class HabitButton : UIButton {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonWidth = frame.width
        //et buttonHeight = frame.height
        let radius = Double(buttonWidth) / Double(2.0)
        
        // Try to set the height to be the same as the width
//        frame.height = frame.width
        
        //frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.width)
        
        layer.cornerRadius = CGFloat(radius)
        layer.borderColor = UIColor.blueColor().CGColor
        layer.masksToBounds = true
        layer.borderWidth = CGFloat(Double(1.0))
        
        layoutIfNeeded()
        
    }
}
