//
//  BaseViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        all()
        self.view.backgroundColor = .white
    }
    func all(){
        configureHierarchy()
        configureLayout()
        designView()
        dataSourceAndDelegate()
    }
    
    func configureHierarchy(){
        
    }
    func configureLayout(){
        
    }
    func designView(){
        
    }
    func dataSourceAndDelegate(){
        
    }
}
