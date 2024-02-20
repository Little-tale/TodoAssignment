//
//  CollectionViewCell.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/20/24.
//

import UIKit
import SnapKit

class AllListTableInCollectionCell: BaseTableViewCell {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCellLayout())

    override func register() {
        collectionView.register(ToDoListCollectionViewCell.self, forCellWithReuseIdentifier: ToDoListCollectionViewCell.reuseabelIdentifier)
        
        collectionView.register(ALLTilteCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ALLTilteCollectionReusableView.reuseabelIdentifier)
    }
    
    
    override func configureHierarchy() {
        contentView.addSubview(collectionView)
        print("리로드 참.. 🦊🦊")
    }
    
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(360)
        }
    }
    
    override func designView() {
        collectionView.isScrollEnabled = false
        // collectionView.backgroundColor = .red
        self.backgroundColor = UIColor(white: 0, alpha: 1)
        collectionView.backgroundColor = .systemGray5
    }
   
    
    func configureCellLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let spacing : CGFloat = 10
        let cellWidth = self.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: cellWidth / 1.8, height: (cellWidth) / 4) // 셀의 크기
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("****리로드 데이터 ")
        // collectionView.reloadData()
    }
}
