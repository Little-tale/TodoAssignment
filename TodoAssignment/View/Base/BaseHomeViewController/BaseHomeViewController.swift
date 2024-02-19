//
//  BaseHomeViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/19/24.
//

import UIKit

class BaseHomeViewController<T:BaseView>: BaseViewController {
    
    let homeView = T()
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
