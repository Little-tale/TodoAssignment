//
//  AllListViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit
import RealmSwift

final class AllListViewController: BaseViewController {

    let allListHomeView = AllListHomeView()
    var allCellCount = 0
    
    
    
    override func loadView() {
        self.view = allListHomeView
    }

    // MARK: Realm 데이터 담아둘 공간! !를 권장한다?? -> 물어보기
    var NewTodoListRecords: Results<NewToDoTable>!
    
    let repository = NewToDoRepository()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        delegateDataSource()
        
        allListHomeView.whereGoToView = {
            self.next()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setToolBar()
        allListHomeView.collectionView.reloadData()
    }


    
    fileprivate func setToolBar(){
        navigationController?.isToolbarHidden = false
        self.toolbarItems = allListHomeView.buttonArray
    }
    fileprivate func delegateDataSource(){
        allListHomeView.collectionView.dataSource = self
        allListHomeView.collectionView.delegate = self
    }
    // MARK: 홈뷰에서 사용할 메서드
    fileprivate func next(){
        let vc = NewTodoViewController()
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
        
        let secction = AllListCellCase.allCases[indexPath.item]
        let vc = DetailViewController()
    
        vc.settingViewDataInfomation(whatInfo: secction)
        vc.navigationItem.title = secction.name
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
