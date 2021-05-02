//
//  GitHubAPI.swift
//  VIPER-practice
//
//  Created by 大西玲音 on 2021/04/30.
//

import Foundation

typealias ResultHandler<R> = (Result<R, GitHubError>) -> Void

enum GitHubError: Error {
    case error
    case connect
    case parse
    case invalidUrl
}

struct GitHubSearchParameters {
    
    enum Order: String {
        case desc
        case asc
    }
    
    enum Sort: String {
        case stars
    }
    
    let searchWord: String?
    private var _searchWord: String { searchWord ?? "" }
    let sort: Sort = .stars
    let order: Order = .asc
    let perPage: Int = 100
    let page: Int = 0
    
    var validation: Bool {
        !_searchWord.isEmpty && perPage <= 100 && perPage > 0
    }
    
    var queryParameter: String {
        "q=\(_searchWord)&sort=\(sort.rawValue)&order=\(order.rawValue)&per_page=\(perPage)&page=\(page)"
    }
    
}
