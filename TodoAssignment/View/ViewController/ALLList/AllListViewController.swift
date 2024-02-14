//
//  AllListViewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit

class AllListViewController: BaseViewController {

    let allListHomeView = AllListHomeView()
    
    override func loadView() {
        self.view = allListHomeView
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
       
        // navigationController.
        allListHomeView.whereGoToView = {
            self.next()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setToolBar()
    }
    func setToolBar(){
       
        
        var spacerButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: nil)
        spacerButton.tintColor = .black
   
        self.toolbarItems = allListHomeView.buttonArray
    }
    
    func next(){
        let vc = NewTodoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
