//
//  WebInteractor.swift
//  VIPER-practice
//
//  Created by 大西玲音 on 2021/05/01.
//

import Foundation

struct WebUsecaseInitParameters {
    var entity: GitHubSearchEntity
}

protocol WebUsecase {
    func getInitParameters() -> WebUsecaseInitParameters
}

final class WebInteractor {
    
    private var initParameters: WebUsecaseInitParameters!
    
    init(initParameters: WebUsecaseInitParameters) {
        self.initParameters = initParameters
    }
    
}

// MARK: - WebUsecase
extension WebInteractor: WebUsecase {
    
    func getInitParameters() -> WebUsecaseInitParameters {
        return self.initParameters
    }
    
}
