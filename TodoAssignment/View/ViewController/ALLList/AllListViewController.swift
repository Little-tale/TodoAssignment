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
        let data = AllListCellCase.allCases[indexPath.item]
        
        cell.imageView.image = UIImage(systemName: data.imageName)
        cell.titleLabel.text = data.name
        cell.imageView.tintColor = data.backColor
        cell.countLabel.text = "\(data.howMany)"
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath , animated: true)
        
        let secction = AllListCellCase.allCases[indexPath.item]
        
        switch secction {
        case .today:
            
            return
        case .upcoming:
            return
        case .all:
            let vc = DetailViewController()
            navigationController?.pushViewController(vc, animated: true)
            return
        case .flag:
            return
        case .completed:
            return
        }
        
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
