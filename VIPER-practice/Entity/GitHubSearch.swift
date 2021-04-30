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
    
    let id: String
    let name: String
    private let fullName: String
    var urlString: String { "https://github.com/\(fullName)" }
    enum CodingKeys: String, CodingKey {
      case id
      case name
      case fullName = "full_name"
    }
    
}

extension GitHubSearch {
    
    private static var jsonString: String {
        """
        {
        "id": 100,
        "name": "REON",
        "full_name": "OONISHI REON"
        }
        """
    }
    
}
