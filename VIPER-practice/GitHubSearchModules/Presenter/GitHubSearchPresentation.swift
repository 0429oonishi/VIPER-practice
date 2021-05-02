//
//  GitHubSearchPresentation.swift
//  VIPER-practice
//
//  Created by 大西玲音 on 2021/04/30.
//

import Foundation

protocol GitHubSearchPresentation: AnyObject {
    func viewDidLoad()
    func searchButtonDidTapped(word: String?)
    func selectItem(indexPath: IndexPath)
    func getSearchedItems() -> [GitHubSearchEntity]
}

// 他との部品以外はパラメータを持たない
// 他との中継役にだけに徹する
final class GitHubSearchPresenter {
    
    // 循環参照しないようにviewだけweak
    private weak var view: GitHubSearchView?
    private var interactor: GitHubSearchUsecase
    private var router: GitHubSearchWireframe
    
    init(view: GitHubSearchView,
         interactor: GitHubSearchUsecase,
         router: GitHubSearchWireframe) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - GithubSearchPresentation
extension GitHubSearchPresenter: GitHubSearchPresentation {
    
    func viewDidLoad() {
        view?.initView()
    }
    
    func searchButtonDidTapped(word: String?) {
        let parameters = GitHubSearchParameters(searchWord: word)
        view?.startLoading()
        interactor.get(parameters: parameters) { [weak self] result in
            guard let self = self else { return }
            self.view?.finishLoading()
            switch result {
                case .success(let items):
                    self.view?.reloadTableView(items: items)
                case .failure(let error):
                    self.router.showAlert(error: error)
            }
        }
    }
    
    func selectItem(indexPath: IndexPath) {
        let gitHubSearchEntity = interactor.getSearchedItems()[indexPath.row]
        let initParameters: WebUsecaseInitParameters = .init(entity: gitHubSearchEntity)
        router.showWeb(initParameters: initParameters)
    }
    
    func getSearchedItems() -> [GitHubSearchEntity] {
        return interactor.getSearchedItems()
    }
    
}
