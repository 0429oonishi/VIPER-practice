//
//  GitHubSearchInteractor.swift
//  VIPER-practice
//
//  Created by 大西玲音 on 2021/04/30.
//

import Foundation

protocol GitHubSearchUsecase {
    func get(parameters: GitHubSearchParameters, handler: ResultHandler<[GitHubSearchEntity]>?)
    func getSearchedItems() -> [GitHubSearchEntity]
}

final class GitHubSearchInteractor {
    
    private var searchedItems: [GitHubSearchEntity]
    
    init() {
        searchedItems = []
    }
    
}

// MARK: - GitHubSearchUsecase
extension GitHubSearchInteractor: GitHubSearchUsecase {
    
    func get(parameters: GitHubSearchParameters, handler: ResultHandler<[GitHubSearchEntity]>? = nil) {
        GitHubAPI.shared.get(parameters: parameters) { result in
            switch result {
                case .success(let items):
                    self.searchedItems = items
                case .failure(let error):
                    fatalError("\(error)")
            }
        }
    }
    
    func getSearchedItems() -> [GitHubSearchEntity] {
        return searchedItems
    }
    
}
