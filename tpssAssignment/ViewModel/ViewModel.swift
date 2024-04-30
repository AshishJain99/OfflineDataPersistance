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
    
    
    func fetchAllEmployeeData(){
        self.eventHandler?(.loading)
        Repository.shared.getEmployeeData { data in
            if let data = data{
                self.allEmployeeData = data
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.errorInLoading)
            }
        
        }
    }
    
}

extension ViewModel{
    enum Event{
        case loading
        case stopLoading
        case dataLoaded
        case errorInLoading
    }
}

