//
//  listTableViewCell.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/20/24.
//

import UIKit
import SnapKit

class listTableViewCell : BaseTableViewCell {
    let listImageView = UIImageView(frame: .zero)
    let titleLabel = UILabel()
    let countLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(listImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
        print(listImageView.bounds.size)
    }
    override func configureLayout() {
        listImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.leading.top.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.leading.equalTo(listImageView.snp.trailing).offset(5)
            make.bottom.lessThanOrEqualTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        countLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.trailing.top.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
    }
    
    
    override func designView() {
        
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
            
        countLabel.textColor = .white
        countLabel.font = .systemFont(ofSize: 14)
        
        listImageView.backgroundColor = .white
        listImageView.contentMode = .scaleAspectFill
        contentView.backgroundColor = .darkGray
        
        titleLabel.backgroundColor = .green
        countLabel.backgroundColor = .red
        
        DispatchQueue.main.async {
            self.listImageView.layer.cornerRadius = self.listImageView.bounds.width / 2
            print(self.listImageView.bounds.size)
        }
    }
    
    
}
