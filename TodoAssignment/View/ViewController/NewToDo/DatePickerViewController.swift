//
//  DatePickerViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit
import SnapKit

final class DatePickerViewController: BaseViewController {
    let datePickerView = UIDatePicker(frame: .zero)
    let checkButton = UIButton(frame: .zero)
    var DateInfo: ((Date) -> Void)?
    
    var date : Date?
    
    override func configureHierarchy() {
        view.addSubview(datePickerView)
        view.addSubview(checkButton)
    }
    override func configureLayout() {
        datePickerView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        checkButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(40)
            make.top.equalTo(datePickerView.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let date = date else {
            return
        }
        datePickerView.date = date
    }
    
    override func designView() {
        datePickerView.datePickerMode = .date
        datePickerView.preferredDatePickerStyle = .inline
        datePickerView.backgroundColor = .darkGray
        datePickerView.tintColor = .white
        
        checkButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        
        checkButton.setTitle("저장하기", for: .normal)
        checkButton.backgroundColor = .lightGray
    }
    
    @objc
    func saveButtonClicked(){
        print(#function)
        self.date = datePickerView.date
        guard let date = date else {
            return
        }
        DateInfo?(date)
        navigationController?.popViewController(animated: true)
    }
    
    
    //        datePickerView.addTarget(self, action: #selector(datePickerGetData), for: .touchUpInside)
    
//    @objc
//    func datePickerGetData(sender: UIDatePicker){
//        // 2024-02-27 08:18:00 +0000
//        print(sender.date)
//   
//        self.date = sender.date
//    }
    

}

