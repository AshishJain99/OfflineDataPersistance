//
//  ViewModel.swift
//  tpssAssignment
//
//  Created by Ashish Jain on 30/04/24.
//

import Foundation

class ViewModel{
    
    
    func fetchData(){
        ApiManager.shared.fetchApiData { result in
            switch result{
                
            case .success(let data):
//                print(data)
                self.persistData(data: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func persistData(data:EmployeeData){
        let allEmployeeData = data.data
        
        if let CDAllEmployeeData = PersistentStorage.shared.fetchManagedObject(managedObject: CDEmployee.self) {
            let employee = CDAllEmployeeData[0]
            for employee in CDAllEmployeeData{
                print(employee.employee_salary)
            }
            
        }else{
            DispatchQueue.main.async {
                for employee in allEmployeeData {
                            print(employee)
                            let employeeData = CDEmployee(context: PersistentStorage.shared.context)
                            employeeData.id = Int16(employee.id)
                            employeeData.employee_name = employee.employee_name
                    print(employee.employee_salary)
                            employeeData.employee_salary = Int64(employee.employee_salary)
                            employeeData.employee_age = Int16(employee.employee_age)
                            employeeData.profile_image = employee.profile_image
                            print("")
                            PersistentStorage.shared.saveContext()
                        }
                
                DispatchQueue.main.asyncAfter(deadline: .now()+2){
                                let x = PersistentStorage.shared.fetchManagedObject(managedObject: CDEmployee.self)
                                print(x,"dataaaaaxxxx")
                            }
            }
        }
        
        
        
        
    }
    
}
