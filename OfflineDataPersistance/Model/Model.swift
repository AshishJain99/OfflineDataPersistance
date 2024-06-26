//
//  Model.swift
//  tpssAssignment
//
//  Created by Ashish Jain on 30/04/24.
//

import Foundation

struct EmployeeData: Codable {
    let status: String
    let data: [IndividualEmployeeData]
    let message: String
}

// MARK: - Datum
struct IndividualEmployeeData: Codable {
    let id: Int
    let employee_name: String
    let employee_salary, employee_age: Int
    let profile_image: String

}
