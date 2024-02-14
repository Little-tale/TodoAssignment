//
//  ToDoListCollectionViewCell.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit
import SnapKit

final class ToDoListCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = UIImageView(frame: .zero)
    let titleLabel = UILabel()
    let countLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
        
    }
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.leading.top.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.leading.equalTo(imageView)
            make.bottom.lessThanOrEqualTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        countLabel.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.trailing.top.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
    }
    override func designView() {
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 14)
        
        countLabel.textColor = .white
        countLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        contentView.backgroundColor = .darkGray
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        DispatchQueue.main.async {
            self.imageView.layer.cornerRadius = self.imageView.bounds.width / 2
        }
    }
    
}
