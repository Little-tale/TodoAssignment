//
//  DetailViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/15/24.
//

import UIKit
import RealmSwift

// 상태 관ㄴ리 구조체
//struct SectionState {
//    var totleSet: Bool = false
//    var dataSet: Bool = false
//    var prioritySet: Bool = false
//}

class DetailViewController: BaseViewController {
    let homeView = DetailHomeView()
    
    // let sectionState = SectionState()
    
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
            (("우선순위순"),{self.dataSort(secction: .prioritySet)}),
            (("우선순위만"),{self.dataSort(secction: .onlyprioritySet)})
        ])
        
    }
    
    //MARK: 타이틀 말고 섹션 , 액션 를 함수타입으로 받을려합니다.
    private func settUpActtion(ations: [(String, () -> Void)]) {
        let menuItems = ations.map { title, action in
            UIAction(title: title) { realAction in
                action()
                // realAction.state = realAction.state == .on ? .off : .on
                /*
                 *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Action is immutable because it is a child of a menu'
                 *** First throw call stack:
                 */
                
            }
        }
        
        let button = homeView.pullDownbutton
        button.setTitle("정렬방식", for: .normal)
        button.showsMenuAsPrimaryAction = true
        button.menu = UIMenu(children: menuItems)
        button.changesSelectionAsPrimaryAction = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        // button.changesSelectionAsPrimaryAction = true
       
    }
    
    
    //MARK: 정렬방식
    private func dataSort(secction: SortSction) {
        // 구조체 생성
        let loadRealm = try! Realm()
        let model = NewToDoTable.self
        // MARK: 해당 코드에서 그냥 이 섹션들은 해당하는 케이스에 대해 true 인가 false 인가로 해보면 될것가틈 bool을 어떻게 처리하지....?
        switch secction {
        case .onlyprioritySet:
            let getOvject = loadRealm.objects(model).where {
                $0.priorityNumber != 0
            }
            modelData = getOvject
        default :
            print(#function)
            let getOvject = loadRealm.objects(model).sorted(byKeyPath: secction.getQuery, ascending: true)
            modelData = getOvject
        }
        print(modelData)
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
    
    // https://www.mongodb.com/docs/realm/sdk/swift/crud/filter-data/#std-label-ios-nspredicate-query

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

/*
 //        case .titleSet:
 //            print( secction.rawValue)
 //            // 정렬하는 방법 Sorted
 //            let getObject = loadRealm.objects(model).sorted(byKeyPath: secction.rawValue, ascending: true)
 //            modelData = getObject
 //
 //        case .dateSet:
 //            print( secction.rawValue)
 //
 //            // 쿼리 엔진의 비교연산자를 통해 날짜순으로 정렬해 보려고 합니다.
 //            // 아.... 그건 다른걸로!
 //            let getObject = loadRealm.objects(model).sorted(byKeyPath: secction.rawValue, ascending: true)
 //            modelData = getObject
 //
 //        case .prioritySet:
 //            print( secction.rawValue)
 //            let getObject = loadRealm.objects(model).sorted(byKeyPath: secction.rawValue, ascending: true)
 //            modelData = getObject
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
 https://medium.com/@rohit236c/ios-pull-down-menus-the-newer-way-of-interaction-a255ceb3a28e
 */
