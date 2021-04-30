//
//  UIViewController+Extension.swift
//  VIPER-practice
//
//  Created by 大西玲音 on 2021/04/30.
//

import UIKit

extension UIViewController {
    
    static var identifier: String { String(describing: self) }
    
    func show(next: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            if let nav = self.navigationController {
                nav.pushViewController(next, animated: animated)
                completion?()
            } else {
                self.present(next, animated: animated, completion: completion)
            }
        }
    }
    
}
