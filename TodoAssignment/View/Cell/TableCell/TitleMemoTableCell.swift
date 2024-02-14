//
//  TitleMemoTableCell.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit
import SnapKit

class TitleMemoTableCell: BaseTableViewCell {
    let titleTextField = UITextField()
    let memoTextField = UITextField()
    
    
    
    override func configureHierarchy() {
        contentView.addSubview(titleTextField)
        contentView.addSubview(memoTextField)
    }
    override func configureLayout() {
        titleTextField.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(12)
            make.height.equalTo(40)
        }
        memoTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(100).priority(.high)
            make.top.equalTo(titleTextField.snp.bottom).inset(8)
            make.bottom.equalToSuperview().inset(12)
        }
    }
    override func designView() {
        titleTextField.placeholder = "제목"
        memoTextField.placeholder = "메모"
        
        titleTextField.textColor = .white
        memoTextField.textColor = .white
        self.backgroundColor = .lightGray
    }
    
    
    
}
