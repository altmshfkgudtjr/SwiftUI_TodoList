//
//  Task+CoreDataProperties.swift
//  TodoList
//
//  Created by 김형석 on 2021/01/12.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var title: String?
    @NSManaged public var brief: String?
    @NSManaged public var isDone: Bool
    @NSManaged public var isToday: Bool

}

extension Task : Identifiable {
    
}
