//
//  GitHubSearch.swift
//  VIPER-practice
//
//  Created by 大西玲音 on 2021/04/30.
//

import Foundation

struct GitHubResponse: Codable {
    let items: [GitHubSearch]?
}

struct GitHubSearch: Codable {
    
    let id: Int
    let name: String
    private let fullName: String
    var urlString: String { "https://github.com/\(fullName)" }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
    }
    
}
