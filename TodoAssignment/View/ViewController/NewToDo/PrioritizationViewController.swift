//
//  SegmentVIewController.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//





import UIKit
import SnapKit

// 숫자는 생략해도 되지만 그래도 있어빌리티
// MARK: 우선순위 케이스 분리
enum prioritization: Int, CaseIterable {
    case none = 0
    case low = 1
    case middle = 2
    case high = 3
    
    var name: String {
        switch self {
        case .none:
            return "없음"
        case .low:
            return "낮음"
        case .middle:
            return "중간"
        case .high:
            return "높음"
        }
    }
    var exclamationMark : String {
        switch self {
        case .none:
            ""
        case .low:
            "!"
        case .middle:
            "!!"
        case .high:
            "!!!"
        }
    }
}
// MARK: 딜리게이트 프로토콜 선언
protocol selectedPrioritization: AnyObject {
    func getPrioritization(for AllViewContoller: UIViewController ,prioitiNum: Int)
}

final class PrioritizationViewController: BaseViewController {
    let segmentView = UISegmentedControl(frame: .zero)
    
    var segmentIndex = 0
    
    weak var prioritizationDelegate : selectedPrioritization?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func configureHierarchy() {
        view.addSubview(segmentView)
    }
    @objc
    
    // MARK: 딜리게이트 프로토콜 함수 사용
    func prioritizationSet(sender: UISegmentedControl){
        print( sender.selectedSegmentIndex )
        prioritizationDelegate?.getPrioritization(for: self, prioitiNum: sender.selectedSegmentIndex)
    }
    
    
    override func configureLayout() {
        segmentView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(120)
        }
    }
    
    override func designView() {
        
        for item in prioritization.allCases {
            segmentView.insertSegment(withTitle: item.name, at: item.rawValue, animated: true)
        }
        segmentView.selectedSegmentIndex = segmentIndex
        segmentView.addTarget(self, action: #selector(prioritizationSet), for: .valueChanged)
        
    }
    
    
    
}

