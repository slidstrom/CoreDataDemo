//
//  Family+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by DSIAdmin on 1/7/22.
//
//

import Foundation
import CoreData


extension Family {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Family> {
        return NSFetchRequest<Family>(entityName: "Family")
    }

    @NSManaged public var name: String?
    @NSManaged public var members: NSSet?

}

// MARK: Generated accessors for members
extension Family {

    @objc(addMembersObject:)
    @NSManaged public func addToMembers(_ value: Person)

    @objc(removeMembersObject:)
    @NSManaged public func removeFromMembers(_ value: Person)

    @objc(addMembers:)
    @NSManaged public func addToMembers(_ values: NSSet)

    @objc(removeMembers:)
    @NSManaged public func removeFromMembers(_ values: NSSet)

}

extension Family : Identifiable {

}
