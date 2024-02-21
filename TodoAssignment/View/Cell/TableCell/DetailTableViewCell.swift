//
//  DetailTableViewCell.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/16/24.
//

import UIKit
import SnapKit

final class DetailTableViewCell: BaseTableViewCell {
    let leftButton = CustomButton(frame: .zero)
    let priLabel = UILabel()
    let mainLabel = UILabel()
    let subTitleLabel = UILabel()
    let dateLabel = UILabel()
    let tagLabel = UILabel()
    let folderLabel = UILabel()
    let subImageView = UIImageView(frame: .zero)
    
    // 0:0
    override func configureHierarchy() {
        contentView.addSubview(leftButton)
        contentView.addSubview(priLabel)
        contentView.addSubview(mainLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(tagLabel)
        contentView.addSubview(subImageView)
        contentView.addSubview(folderLabel)
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
        
        subImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.size.equalTo(40)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalTo(priLabel.snp.trailing).offset( 4 )
            make.height.centerY.equalTo(priLabel)
            make.trailing.lessThanOrEqualTo(subImageView).inset(8)
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
        folderLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel.snp.trailing).offset(4)
            make.centerY.equalTo(dateLabel)
            make.trailing.greaterThanOrEqualTo(tagLabel.snp.leading).inset(-4)
        }
        tagLabel.snp.makeConstraints { make in
            make.leading.equalTo(folderLabel.snp.trailing).offset(4)
            make.centerY.equalTo(dateLabel)
            make.trailing.lessThanOrEqualTo(subImageView).inset(8)
        }
        
    }
    
    
    override func designView() {
        fontSetting()
//        mainLabel.backgroundColor = .red
//        subTitleLabel.backgroundColor = .blue
//        dateLabel.backgroundColor = .green
//        subTitleLabel.backgroundColor = .cyan
//        tagLabel.backgroundColor = .brown
//        subImageView.backgroundColor = .gray
//        folderLabel.backgroundColor = .lightGray
       
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
    //
    override func layoutIfNeeded() {
        print("asdasda")
        super.layoutIfNeeded()
        leftButton.layer.cornerRadius = leftButton.frame.width / 2
        leftButton.clipsToBounds = true

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(#function)
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imagePrepare()
    }
  
    func imagePrepare(image: UIImage? = nil){
        if let image = image {
            subImageView.image = image
        } else {
            subImageView.image = nil
        }
    }
    
}
