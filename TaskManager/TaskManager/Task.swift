//
//  Task.swift
//  TaskManager
//
//  Created by Adam Hu on 1/8/20.
//  Copyright © 2020 Adam Hu. All rights reserved.
//

import Foundation
import CoreData

public class Task:NSManagedObject, Identifiable{
    @NSManaged public var title:String?
    @NSManaged public var desc:String?
    @NSManaged public var index:Int16
    @NSManaged public var urgency:String?
    @NSManaged public var due:Date?
   
}

