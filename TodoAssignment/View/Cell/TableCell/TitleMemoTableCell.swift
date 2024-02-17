//
//  TitleMemoTableCell.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit
import SnapKit

// MARK: 딜리게이트 패턴을 위한 프로토콜
protocol TitleTextFieldProtocol: AnyObject {
    func textFieldDidChanged(for cell: TitleMemoTableCell, title: String?)
    // func textFieldDidEndEditing(_ textField: UITextField)
}
protocol MemoTextViewProtocol: AnyObject {
    func textViewDidChange(_ textView: UITextView)
}


final class TitleMemoTableCell: BaseTableViewCell {
    let titleTextField = UITextField()
    let memoTextView = UITextView()
    private var memoPlaceHolder: UILabel = {
        let view = UILabel()
        view.text = "메모"
        view.textColor = .darkGray
        return view
    }()
    
    // MARK: 약함 참조를 통해 ARC 를 방지합니다. -> 강하게 잡으면 충돌가능성 혹은 메모리 누수 현상 발생할 여지가 있습니다.
    weak var delegate: TitleTextFieldProtocol?
    weak var textViewDelegate: MemoTextViewProtocol?
    
    override func configureHierarchy() {
        contentView.addSubview(titleTextField)
        contentView.addSubview(memoTextView)
        contentView.addSubview(memoPlaceHolder)
        
    }
    override func configureLayout() {
        titleTextField.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(12)
            make.height.equalTo(40)
        }
        memoTextView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.greaterThanOrEqualTo(100).priority(.high)
            make.top.equalTo(titleTextField.snp.bottom).inset(8)
            make.bottom.equalToSuperview().inset(12)
        }
        memoPlaceHolder.snp.makeConstraints { make in
            make.leading.top.equalTo(memoTextView).inset(2)
        }
    }
    override func designView() {
        titleTextField.placeholder = "제목"
        
        titleTextField.textColor = .white
        memoTextView.textColor = .white
        self.backgroundColor = .lightGray
        delegateDataSource()
        memoTextViewSetting()
    }
    fileprivate func delegateDataSource(){
        titleTextField.delegate = self
        memoTextView.delegate = self
    }
    
    private func memoTextViewSetting(){
        memoTextView.backgroundColor = .clear
        // 스크롤 방지
        memoTextView.isScrollEnabled = false
        // 사이즈 알잘딱
        memoTextView.sizeToFit()
        // 레이아웃 필요할때
        memoTextView.layoutIfNeeded()
    }
    
}
// MARK: 딜리게이트 패턴을 이용한 값전달
extension TitleMemoTableCell: UITextFieldDelegate {
   
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let title = titleTextField.text
       
        
        delegate?.textFieldDidChanged(for: self, title: title)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
    }
}

extension TitleMemoTableCell : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("***",#function )
        textView.text == "" ? (memoPlaceHolder.isHidden = false) : (memoPlaceHolder.isHidden = true)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        print("*****",#function )
        textView.text == "" ? (memoPlaceHolder.isHidden = false) : (memoPlaceHolder.isHidden = true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.text == "" ? (memoPlaceHolder.isHidden = false) : (memoPlaceHolder.isHidden = true)
        print("*",#function )
        textViewDelegate?.textViewDidChange(textView)
    }
}


