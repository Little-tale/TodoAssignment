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
    let checkImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(systemName: "checkmark")
        view.tintColor = .blue
        view.backgroundColor = .clear
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(listImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(checkImageView)
        print(listImageView.bounds.size)
    }
    override func configureLayout() {
        listImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)        }
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.leading.equalTo(listImageView.snp.trailing).offset(5)
            make.centerY.equalToSuperview()
            make.bottom.lessThanOrEqualTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        countLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.trailing.top.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        checkImageView.snp.makeConstraints { make in
            make.height.equalTo(titleLabel)
            make.size.equalTo(checkImageView.snp.height)
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
    }
    
    
    override func designView() {
        
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
            
        countLabel.textColor = .white
        countLabel.font = .systemFont(ofSize: 14)
        
        listImageView.backgroundColor = .white
        listImageView.contentMode = .scaleAspectFill
        contentView.backgroundColor = .darkGray
        
        checkImageView.isHidden = true
        DispatchQueue.main.async {
            self.listImageView.layer.cornerRadius = self.listImageView.bounds.width / 2
            print(self.listImageView.bounds.size)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        checkPrepare()
    }
    func checkPrepare(bool: Bool? = false){
        if bool == nil {
            checkImageView.isHidden = true
        }
        if bool == true {
            checkImageView.isHidden = false
        } else {
            checkImageView.isHidden = true
        }
    }
    
}
