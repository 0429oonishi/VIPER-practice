//
//  GitHubSearchInteractor.swift
//  VIPER-practice
//
//  Created by 大西玲音 on 2021/04/30.
//

import Foundation

protocol GitHubSearchUsecase {
    func get(parameters: GitHubSearchParameters,
             handler: ResultHandler<[GitHubSearchEntity]>?)
    func getSearchedItems() -> [GitHubSearchEntity]
}

// 他のアーキテクチャーでいうUtilityの役割も持つ
final class GitHubSearchInteractor {
    
    private var searchedItems: [GitHubSearchEntity]
    
    init() {
        searchedItems = []
    }
    
}

// MARK: - GitHubSearchUsecase
extension GitHubSearchInteractor: GitHubSearchUsecase {
    
    func get(parameters: GitHubSearchParameters,
             handler: ResultHandler<[GitHubSearch]>? = nil) {
        guard parameters.validation else {
            handler?(.failure(.error))
            return
        }
        guard let url = URL(string: "https://api.github.com/search/repositories?\(parameters.queryParameter)") else {
            handler?(.failure(.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let gitHubResponse = try? JSONDecoder().decode(GitHubSearchEntityResponse.self, from: data),
                  let items = gitHubResponse.items else {
                handler?(.failure(.error))
                return
            }
            self.searchedItems = items
            handler?(.success(items))
        }
        task.resume()
    }
    
    func getSearchedItems() -> [GitHubSearchEntity] {
        return searchedItems
    }
    
}
