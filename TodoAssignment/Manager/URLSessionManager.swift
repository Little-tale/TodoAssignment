//
//  URLSessionManager.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/19/24.
//

import Foundation

// API 키를 생각해보니까 지금 깃 이그노어 해봤자 도루묵펀치라 웹뷰로 해봐야 할듯하다.
// 웹에서 이미지 어떻게 가져오지??

enum ApiError : Error {
    case noData
    case noResponse
    case errorResponse
    case failRequest
    case errorDecoding
    case cantStatusCoding
    case unknownError
    case componentsError
}

protocol UrlSession{
    var baseUrl : String {get}
    var query : [URLQueryItem] {get}
    var header : [String: String] {get}
    var method : String {get}
    
}

enum naverApi: UrlSession {
    case searchImage(searchText: String, apiKey: NaverAPIKey , startNum: Int)
    
    var method: String {
        return "GET"
    }
    
    var baseUrl: String {
        return "https://openapi.naver.com/v1/search/image"
    }
    
    var host: String{
        return "openapi.naver.com"
    }
    
    var query: [URLQueryItem] {
        switch self {
        case .searchImage(let searchText,_,let startNum):
            
            return [URLQueryItem(name: "query", value: searchText),
                    URLQueryItem(name: "start", value: startNum.description)
            ]
        }
    }
    
    var header: [String : String] {
        switch self {
        case .searchImage(_,let apiKey,_):
            return apiKey.queryItems
        }
    }
    var path: String{
        return "/v1/search/image"
    }
}
// MARK: 복습을 위한 URLSetion
final class URLSessionManager {
    private init() {}
    static let shared = URLSessionManager()
    
    // 네이버 검색을 통해 이미지 테스트
    func fetchApi<T:Decodable>(type: T.Type, api: naverApi, complite: @escaping(T) -> Void) {
        // url 컴포턴츠 화
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = api.host
        urlComponents.path = api.path
    
        // String(start)
        urlComponents.queryItems = api.query
        urlComponents.queryItems?.append(URLQueryItem(name: "display", value: String(20)))
        // urlRequest 로 전환
        guard let url = urlComponents.url else {
            print(" urlComponents.url ")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = api.header
        urlRequest.httpMethod = api.method
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else {
                    print("error 가 존재")
                    return
                }
                guard let data = data else {
                    print("데이터가 없음")
                    return
                }
                guard let response = response else {
                    print("응답이 없음")
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    print("응답코드 변경실패")
                    return
                }
                guard response.statusCode == 200 else {
                    print("응답코드 200이 아님")
                    return
                }
                do{
                    let results = try JSONDecoder().decode(type, from: data)
                    complite(results)
                } catch {
                    print(error)
                    return
                }
            }.resume()
        
        }
    }
}
