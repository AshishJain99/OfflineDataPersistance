//
//  ViewController.swift
//  tpssAssignment
//
//  Created by Ashish Jain on 30/04/24.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView:UITableView!
    
    let viewModel = ViewModel()
    
    var allEmployeeData:[IndividualEmployeeData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        viewModel.fetchData()
        viewModel.fetchAllEmployeeData()
        tableView.register(UINib(nibName: "EmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        configuration()
    }
}


extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEmployeeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EmployeeTableViewCell
        let data = allEmployeeData[indexPath.row]
        cell.employeeData = data
        return cell
    }
    
    
}
extension ViewController{
    
    
    func configuration(){
        initViewModel()
        observerEvent()
    }
    
    func initViewModel(){
        viewModel.fetchAllEmployeeData()
    }
    
    func observerEvent(){
        viewModel.eventHandler = {[weak self] event in
            guard let self = self else{return}
            
            switch event{
                
            case .loading:
                break
            case .stopLoading:
                break
            case .dataLoaded:
//                print(viewModel.allEmployeeData)
                allEmployeeData = viewModel.allEmployeeData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .errorInLoading:
                print("Error")
            }
            
            
        }
    }
}
