//
//  AllListHomView.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit
import SnapKit

final class AllListHomeView: BaseView {
//    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 35))
    
    var whereGoToView: (() -> Void)?
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCellLayout())
    
    lazy var leftButton: UIBarButtonItem = {
        let view = UIButton(type: .contactAdd )
        view.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        view.setTitle("새로운 할일", for: .normal)
        view.titleLabel?.textColor = .black
    
        view.addTarget(self, action: #selector(goToNewToDoView), for: .touchUpInside)
        view.sizeToFit()
        return UIBarButtonItem(customView: view)
    }()
    
    let rightButton = UIBarButtonItem()
    
    lazy var spacerButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    
    
    lazy var buttonArray = [leftButton, spacerButton, rightButton ]
    
    override func configureHierarchy() {
        self.addSubview(collectionView)
    }
    
    
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    override func designView() {
        rightButton.title = "목록 추가"
        leftButton.customView?.sizeToFit()
        collectionView.isScrollEnabled = false
        
    }
    @objc
    func goToNewToDoView(){
        whereGoToView?()
    }
    
    
    
    static func configureCellLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let spacing : CGFloat = 10
        let cellWidth = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: cellWidth / 2, height: (cellWidth) / 4) // 셀의 크기
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.scrollDirection = .vertical
        return layout
    }
    
    override func register() {
        collectionView.register(ToDoListCollectionViewCell.self, forCellWithReuseIdentifier: ToDoListCollectionViewCell.reuseabelIdentifier)
    }
    
    
}
