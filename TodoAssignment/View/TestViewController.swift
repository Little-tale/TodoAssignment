//
//  TestViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/16/24.
//

import UIKit
import SnapKit

class TestViewController: BaseViewController {
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func configureHierarchy() {
        view.addSubview(button)
    }
    override func configureLayout() {
        button.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
    }
    override func designView() {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .black
        config.baseForegroundColor = .white
        
        button.configuration = config
        
        var selectedConfig = UIButton.Configuration.filled()
        selectedConfig.baseBackgroundColor = .white
        selectedConfig.baseForegroundColor = .black
        
        // var configurationUpdateHandler: UIButton.ConfigurationUpdateHandler?
        button.configurationUpdateHandler = {
            button in
            button.configuration = button.isSelected ? selectedConfig : config
        }
        
        button.addTarget(self, action: #selector(updateButton), for: .touchUpInside)
    }
    
    @objc
    func updateButton() {
        button.isSelected.toggle()
        button.configurationUpdateHandler?(button)
    }
    
    

    
}
