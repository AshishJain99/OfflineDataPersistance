//
//  EmployeeTableViewCell.swift
//  tpssAssignment
//
//  Created by Ashish Jain on 30/04/24.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var employeeImageView:UIImageView!
    @IBOutlet weak var employeeName:UILabel!
    @IBOutlet weak var employeeId:UILabel!
    @IBOutlet weak var employeeSalary:UILabel!
    @IBOutlet weak var employeeAge:UILabel!
    
    var employeeData:IndividualEmployeeData?{
        didSet{
            SetupCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func SetupCell(){
        guard let employeeData = employeeData else{return}
        self.employeeImageView.backgroundColor = .red
        self.employeeId.text = "Id: \(String(employeeData.id))"
        self.employeeName.text = "Name: \(String(employeeData.employee_name))"
        self.employeeSalary.text = "Salary: \(String(employeeData.employee_salary))"
        self.employeeAge.text = "Age: \(String(employeeData.employee_age))"
        
    }
    
}
