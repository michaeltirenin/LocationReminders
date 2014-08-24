//
//  Reminder.swift
//  LocationReminders
//
//  Created by Michael Tirenin on 8/23/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

import Foundation
import CoreData

class Reminder: NSManagedObject {

    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var reminder: String

}
