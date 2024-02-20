//
//  NaverModel.swift
//  TodoAssignment
//
//  Created by Jae hyung Kim on 2/20/24.
//

import Foundation

// MARK: - NaverSearch
struct NaverSearch: Decodable {
    let total, start, display: Int
    let items: [naverItem]
}

// MARK: - Item
struct naverItem: Decodable {
    let title: String
    let link: String
    let thumbnail: String
}
