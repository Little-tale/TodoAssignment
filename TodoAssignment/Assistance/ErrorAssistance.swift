//
//  ErrorAssistance.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/17/24.
//

import Foundation

/// 럼의 에러를 다를 껍대기 뿐일 프로토콜
protocol RealmError: Error {
    
}
// (title: String, message: String)
enum RealmErrorCase: RealmError {
    case noHaveTable/// 테이블을 찾지못하거나 없을때
    case cantWriteObject /// 수정 혹은 삭제를 실패 했을때
    
    
    var errorTitle : String {
        switch self {
        case .noHaveTable:
            return "404Error"
        case .cantWriteObject:
            return "데이터를 쓸수가 없네요 ㅠ"
        }
    }
    
    var errorMessage : String {
        switch self {
        case .noHaveTable:
            return "테이블이 없어요!"
        case .cantWriteObject:
            return "앱을 삭제하시고 재시도 바랍니다!"
        }
        
    }
}
