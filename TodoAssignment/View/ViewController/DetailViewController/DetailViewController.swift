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
        // pullButtonSetting()
        settUpActtion(ations: [
            ("제목순",{self.dataSort(secction: .titleSet)}),
            (("날짜순"),{self.dataSort(secction: .dateSet)}),
            (("우선순위순"),{self.dataSort(secction: .prioritySet)})
        ])
    }
    
    //MARK: 타이틀 말고 섹션 , 액션 를 함수타입으로 받을려합니다.
    fileprivate func settUpActtion(ations: [(String, () -> Void)]) {
        let menuItems = ations.map { title, action in
            UIAction(title: title) { _ in
                action()
            }
        }
        
        var button = homeView.pullDownbutton
        button.setTitle("정렬방식", for: .normal)
        button.showsMenuAsPrimaryAction = true
        button.menu = UIMenu(children: menuItems)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    //MARK: 정렬방식
    fileprivate func dataSort(secction: SortSction) {
        // 구조체 생성
        let loadRealm = try! Realm()
        let model = NewToDoTable.self
        
        switch secction {
        case .titleSet:
            print( secction.rawValue)
            // 정렬하는 방법 Sorted
            let getObject = loadRealm.objects(model).sorted(byKeyPath: secction.rawValue, ascending: true)
            modelData = getObject
            
        case .dateSet:
            print( secction.rawValue)
            
            
        case .prioritySet:
            print( secction.rawValue)
        }
        homeView.tableView.reloadData()
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
    
//    
//    private func pullButtonSetting(){
//        
//        // homeView.pullDownbutton.menu = UIMenu(title: "테스트", children: homeView.menuItems)
//        let rightBarButton = UIBarButtonItem(customView: homeView.pullDownbutton)
//        
//       // let meunuItems:[UIAction] =
//        
//        
//        homeView.pullDownbutton.showsMenuAsPrimaryAction = true
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView:  homeView.pullDownbutton)
//    }
    

    
    override func dataSourceAndDelegate() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        
    }
    override func designView() {
        navigationItem.title = "전체"
        
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

