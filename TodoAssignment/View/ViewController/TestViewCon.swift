//
//  TestViewCon.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/24/24.
//

import UIKit
import SnapKit
import Kingfisher

class TestViewCon: BaseViewController{
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCellLayout())
    let searchTextField = UISearchTextField(frame: .zero)
    
    var startNum = 1
    var searchData: [naverItem] = []
    var searchText: String?{
        didSet{
            request()
            collectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        
        collectionView.register(TestImageColCell.self, forCellWithReuseIdentifier: TestImageColCell.reuseabelIdentifier)
        navigationItem.searchController = nil
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.isActive = false
        navigationItem.largeTitleDisplayMode = .never
        
        searchTextField.addTarget(self, action: #selector(search), for: .editingDidEndOnExit)
    }
    @objc
    func search(_ sender: UISearchTextField){
        searchText = sender.text
    }
    
    override func configureHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(searchTextField)
    }
    override func configureLayout() {
        searchTextField.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(searchTextField.snp.bottom)
        }
    }
    
}
// MARK: 컬렉션뷰 딜리게이트 데이타소스
extension TestViewCon: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestImageColCell.reuseabelIdentifier, for: indexPath) as? TestImageColCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .black
        let url = URL(string: searchData[indexPath.item].thumbnail)
        cell.setImage(image: url)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(searchData[indexPath.item].thumbnail)
        let data = searchData[indexPath.item].thumbnail
        let imageUrl = URL(string:data)
        guard let imageUrl = imageUrl else {
            return
        }
        
        KingfisherManager.shared.retrieveImage(with: imageUrl) { result in
            switch result{
            case .success(let data):
                let imageData = data.image.jpegData(compressionQuality: 0.5)
                
                NotificationCenter.default.post(name: .getImage, object: imageData)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            case .failure(_):
                self.showAlert(title: "죄송합니다", message: "다운로드 실패...")
            }
        }
        
        
    }
}
// MARK: 페이지 네이션
extension TestViewCon: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if let indexPath = indexPaths.last?.row {
            print(indexPath)
            if indexPath >= (searchData.count - 3) {
                startNum += 20
                request()
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        // print(indexPaths)
        
        let a = Location2(longitude: "asdsa", latitude: "asdsad")
        let b = Memo2(title: "안녕", regDate:Date(), location: a)
        
    }
}


// MARK: 레이아웃
extension TestViewCon {
    static func configureCellLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let spacing : CGFloat = 10
        let cellWidth = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: cellWidth / 2, height: (cellWidth) / 2) // 셀의 크기
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.scrollDirection = .vertical
        
        return layout
    }

}



extension TestViewCon {
    func request(){
        guard let searchText = searchText else {
            return
        }
        
        URLSessionManager.shared.fetchApi(type: NaverSearch.self, api: .searchImage(searchText: searchText, apiKey: .search, startNum: startNum)) { result in
            self.searchData.append(contentsOf: result.items)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
