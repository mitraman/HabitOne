//
//  Statistics.swift
//  OneHabit
//
//  Created by MitraPandey on 21/12/2015.
//  Copyright © 2015 MitraPandey. All rights reserved.
//

import Foundation

class Statistics: NSObject, NSCoding {
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("stats")
    
    struct PropertyKey {
        static let nameKey = "name"
        static let timeStampKey = "timeStamp"
    }
    
    var name = String()
    var timeStamp = NSDate()

    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(timeStamp, forKey: PropertyKey.timeStampKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let timeStamp = aDecoder.decodeObjectForKey(PropertyKey.timeStampKey) as! NSDate
        self.init(name: name, timeStamp: timeStamp)
    }
    
    init?(name: String, timeStamp: NSDate) {
        self.name = name
        self.timeStamp = timeStamp
        super.init()
    }

}