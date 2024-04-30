//
//  CDEmployee+CoreDataProperties.swift
//  tpssAssignment
//
//  Created by Ashish Jain on 30/04/24.
//
//

import Foundation
import CoreData


extension CDEmployee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEmployee> {
        return NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
    }

    @NSManaged public var id: String?
    @NSManaged public var employee_name: String?
    @NSManaged public var employee_salary: String?
    @NSManaged public var employee_age: String?
    @NSManaged public var profile_image: String?

}

extension CDEmployee : Identifiable {

}
