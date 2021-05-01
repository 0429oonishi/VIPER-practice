//
//  WebPresentation.swift
//  VIPER-practice
//
//  Created by 大西玲音 on 2021/05/01.
//

import Foundation

protocol WebPresentation: AnyObject {
    func viewDidLoad()
}

final class WebPresenter {
    
    private weak var view: WebView?
    private let router: WebWireframe
    private let interactor: WebUsecase
    
    init(view: WebView,
         router: WebWireframe,
         interactor: WebUsecase) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - WebPresentation
extension WebPresenter: WebPresentation {
    
    func viewDidLoad() {
        guard let url = URL(string: interactor.getInitParameters().entity.urlString) else { return }
        self.view?.fetch(url: url)
    }
    
}
