//
//  HabitModel.swift
//  OneHabit
//
//  Created by MitraPandey on 17/12/2015.
//  Copyright © 2015 MitraPandey. All rights reserved.
//

import Foundation

protocol HabitListDelegate {
    func habitUpdated()
}

class HabitModel: NSObject, NSCoding {
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("habits")
    
    struct PropertyKey {
        static let nameKey = "name"
        static let frequencyKey = "freq"
    }
    
    var name: String
    var frequency: String
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(frequency, forKey: PropertyKey.frequencyKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let frequency = aDecoder.decodeObjectForKey(PropertyKey.frequencyKey) as! String
        self.init(name: name, frequency: frequency)
    }
    
    init?(name: String, frequency: String) {
        self.name = name
        self.frequency = frequency
        
        super.init()
    }
    
}



