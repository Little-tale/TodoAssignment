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
        
        priLabel.backgroundColor = .gray
        mainLabel.backgroundColor = .red
        subTitleLabel.backgroundColor = .blue
        dateLabel.backgroundColor = .green
        tagLabel.backgroundColor = .cyan
//        print(priLabel)
//        print(mainLabel)
//        print(subTitleLabel)
//        print(dateLabel) //r
//        print(tagLabel) //
        
        
    }
    override func configureLayout() {
        leftButton.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(12)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        priLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftButton.snp.trailing).offset(12)
            make.height.equalTo(24)
//            make.trailing.greaterThanOrEqualTo(mainLabel.snp.leading).offset(4)
            make.centerY.equalTo(leftButton)
        }
        mainLabel.snp.makeConstraints { make in
            make.leading.equalTo(priLabel.snp.trailing).inset( -4 )
            make.height.centerY.equalTo(leftButton)
            make.trailing.lessThanOrEqualToSuperview().offset(12)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(priLabel.snp.leading)
            make.top.equalTo(mainLabel.snp.bottom).offset(4)
            make.centerY.equalToSuperview()
            make.height.equalTo(22)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(4)
            make.leading.height.equalTo(subTitleLabel)
            make.bottom.equalToSuperview().inset(12)
        }
        tagLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel.snp.trailing).offset(4)
            make.centerY.equalTo(dateLabel)
            make.trailing.lessThanOrEqualToSuperview().inset(12)
        }
       
    }
    override func designView() {
        buttonActiveStyle()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        leftButton.layer.cornerRadius = leftButton.frame.width / 2
        leftButton.clipsToBounds = true
    }
    
    
    func buttonActiveStyle(){
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .black
        config.baseForegroundColor = .white
        
        leftButton.configuration = config //
        
        var selectedConfig = UIButton.Configuration.filled()
        selectedConfig.baseBackgroundColor = .white
        selectedConfig.baseForegroundColor = .black
        
        // var configurationUpdateHandler: UIButton.ConfigurationUpdateHandler?
        leftButton.configurationUpdateHandler = {
            button in
            button.configuration = button.isSelected ? selectedConfig : config
        }
    }
    
    @objc
    func updateButton() {
        leftButton.isSelected.toggle()
        leftButton.configurationUpdateHandler?(leftButton)
    }
    
    
    
    
}
