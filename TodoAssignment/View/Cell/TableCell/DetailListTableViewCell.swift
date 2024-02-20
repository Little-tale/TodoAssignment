//
//  DetailListTableViewCell.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/20/24.
//

import UIKit
import SnapKit

protocol DetailTextFieldProtocol: AnyObject{
    func textFieldDidChanged(for textField: UITextField)
}
// MARK: 이미지 둥글게 하는건 이게 제일 좋은것 같다.
class circleFolderImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}

class DetailListTableViewCell: BaseTableViewCell {
    let detailListImageView = circleFolderImageView()
    let detailListTextField = UITextField(frame: .zero)
    
    weak var textFieldDelegate: DetailTextFieldProtocol?
    
    override func configureHierarchy() {
        contentView.addSubview(detailListImageView)
        contentView.addSubview(detailListTextField)
    }
    override func configureLayout() {
        detailListImageView.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(12)
            make.size.equalTo(80)
            
        }
        detailListTextField.snp.makeConstraints { make in
            make.top.equalTo(detailListImageView.snp.bottom).offset(20)
            make.centerX.equalTo(detailListImageView)
            make.height.equalTo(38).priority(.high)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(12)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
    }
    
    override func designView() {
        detailListImageView.backgroundColor = .brown

        detailListTextField.delegate = self
        detailListTextField.textAlignment = .center
        
        detailListTextField.placeholder = "목록이름"
        detailListTextField.borderStyle = .roundedRect
        detailListTextField.clearButtonMode = .whileEditing
                
        detailListTextField.backgroundColor = .systemGray4
        
        contentView.backgroundColor = .systemGray5
    }
    
    
}


extension DetailListTableViewCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textFieldDelegate?.textFieldDidChanged(for: textField)
    }
}

