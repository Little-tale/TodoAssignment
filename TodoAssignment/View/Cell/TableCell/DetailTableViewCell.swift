//
//  DetailTableViewCell.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/16/24.
//

import UIKit
import SnapKit

class DetailTableViewCell: BaseTableViewCell {
    let leftButton = CustomButton(frame: .zero)
    let priLabel = UILabel()
    let mainLabel = UILabel()
    let subTitleLabel = UILabel()
    let dateLabel = UILabel()
    let tagLabel = UILabel()
    
    
    override func configureHierarchy() {
        contentView.addSubview(leftButton)
        contentView.addSubview(priLabel)
        contentView.addSubview(mainLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(tagLabel)
        priLabel.text = "asdsad"
        mainLabel.text = "asdsad"
        subTitleLabel.text = "asdsad"
        dateLabel.text = "asdsad"
        tagLabel.text = "sadasd"
//        
//        priLabel.backgroundColor = .gray
//        mainLabel.backgroundColor = .red
//        subTitleLabel.backgroundColor = .blue
//        dateLabel.backgroundColor = .green
//        tagLabel.backgroundColor = .cyan

    }
    override func configureLayout() {
        leftButton.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(12)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        priLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftButton.snp.trailing).offset(12)
            // make.height.equalTo(24)//.priority(.high)
            make.centerY.equalTo(leftButton)
        }
        mainLabel.snp.makeConstraints { make in
            make.leading.equalTo(priLabel.snp.trailing).offset( 4 )
            make.height.centerY.equalTo(priLabel)
            make.trailing.lessThanOrEqualToSuperview().offset(12)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(priLabel.snp.leading)
            make.top.equalTo(mainLabel.snp.bottom).offset(4)
            //make.centerY.equalToSuperview()
            make.height.equalTo(18)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset( 4 )
            make.leading.equalTo(subTitleLabel)
            make.height.equalTo(subTitleLabel)
            make.bottom.equalToSuperview().inset(12)
        }
        tagLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel.snp.trailing).offset(4)
            make.centerY.equalTo(dateLabel)
            make.trailing.lessThanOrEqualToSuperview().inset(12)
        }

       
    }
    
    override func designView() {
        fontSetting()
    }
    
    // MARK: 텍스트 컬러와 폰트 설정
    func fontSetting() {
        priLabel.textColor = .systemBlue
        mainLabel.textColor = .black
        subTitleLabel.textColor = .black
        dateLabel.textColor = .black
        tagLabel.textColor = .purple
        
        priLabel.font = .systemFont(ofSize: 14, weight: .light)
        mainLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        subTitleLabel.font = .systemFont(ofSize: 14, weight: .light)
        dateLabel.font = .systemFont(ofSize: 13, weight: .light)
        tagLabel.font = .systemFont(ofSize: 13, weight: .medium)
    }

    override func layoutIfNeeded() {
        print("asdasda")
        super.layoutIfNeeded()
        leftButton.layer.cornerRadius = leftButton.frame.width / 2
        leftButton.clipsToBounds = true
    }
    

    override func setNeedsLayout() {
        super.setNeedsLayout()
//        print(leftButton.layer.cornerRadius)
//        print(leftButton.frame.height / 2)
//        if leftButton.layer.cornerRadius != leftButton.frame.height / 2 {
//            print("asdasdsadasdasd")
//            leftButton.layer.cornerRadius = leftButton.frame.height / 2
//            leftButton.clipsToBounds = true
//        }
    }
    
}
