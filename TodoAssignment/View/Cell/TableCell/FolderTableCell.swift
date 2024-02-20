//
//  FolderTableCell.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/20/24.
//

import UIKit
import SnapKit

class FolderTableCell: BaseTableViewCell {
    let leftImageView = UIImageView()
    let detailLabel = UILabel()
    let checkImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(systemName: "checkmark")
        view.tintColor = .blue
        view.backgroundColor = .clear
        return view
    }()
    
    
    override func configureHierarchy() {
        contentView.addSubview(leftImageView)
        contentView.addSubview(detailLabel)
        contentView.addSubview(checkImageView)
    }
    override func configureLayout() {
        leftImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().inset(8)
        }
        detailLabel.snp.makeConstraints { make in
            make.centerY.height.equalTo(leftImageView)
            make.leading.equalTo(leftImageView.snp.trailing).offset(8)
            make.trailing.equalTo(checkImageView.snp.leading).inset(8)
        }
        checkImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalTo(leftImageView)
            make.size.equalTo(20)
        }
    }
    override func designView() {
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        checkPrepare()
    }
    func checkPrepare(bool: Bool? = false){
        if bool == true {
            checkImageView.isHidden = false
        } else {
            checkImageView.isHidden = true
        }
    }
}
