//
//  TestImageColCell.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/24/24.
//

import UIKit
import SnapKit
import Kingfisher

class TestImageColCell: BaseCollectionViewCell {
    let backDrop = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(backDrop)
    }
    override func configureLayout() {
        backDrop.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        setImage(image: nil)
    }
    func setImage(image: URL?) {
        backDrop.kf.setImage(with: image, options: [.transition(.fade(0.4))])
    }
}
