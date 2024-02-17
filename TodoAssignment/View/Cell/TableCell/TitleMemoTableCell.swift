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
    func textFieldDidChanged(for cell: TitleMemoTableCell, title: String?, Info: String?)
    // func textFieldDidEndEditing(_ textField: UITextField)
}

final class TitleMemoTableCell: BaseTableViewCell {
    let titleTextField = UITextField()
    let memoTextField = UITextField()
    
    // MARK: 약함 참조를 통해 ARC 를 방지합니다. -> 강하게 잡으면 충돌가능성 혹은 메모리 누수 현상 발생할 여지가 있습니다.
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
    fileprivate func delegateDataSource(){
        titleTextField.delegate = self
        memoTextField.delegate = self
    }
    
}
// MARK: 딜리게이트 패턴을 이용한 값전달
extension TitleMemoTableCell: UITextFieldDelegate {
   
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let title = titleTextField.text
        let infoText = memoTextField.text
        
        delegate?.textFieldDidChanged(for: self, title: title, Info: infoText)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
    }
}

