//
//  OnlyTitleTableViewCell.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit
import SnapKit

final class OnlyTitleTableViewCell: BaseTableViewCell {
    let titleLabel = UILabel()
    
    let rightImage: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(systemName: "greaterthan")
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    let infoLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(rightImage)
        contentView.addSubview(infoLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().inset(8)
            make.height.equalTo(30).priority(500)
        }
        rightImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalTo(titleLabel)
            // make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.size.equalTo(20)
        }
        infoLabel.snp.makeConstraints { make in
            make.trailing.equalTo(rightImage.snp.leading).inset( -16 )
            make.height.centerY.equalTo(titleLabel)
        }
    }
    override func designView() {
        titleLabel.text = "asdsadas"
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 1
        infoLabel.textColor = .blue
    }
    
    
}
