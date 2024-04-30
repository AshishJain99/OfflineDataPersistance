//
//  ViewModel.swift
//  tpssAssignment
//
//  Created by Ashish Jain on 30/04/24.
//

import Foundation

class ViewModel{
    
    var allEmployeeData:[IndividualEmployeeData] = []

    
    var eventHandler: ((_ event:Event)->Void)?
    
    // Fetch data from repository
    func fetchAllEmployeeData(){
        self.eventHandler?(.loading)
        Repository.shared.getEmployeeData { data in
            
            // if data is there
            if let data = data{
                self.allEmployeeData = data
                self.eventHandler?(.dataLoaded)
            }else{
                // if data is not available 
                self.eventHandler?(.errorInLoading)
            }
        
        }
    }
    
}

extension ViewModel{
    enum Event{
        case loading
        case dataLoaded
        case errorInLoading
    }
}

