//
//  WebRouter.swift
//  VIPER-practice
//
//  Created by 大西玲音 on 2021/05/01.
//

import UIKit

protocol WebWireframe: AnyObject {
    func showAlert(error: Error)
}

final class WebRouter {
    
    private unowned let viewController: UIViewController
    
    private init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    static func assembleModules(initParameters: WebUsecaseInitParameters) -> UIViewController {
        let view = UIStoryboard.web.instantiateViewController(
            withIdentifier: WebViewController.identifier) as! WebViewController
        let interactor = WebInteractor(initParameters: initParameters)
        let router = WebRouter(viewController: view)
        let presenter = WebPresenter(view: view, router: router, interactor: interactor)
        view.inject(presenter: presenter)
        return view
    }
    
}

// MARK: - WebWireframe
extension WebRouter: WebWireframe {
    
    func showAlert(error: Error) {
        print(error.localizedDescription)
    }
    
}
