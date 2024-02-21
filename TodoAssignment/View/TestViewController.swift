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
    let testImageView = UIImageView(frame: .zero)
    let scrollView = UIScrollView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func configureHierarchy() {
        view.addSubview(button)
        view.addSubview(scrollView)
        scrollView.addSubview(testImageView)
    }
    override func configureLayout() {
        button.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(600)
        }
        testImageView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
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
        
        // MARK: View in ScrollView in UIImageView
        testImageView.image = UIImage(systemName: "star.fill")
        scrollView.backgroundColor = .gray
        testImageView.contentMode = .scaleAspectFit
        scrollView.contentSize = testImageView.bounds.size
        
        scrollView.delegate = self
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        
        
    }
    
    @objc
    func updateButton() {
        button.isSelected.toggle()
        button.configurationUpdateHandler?(button)
    }
    
}

extension TestViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return testImageView
    }
}
