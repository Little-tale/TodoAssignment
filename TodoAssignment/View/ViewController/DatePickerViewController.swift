//
//  DatePickerViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit
import SnapKit

class DatePickerViewController: BaseViewController {
    let datePickerView = UIDatePicker(frame: .zero)
    
    var DateInfo: ((String) -> Void)?
    
    private var date = ""
    
    override func configureHierarchy() {
        view.addSubview(datePickerView)
    }
    override func configureLayout() {
        datePickerView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(100)
        }
    }
    
    override func designView() {
        datePickerView.datePickerMode = .date
        datePickerView.preferredDatePickerStyle = .compact
        datePickerView.backgroundColor = .darkGray
        datePickerView.tintColor = .white
        datePickerView.addTarget(self, action: #selector(datePickerGetData), for: .valueChanged)
    }
    @objc
    func datePickerGetData(sender: UIDatePicker){
        // 2024-02-27 08:18:00 +0000
        print(sender.date)
        // print(DateAssistance().getDate(date: sender.date))
        // DateInfo?(sender.date)
        self.date = DateAssistance().getDate(date: sender.date)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        guard date != "" else {
            
            return
        }
        DateInfo?(date)
    }
}

