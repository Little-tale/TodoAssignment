//
//  Extension.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/14/24.
//

import UIKit

extension UIView {
    static var reuseabelIdentifier : String {
        return String(describing: self)
    }
}

extension UIViewController {
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        present(alert,animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            alert.dismiss(animated: true)
        }
    }
}


//// MARK: 사진 저장하는 메서드
//extension UIViewController {
//    /// 사진을 저장합니다.(경로 -> Image)
//    func saveImageToDocument(image: UIImage, filename: String){
//        let fileManager = FileManager.default
//        
//        // MARK: 도큐먼트의 위치를 찾습니다.
//        let documets = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
//        
//        // MARK: Directory 경로를 생성합니다. (옵션)
//        let directory = documets?.appending(path: "Image")
//        
//        guard let directory = directory else {
//            print("directory 추가 실패")
//            return
//        }
//        
//        // MARK: Directory를 생성합니다.
//        do {
//            if !fileManager.fileExists(atPath: directory.path) {
//                try fileManager.createDirectory(at: directory, withIntermediateDirectories: false)
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//        
//        // MARK: 이미지를 저장할 경로(파일명) 지정
//        let fileUrl = directory.appendingPathComponent("\(filename).jpeg")
//        
//        // MARK: 이미지 압축(옵션)
//        guard let data = image.jpegData(compressionQuality: 0.5) else {
//            print("이미지 압축에 실패 하였습니다.")
//            return
//        }
//        // MARK: 이미지 저장
//        do {
//            try data.write(to: fileUrl)
//        } catch {
//            print(error.localizedDescription)
//        }
//       
//    }
//}

//// MARK: 이미지 불러오는 메서드
//extension UIViewController {
//    /// 파일을 불러옵니다. Image Directory
//    func loadImageToDocuments(fileNameOfID: String) {
//        
//    }
//}
