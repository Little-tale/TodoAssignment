//
//  DetailViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/15/24.
//

import UIKit
import RealmSwift

class DetailViewController: BaseViewController {
    let homeView = DetailHomeView()
    
    override func loadView() {
        self.view = homeView
    }
    var modelData: Results<NewToDoTable>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.pullDownbutton.menu = UIMenu(title: "테스트", children: homeView.menuItems)
        homeView.pullDownbutton.showsMenuAsPrimaryAction = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView:  homeView.pullDownbutton)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let loadRealm = try! Realm()
        
        let model = NewToDoTable.self
        
        let loadObject = loadRealm.objects(model)
        modelData = loadObject
        homeView.tableView.reloadData()
        print(#function)
    }
    
    override func dataSourceAndDelegate() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        
    }
    override func designView() {
        navigationItem.title = "전체"

        let rightBarButton = UIBarButtonItem(customView: homeView.pullDownbutton)
        
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return modelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: UITableViewCell.reuseabelIdentifier)
        print(#function)
        cell.textLabel?.text = modelData[indexPath.row].titleTexts
        let date = DateAssistance().getDate(date: modelData[indexPath.row].endDay)
        cell.detailTextLabel?.text = date
        
        return cell
    }
    
    
}
