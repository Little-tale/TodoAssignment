//
//  TitleMemoTableCell.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit
import SnapKit

// MARK: 딜리게이트 패턴을 위한 프로토콜
protocol TitleMemoTextFieldProtocol: AnyObject {
    func textFieldDidEndEditing(for cell: TitleMemoTableCell, title: String?, Info: String?)
}

class TitleMemoTableCell: BaseTableViewCell {
    let titleTextField = UITextField()
    let memoTextField = UITextField()
    
    weak var delegate: TitleMemoTextFieldProtocol?
    
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
        delegateDataSource()
    }
    func delegateDataSource(){
        titleTextField.delegate = self
        memoTextField.delegate = self
    }
    
}
// MARK: 딜리게이트 패턴을 이용한 값전달
extension TitleMemoTableCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let title = titleTextField.text
        let infoText = memoTextField.text
        
        delegate?.textFieldDidEndEditing(for: self, title: title, Info: infoText)
    }
}
