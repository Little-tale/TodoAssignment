//
//  FolderDetailBaseViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/21/24.
//

import UIKit


class FolderDetailBaseViewController<T:BaseView>: BaseViewController {
    
    let homeView = T()
    var folder: Folder?
    
    var repository = NewToDoRepository()
    lazy var folderResults = repository.NewToDoFolder()
    
    override func loadView() {
        self.view = homeView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
