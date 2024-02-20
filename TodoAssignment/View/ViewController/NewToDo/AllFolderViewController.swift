//
//  AllFolderViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/20/24.
//

import UIKit

class AllFolderViewController: BaseHomeViewController<NewTodoHomeView> {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateAndDataSource()
    }
    
    func delegateAndDataSource(){
        homeView.todoTableView.delegate = self
        homeView.todoTableView.dataSource = self
    
    }
}

extension AllFolderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OnlyTitleTableViewCell.reuseabelIdentifier, for: indexPath) as? OnlyTitleTableViewCell else {
            print("cell Register Error")
            return UITableViewCell()
        }
        print("sadsadsada")
        cell.titleLabel.text = "sadasd"
        cell.backgroundColor = .red
        return cell
    }
}
