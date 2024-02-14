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
    
    var DateInfo: ((Date) -> Void)?
    
    var date : Date?
    
    override func configureHierarchy() {
        view.addSubview(datePickerView)
    }
    override func configureLayout() {
        datePickerView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(100)
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
        datePickerView.preferredDatePickerStyle = .compact
        datePickerView.backgroundColor = .darkGray
        datePickerView.tintColor = .white
        datePickerView.addTarget(self, action: #selector(datePickerGetData), for: .valueChanged)
    }
    @objc
    
    func datePickerGetData(sender: UIDatePicker){
        // 2024-02-27 08:18:00 +0000
        print(sender.date)
   
        self.date = sender.date
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        guard let date = date else {
            return
        }
        DateInfo?(date)
    }
}

