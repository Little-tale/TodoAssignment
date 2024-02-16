//
//  ALLTilteCollectionReusableView.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/16/24.
//

import UIKit
import SnapKit

class ALLTilteCollectionReusableView: UICollectionReusableView {
    
    var titleLabel: UILabel = {
       let view = UILabel()
        view.backgroundColor = .clear
        view.font = .systemFont(ofSize: 40, weight: .heavy)
        view.textAlignment = .left
        view.textColor = .systemGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        all()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        all()
    }
    
    func all(){
        configureHierarchy()
        configureLayout()
        designView()
    }
    
    func configureHierarchy(){
        self.addSubview(titleLabel)
    }
    func configureLayout(){
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
        }
    }
    func designView(){
        
    }
    
    
}
