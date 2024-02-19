//
//  SaveImageManager.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/19/24.
//

import UIKit

enum fileManagerError: Error{
    case doNotFindYourPath
}


class SaveImageManager {
    // 파일 매니저
    let fileManager = FileManager.default
    // MARK: 도큐먼트의 위치를 찾습니다.
    lazy var documets = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    let imagePath = "Image"
    
    
    /// 사진을 저장합니다.(경로 -> Image)
    func saveImageToDocument(image: UIImage, filename: String){
    
        do {
            let directory = try findFullUrl(fileCase: .image)
            // MARK: Directory를 생성합니다.
            do {
                if !fileManager.fileExists(atPath: directory.path) {
                    try fileManager.createDirectory(at: directory, withIntermediateDirectories: false)
                }
            } catch {
                print(error.localizedDescription)
            }
            
            // MARK: 이미지를 저장할 경로(파일명) 지정
            let fileUrl = directory.appendingPathComponent("\(filename).jpeg")
            
            // MARK: 이미지 압축(옵션)
            guard let data = image.jpegData(compressionQuality: 0.5) else {
                print("이미지 압축에 실패 하였습니다.")
                return
            }
            // MARK: 이미지 저장
            do {
                try data.write(to: fileUrl)
            } catch {
                print(error.localizedDescription)
            }
        } catch {
            print(error.localizedDescription)
        }
       
    }
    
    //MARK: 파일을 불러옵니다.
    func loadImageToDocuments(fileCase: FileCase, fileNameOfID: String) -> UIImage?{
        do { // 폴더까지 Url을 받아옵니다.
            let directory = try findFullUrl(fileCase: fileCase)
            // 파일까지 Url을 받아옵니다.
            let fileUrl = directory.appendingPathComponent(fileCase.dataType(fileID: fileNameOfID))
            /// 만약 파일 꺼내기 성공이면 이미지를 실패면 nil을 보냅니다.
            if fileManager.fileExists(atPath: fileUrl.path()) {
                return UIImage(contentsOfFile: fileUrl.path())
            }else {
                return nil
            }
        } catch {
            print(error)
            return nil
        }
    }
    
    // MARK: 흔적도 없이 말끔히 지워드릴께요
    /// 파일 ID를 주시면 지워드립니다.
    func deleteFileDocuments(fileCase: FileCase, fileNameID: String){
        do{
           let directory = try findFullUrl(fileCase: fileCase)
            let dataUrl = directory.appendingPathComponent(fileCase.dataType(fileID: fileNameID))
            do {
                try fileManager.removeItem(at: dataUrl)
            }catch{
                print(error.localizedDescription)
            }
        }catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    private func findFullUrl(fileCase: FileCase) throws -> URL{
        switch fileCase {
        case .image:
            guard var documets = documets else {
                throw fileManagerError.doNotFindYourPath
            }
            documets.append(path: fileCase.path)
            return documets
        }
    }
    
    enum FileCase {
        case image
        
        var path: String{
            switch self {
            case .image:
                return "Image"
            }
        }
        func dataType(fileID: String) -> String{
            switch self {
            case .image:
                "\(fileID).jpeg"
            }
        }
    }
    
}

/*
 // MARK: Directory 경로를 생성합니다. (옵션)
 let directory = documets?.appending(path: imagePath)
 
 guard let directory = directory else {
     print("directory 추가 실패")
     return
 }
 */
