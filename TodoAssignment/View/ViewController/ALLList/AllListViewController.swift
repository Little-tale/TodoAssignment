//
//  AllListViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit
import RealmSwift
import SnapKit

final class AllListViewController: SearchBaseViewController {

    let allListHomeView = AllListHomeView()
    var allCellCount = 0
    
    
    override func loadView() {
        self.view = allListHomeView
    }

    // MARK: Realm 데이터 담아둘 공간! !를 권장한다?? -> 물어보기
    var NewTodoListRecords: Results<NewToDoTable>!
//    var NetTodoFolder: Results<Folder>!
    
    let repository = NewToDoRepository()
    
    lazy var newtodoFolderList = repository.NewToDoFolder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        delegateDataSource()
        
        // MARK: 홈뷰에 있는 툴바 좌측 버튼 메서드 여기서 구현
        allListHomeView.whereGoToView = {
            self.next()
        }
        allListHomeView.goToListViewM = {
            print("asdsada")
            let vc = NewListViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        navigationSetting()
        checkFolder()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setToolBar()
        allListHomeView.tableView.reloadData()
        checkFolder()
    }
    // MARK: RelationShip Folder Check
    private func checkFolder(){
        if let folder = repository.firstFolder() {
            allListHomeView.leftButton.isEnabled = true
        } else {
            allListHomeView.leftButton.isEnabled = false
        }
    }
    
    fileprivate func setToolBar(){
        navigationController?.isToolbarHidden = false
        self.toolbarItems = allListHomeView.buttonArray
    }
    fileprivate func delegateDataSource(){
        
        allListHomeView.tableView.delegate = self
        allListHomeView.tableView.dataSource = self
        
        allListHomeView.tableView.rowHeight = UITableView.automaticDimension
        allListHomeView.tableView.estimatedRowHeight = 100
    
    }
    // MARK: 홈뷰에서 사용할 메서드
    fileprivate func next(){
        let vc = NewTodoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func navigationSetting(){
        navigationItem.leftBarButtonItem = leftBarButton()
    }
    
    private func leftBarButton() -> UIBarButtonItem{
        let button = UIBarButtonItem(image: UIImage(systemName: "calendar.badge.checkmark"), style: .plain, target: self, action: #selector(calendarButtonClicked))
        return button
    }
    
    @objc
    func calendarButtonClicked(){
        let vc = CalendarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AllListViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        AllListCellCase.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToDoListCollectionViewCell.reuseabelIdentifier, for: indexPath) as? ToDoListCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        let caseSection = AllListCellCase.allCases[indexPath.item]
        
        cell.imageView.image = UIImage(systemName: caseSection.imageName)
        cell.titleLabel.text = caseSection.name
        cell.imageView.tintColor = caseSection.backColor
        //cell.countLabel.text = "\(data.howMany)"
        
        cell.countLabel.text = "\(repository.collctionListViewDisPatchForCount(caseSection))"
        
        return cell
    }
    // MARK: 섹션별 알아서 (같은뷰컨임) 재사용성 높여서 처리 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath , animated: true)
        let section = AllListCellCase.allCases[indexPath.item]
        guard let vc = section.nextViewController else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ALLTilteCollectionReusableView.reuseabelIdentifier, for: indexPath) as? ALLTilteCollectionReusableView  else {
            return UICollectionReusableView()
        }
        view.titleLabel.text = "전체"
        return view
    }
}

extension AllListViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 60)
    }
}

extension AllListViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return NewToDoAllFindSection.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let caseSection = NewToDoAllFindSection.allCases[section]
        switch caseSection {
        case .collectionCellSection:
            return caseSection.rawValue
        case .listCellSection:
            return newtodoFolderList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section =  NewToDoAllFindSection.allCases[indexPath.section]
        switch section {
        case .collectionCellSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AllListTableInCollectionCell.reuseabelIdentifier, for: indexPath) as? AllListTableInCollectionCell else {
                return UITableViewCell()
            }
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            
            // MARK: prePare에서 하나 여기서 하나 애매하다.
            cell.collectionView.reloadData()
            return cell
            
        case .listCellSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: listTableViewCell.reuseabelIdentifier, for: indexPath) as? listTableViewCell else {
                return UITableViewCell()
            }
            
            let folder = newtodoFolderList[indexPath.row]
            
            cell.countLabel.text = "\(folder.newTodoTable.count)"
            cell.titleLabel.text = folder.folderName
            return cell
        }
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleSection = NewToDoAllFindSection.allCases[section]
        switch titleSection {
        case .collectionCellSection:
            return nil
        case .listCellSection:
            let view = UIView()
            let textLable = UILabel()
            textLable.text = titleSection.sectionName
            textLable.font = .systemFont(ofSize: 24, weight: .heavy)
            textLable.textColor = .systemGray
            view.addSubview(textLable)
            
            // MARK: 텍스트 라벨을 뷰를 생성하고 집어넣어 헤더뷰에 선물
            textLable.snp.makeConstraints { make in
                make.verticalEdges.height.trailing.equalToSuperview()
                make.leading.equalToSuperview().offset(8)
            }
            
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)

        // print("*****",newtodoFolderList[indexPath.row].newTodoTable)
        
        let folder = newtodoFolderList[indexPath.row]

        let filter = repository.realm.objects(Folder.self).where {
            $0.id == folder.id
        }
        
        let vc = FolderDetailViewController()
        vc.folderResults = filter
        
        navigationController?.pushViewController(vc, animated: true)
    }

    
}

// let test = newtodoFolderList[indexPath.row].newTodoTable
//  lazy어쩌고 Results< >
//        let b = newtodoFolderList.compactMap { $0 }
//        let c = newtodoFolderList.map { $0 }
//        let d = [newtodoFolderList[indexPath.row]]



// MARK: 섹션 글자 크기 변경 안됨
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        let titleSection = NewToDoAllFindSection.allCases[section]
//        switch titleSection {
//        case .collectionCellSection:
//            return 0
//        case .listCellSection:
//            return 30
//        }
//    }

// MARK: 유저 디폴트로 구현했었던 잔재들
/* 
 
 //class AllListViewControllerSectionCounter {
 //    var today = 0
 //    var remind = 0
 //    var alls = 0
 //    var flags = 0
 //    var complited = 0
 //
 //    convenience // -> 이게 클래스일때 가능하다. 구조체는 안된다.
 //    init(today: Int = 0, remind: Int = 0, alls: Int = 0, flags: Int = 0, complited: Int = 0) {
 //        self.init()
 //        self.today = today
 //        self.remind = remind
 //        self.alls = alls
 //        self.flags = flags
 //        self.complited = complited
 //    }
 //
 //}

 
 //    var data: [TodoList]? {
 //        didSet{
 //            allListHomeView.collectionView.reloadData()
 //        }
 //    }
 
 
 
 //        guard let data = UserDefaultsManager.shared.todoList else {
 //            print("date viewWillAppear")
 //            return
 //        }
 //        self.data = data
         
 
 
 if data.self == AllListCellCase.all {
 guard let dataNum = self.data else {
     return cell
 }
 
 cell.countLabel.text = "\(dataNum.count)"
 return cell
}

 
 */
