//
//  Repository.swift
//  tpssAssignment
//
//  Created by Ashish Jain on 30/04/24.
//

import Foundation

class Repository{
    
    static let shared = Repository()
    
    private init(){
        
    }
    
    func getEmployeeData(completion:@escaping([IndividualEmployeeData]?)->Void){
//        checkOfflineEmployeeData(){ employeeData in
//        completion(employeeData)
//        }
        
        checkOfflineEmployeeData { allEmployeeOfflineData in
            if let allEmployeeOfflineData = allEmployeeOfflineData{
                completion(allEmployeeOfflineData)
            }else{
                self.fetchData(){ data in
                    completion(data)
                }
            }
        }
    }
    
    func checkOfflineEmployeeData(completion:@escaping([IndividualEmployeeData]?)->Void){
        DispatchQueue.main.async {
            guard let CDEmployeeData = PersistentStorage.shared.fetchManagedObject(managedObject: CDEmployee.self) else{
                completion(nil)
                return
            }
            var allEmployeeData:[IndividualEmployeeData] = []
            
            for employeeData in CDEmployeeData{
                
                let salary = Int(employeeData.employee_salary)
                let id = Int(employeeData.id)
                let age = Int(employeeData.employee_age)
                guard
                let name = employeeData.employee_name,
                
                
                let profile = employeeData.profile_image
                else{continue}
                
                let individualData = IndividualEmployeeData(id: id, employee_name: name, employee_salary: salary, employee_age: age, profile_image: profile)
                
                allEmployeeData.append(individualData)
                
            }
            if allEmployeeData.count>0{
                completion(allEmployeeData)
            }else{
                completion(nil)
            }
            
            
        }
    }
    
    func fetchData(completion:@escaping([IndividualEmployeeData]?)->Void){
        ApiManager.shared.fetchApiData { result in
            switch result{
                
            case .success(let data):
    //                print(data)
                self.persistData(data: data)
                completion(self.allEmployeeToInidividual(data: data))
            case .failure(let error):
                completion(nil)
                print(error)
            }
        }
    }
    
    func persistData(data:EmployeeData){
        let allEmployeeData = data.data
        
//        if let CDAllEmployeeData = PersistentStorage.shared.fetchManagedObject(managedObject: CDEmployee.self) {
//            for employee in CDAllEmployeeData{
//                print(employee.employee_salary)
//            }
//            
//        }else{
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
//        }
    }
    
    func allEmployeeToInidividual(data:EmployeeData)->[IndividualEmployeeData]{
        
        
        var allEmployeeData:[IndividualEmployeeData] = []
        for employeeData in data.data{
            
            let salary = Int(employeeData.employee_salary)
            let id = Int(employeeData.id)
            let age = Int(employeeData.employee_age)
//            guard
            let name = employeeData.employee_name
            
            
            let profile = employeeData.profile_image
//            else{continue}
            
            let individualData = IndividualEmployeeData(id: id, employee_name: name, employee_salary: salary, employee_age: age, profile_image: profile)
            
            allEmployeeData.append(individualData)
            
        }
        return allEmployeeData
    }
}






