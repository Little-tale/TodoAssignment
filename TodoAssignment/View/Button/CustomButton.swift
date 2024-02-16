//
//  customButton.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/16/24.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        designView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        designView()
    }
    
    func designView() {
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .black
        config.baseForegroundColor = .darkGray
        
        self.configuration = config
        
        var selectedConfig = UIButton.Configuration.filled()
        selectedConfig.baseBackgroundColor = .darkGray
        selectedConfig.baseForegroundColor = .orange
        
        // var configurationUpdateHandler: UIButton.ConfigurationUpdateHandler?
        self.configurationUpdateHandler = {
            button in
            button.configuration = button.isSelected ? selectedConfig : config
        }
        
        self.addTarget(self, action: #selector(updateButton), for: .touchUpInside)
    }
    
    @objc
    func updateButton() {
        self.isSelected.toggle()
        self.configurationUpdateHandler?(self)
    }
}
