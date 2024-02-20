//
//  AllFolderViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/20/24.
//

import UIKit

class AllFolderViewController: BaseHomeViewController<NewTodoHomeView> {

    let repository = NewToDoRepository()
    lazy var folderList = repository.NewToDoFolder()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateAndDataSource()
    }
    
    func delegateAndDataSource(){
        homeView.todoTableView.delegate = self
        homeView.todoTableView.dataSource = self
        homeView.todoTableView.rowHeight = UITableView.automaticDimension
        homeView.todoTableView.estimatedRowHeight = 40
    }
}

extension AllFolderViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return folderList.count
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // let data = folderList.map { $0.newTodoTable }
        return folderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: listTableViewCell.reuseabelIdentifier, for: indexPath) as? listTableViewCell else {
            print("cell Register Error")
            return UITableViewCell()
        }
        let data = folderList[indexPath.row]
        
        cell.titleLabel.text = data.folderName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(folderList[indexPath.row])
        let data = folderList[indexPath.row]
        NotificationCenter.default.post(name: NSNotification.Name("folderData"), object: self, userInfo: ["folderdata": data ])
        
        navigationController?.popViewController(animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}



