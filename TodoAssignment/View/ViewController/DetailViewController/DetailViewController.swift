//
//  DetailViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/15/24.
//

import UIKit
import RealmSwift


class DetailViewController: DetailBaseViewController<DetailHomeView> {

    // MARK: 테스트 단계인 버튼이 키고 아이디가 벨류
    var modelButtonDictionary: [UIButton: ObjectId] = [:]
    let fileManager = SaveImageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //settingActions()
    }

  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        baseHomeView.tableView.reloadData()
        print(#function,"*****")
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //MARK: 이시점에서도 이미지 원형 잡아주는것도 좋음
        
    }

    override func dataSourceAndDelegate() {
        baseHomeView.tableView.delegate = self
        baseHomeView.tableView.dataSource = self
        baseHomeView.tableView.rowHeight = UITableView.automaticDimension
        baseHomeView.tableView.estimatedRowHeight = 100
        // baseHomeView.tableView.setEditing(true, animated: true)
    }
    
}
// MARK: 디테일 뷰 컨트롤러 딜리게이트 데이타 소스
extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return testList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseabelIdentifier, for: indexPath) as? DetailTableViewCell else {
            print("셀 레지스터 문제")
            return UITableViewCell()
        }
        
        let modelDatas = testList[indexPath.row]
        cellDataSetting(for: cell, modelData: modelDatas)
        
        
        print(modelDatas)
        return cell
    }
    
    // MARK: 스와이프 방향 정해주고 보이기하기
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "삭제") { UIContextualAction, UIView, success in
            
            UIView.backgroundColor = .blue
            // 실제 데이터 를 먼저 삭제후 테이블뷰 딜리트 해야함
            self.deleteContextualAction(indexPathRow: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            // ->
            
            
            success(true)
        }
        
        let modify = UIContextualAction(style: .normal, title: "깃발" ) { action, view, sucsess in
            view.backgroundColor = .green
            action.backgroundColor = .orange
            self.toggleFlag(indexPath: indexPath)
            
            sucsess(true)
        }
        modify.backgroundColor = .orange
        
        // 액션들을 담아줌
        return UISwipeActionsConfiguration(actions: [delete,modify])
    }

    // MARK: 해당하는 데이터를 지워 드립니다.
    private func deleteContextualAction(indexPathRow: Int) {
        let data = testList[indexPathRow]
        fileManager.deleteFileDocuments(fileCase: .image, fileNameID: "\(data.id)")
        repository.removeAt(data)
    }
    
    // MARK: 깃발을 토글
    private func toggleFlag(indexPath: IndexPath){
        repository.toggleOf(modle_ID: testList[indexPath.row].id)
        //baseHomeView.tableView.reloadRows(at: [indexPath], with: .automatic)
        if viewType == .flag {
            baseHomeView.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: 셀 데이터 세팅 메서드
    private func cellDataSetting(for cell: DetailTableViewCell, modelData: NewToDoTable){
        
        let date = DateAssistance().getDate(date: modelData.endDay)
        let prioritynum = modelData.priorityNumber
        
        cell.mainLabel.text = modelData.titleTexts
        cell.dateLabel.text = date
        cell.tagLabel.text = modelData.tagText
        cell.priLabel.text = getPrivorityText(number: prioritynum)
        cell.subTitleLabel.text = modelData.memoTexts
        cell.leftButton.isSelected = modelData.complite
        cell.leftButton.addTarget(self, action: #selector(toggleOfComplite), for: .touchUpInside)
        
        if let image = fileManager.loadImageToDocuments(fileCase: .image, fileNameOfID: "\(modelData.id)") {
            print("*****",image, modelData.id)
            cell.imagePrepare(image: image)
        }
        
        modelButtonDictionary[cell.leftButton] = modelData.id
    }
    
    
    
    // MARK: 버튼을 누르면 각 버튼을 구분지어 무엇을 눌렀는지
    @objc
    func toggleOfComplite(_ sender: UIButton) {

        print(modelButtonDictionary[sender] ?? "")
        // 버튼 선택상태를 -> 컴플리트 상태값으로
        print(sender.isSelected)
        
        let objectId = modelButtonDictionary[sender]
        // 아이디가 옵셔널 바인딩이 안되면 에러 띄움
        guard let objectId = objectId else {
            let alert = AlertManager().showAlert(error: RealmErrorCase.cantWriteObject)
            present(alert,animated: true)
            return
        }
        
        do {
            try repository.compliteUpdater(model_Id: objectId, ButtonBool: sender.isSelected)
        } catch {
            let alert = AlertManager().showAlert(error: error)
            present(alert, animated: true)
        }
    }
 
}

extension DetailViewController {
    // MARK: 우선순위 값을 변경해드립니다.
    func getPrivorityText(number: Int) -> String{
        prioritization.allCases[number].exclamationMark
    }
}

extension DetailViewController {
    func reloadData(bool: Bool){
        if bool == true {
            baseHomeView.tableView.reloadData()
        }
    }
}





/*
 // MARK: 모델 데이터 받을 공간
//    var modelData: Results<NewToDoTable>! {
//        didSet {
//            print("이건 왜 감지하지?")
//            baseHomeView.tableView.reloadData()
//        }
//    }
 // MARK: 기준이 될 데이터 공간
 // var centerData : Results<NewToDoTable>!
 
 /*
  // MARK: 테스트를 위한 공간인데 여긴 액션을 따로 작업]
 
  // MARK: 액션을 여기서 만들고 정의합니다.
//    func settingActions(){
//        let menuIntems: [UIAction] = {
//            SortSction.allCases.map { section in
//                return UIAction(title: section.setTitle) { action in
//                    self.modelData = self.repository.dataSort(dataList: self.centerData, section: section, toggle: true)
//                }
//            }
//        }()
//
//        setupSortActionPlus(for: baseHomeView.pullDownbutton, actions: menuIntems)
//    }
  
  
  
  
  // MARK: 해당 코드에서 그냥 이 섹션들은 해당하는 케이스에 대해 true 인가 false 인가로 해보면 될것가틈 bool을 어떻게 처리하지....?
  //MARK: 정렬방식
//    private func dataSort(secction: SortSction){
//
//        modelData = repository.dataSort(dataList: centerData ,section: secction, toggle: true)
//
//        baseHomeView.tableView.reloadData()
//
//    }
  */
 // MARK: 시작시 세팅을 해주는 메서드
//    func settingViewDataInfomation(whatInfo: AllListCellCase){
//        modelData = repository.DetailFilterView(of: whatInfo)
//        centerData = repository.DetailFilterView(of: whatInfo)
//    }
 */

/*
 // MARK: 검색기준일 경우에만 사용하세요
//    func settingViewDataSearchCase(data: Results<NewToDoTable>){
//        modelData = data
//        centerData = data
//        print(#function,"***")
//        baseHomeView.tableView.reloadData()
//    }
 */

/*
 //    @objc
 //    func observerData(sender: Notification){
 //        if let value = sender.userInfo?["data"] as? Bool {
 //            reloadData(bool: value)
 //        }
 //    }
 */
/*
 //        var actions: [(String, () -> Void)] = []
 //
 //        for section in SortSction.allCases {
 //            let actting: () -> Void = {
 //                self.dataSort(secction: section)
 //            }
 //            actions.append((section.setTitle, actting))
 //        }
 
 // cell.leftButton.tag = modelDatas.id
//        print(modelDatas.id)
//        print(modelDatas.id.hash)
//        print(modelDatas.id.hashValue)
//        print(modelDatas.id.stringValue) // -> 이방법이 좋은지 모르겠으나 이걸로 해결 도전 ---> 실패
//        print(modelDatas.id)
 // cell.leftButton.layer.name = modelDatas.id.stringValue
 // modelDatas.id // -> ObjectId
 
 
 
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


/*
 
 /*
  case .onlyprioritySet:
      let getOvject = loadRealm.objects(model).where {
          $0.priorityNumber != 0
      }
      modelData = getOvject
  default :
      print(#function)
      let getOvject = loadRealm.objects(model).sorted(byKeyPath: secction.getQuery, ascending: true)
      modelData = getOvject
  */
 
 
 // pullButtonSetting()
 // 개선작업
//        settUpActtion(ations: [
//            ("제목순",{self.dataSort(secction: .titleSet)}),
//            (("날짜순"),{self.dataSort(secction: .dateSet)}),
//            (("우선순위순"),{self.dataSort(secction: .prioritySet)}),
//            (("우선순위만"),{self.dataSort(secction: .onlyprioritySet)})
//        ])
//        var data: [(String, () -> Void)] = []
//        for (index, value) in SortSction.allCases.enumerated() {
//            data.append {
//                [(value.setTitle), () -> Void ]
//            }
//        }
  // settUpActtion(ations: <#T##[(String, () -> Void)]#>)
 // var test: (String, ()-> Void, Int)
 */
/*
 // realAction.state = realAction.state == .on ? .off : .on
 /*
  *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Action is immutable because it is a child of a menu'
  *** First throw call stack:
  */
 
 */
