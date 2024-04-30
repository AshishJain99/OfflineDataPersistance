//
//  ApiManager.swift
//  tpssAssignment
//
//  Created by Ashish Jain on 30/04/24.
//

import Foundation

class ApiManager{
    
    static let shared = ApiManager()
    private init(){
        
    }
    
    func fetchApiData(completion:@escaping(Result<EmployeeData,DataFetchingError>)->Void){
        
        guard let url = URL(string: Constants.api) else{
            completion(.failure(.wrongURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
//            print(data)
            
            guard let data = data else{
                completion(.failure(.invalidRespose))
                return
            }
            
            do{
                let employeeData = try JSONDecoder().decode(EmployeeData.self, from: data)
                completion(.success(employeeData))
            }catch{
                completion(.failure(.invalidDataFormatting))
                print("error")
            }
        }.resume()

        
    }
}

enum DataFetchingError:Error{
    case invalidDataFormatting
    case wrongURL
    case invalidRespose
}
