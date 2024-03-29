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
    
    let profileImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let infoLabel = UILabel()
    let switchButton = UISwitch(frame: .zero)
    
    var switchToggleAction: ((UISwitch) -> Void)?
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(rightImage)
        contentView.addSubview(infoLabel)
        contentView.addSubview(switchButton)
        contentView.addSubview(profileImageView)
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
        switchButton.snp.makeConstraints { make in
            // make.width.equalTo(80)
            make.height.centerY.equalTo(infoLabel)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalTo(rightImage)
            make.trailing.equalTo(rightImage.snp.leading).inset( -8 )
            make.size.equalTo(30)
        }
    }
    override func designView() {
        switchButton.isHidden = true
        switchButton.preferredStyle = .sliding
        switchButton.backgroundColor = .darkGray
        switchButton.layer.cornerRadius = switchButton.frame.height / 2
        switchButton.clipsToBounds = true
        
        titleLabel.text = "asdsadas"
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 1
        infoLabel.textColor = .blue
        
        switchButton.addTarget(self, action: #selector(switchButtonActions), for: .valueChanged)
        
        profileImageView.isHidden = true
        // profileImageView.backgroundColor = .white
    }
    
    @objc
    private func switchButtonActions(sender: UISwitch) {
        switchToggleAction?(sender)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rightImage.isHidden = false
        switchButton.isHidden = true
        profileImageView.isHidden = true
        prepareForCell()
    }
    
//    func obserVerToggle(imageHiddenBool: Bool){
//        rightImage.isHidden = imageHiddenBool
//        rightImage.isHidden == true ? (switchButton.isHidden = false) : (switchButton.isHidden = true)
//    }
    func prepareForCell(rightImage: Bool? = false, switchButton: Bool? = false, profileImage: Bool? = false){
        if rightImage == true {
            
            self.switchButton.isHidden = true
            profileImageView.isHidden = true
            self.rightImage.isHidden = false
            
        }else if switchButton == true {
            
            self.switchButton.isHidden = false
            profileImageView.isHidden = true
            self.rightImage.isHidden = true
            
        }else if profileImage == true{
            
            self.switchButton.isHidden = true
            profileImageView.isHidden = false
            self.rightImage.isHidden = false
        }else {
            self.switchButton.isHidden = true
            profileImageView.isHidden = true
            self.rightImage.isHidden = false
        }
    }
}
