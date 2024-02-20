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

class DetailListTableViewCell: BaseTableViewCell {
    let detailListImageView = UIImageView()
    let detailListTextField = UITextField()
    
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
            make.horizontalEdges.equalTo(contentView).inset(12)
            make.bottom.equalTo(contentView).inset(8)
        }
    }
    
    override func designView() {
        detailListImageView.backgroundColor = .brown
        detailListTextField.backgroundColor = .cyan
        
        detailListTextField.delegate = self
    }
    
    
}


extension DetailListTableViewCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textFieldDelegate?.textFieldDidChanged(for: textField)
    }
}

