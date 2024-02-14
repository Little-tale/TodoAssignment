//
//  AllListViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit

class AllListViewController: BaseViewController {

    let allListHomeView = AllListHomeView()
    
    override func loadView() {
        self.view = allListHomeView
    }
    var data: [TodoList]? {
        didSet{
            allListHomeView.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        delegateDataSource()
        // navigationController.
        allListHomeView.whereGoToView = {
            self.next()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setToolBar()
        guard let data = UserDefaultsManager.shared.todoList else {
            print("date viewWillAppear")
            return
        }
        self.data = data
    }

    
    fileprivate func setToolBar(){
        navigationController?.isToolbarHidden = false
        self.toolbarItems = allListHomeView.buttonArray
    }
    fileprivate func delegateDataSource(){
        allListHomeView.collectionView.dataSource = self
        allListHomeView.collectionView.delegate = self
    }
    
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
        let data = AllListCellCase.allCases[indexPath.row]
        
        cell.imageView.image = UIImage(systemName: data.imageName)
        cell.titleLabel.text = data.name
        cell.imageView.tintColor = data.backColor
        
        
        if data.self == AllListCellCase.all {
            guard let dataNum = self.data else {
                return cell
            }
            
            cell.countLabel.text = "\(dataNum.count)"
            return cell
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
        collectionView.deselectItem(at: indexPath , animated: true)
    }
    
}
