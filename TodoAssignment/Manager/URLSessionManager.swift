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
    var query : URLQueryItem? {get}
    var header : [String: String] {get}
    var method : String {get}
    
}

enum naverApi: UrlSession {
    case searchImage(searchText: String, apiKey: NaverAPIKey)
    
    var method: String {
        return "GET"
    }
    
    var baseUrl: String {
        return "https://openapi.naver.com/v1/search/image"
    }
    
    var query: URLQueryItem? {
        switch self {
        case .searchImage(let searchText,_):
            return URLQueryItem(name: "query", value: searchText)
        }
    }
    
    var header: [String : String] {
        switch self {
        case .searchImage(_,let apiKey):
            return apiKey.queryItems
        }
    }
}

final class URLSessionManager {
    private init() {}
    static let shared = URLSessionManager()
    
    
}
