//
//  TopViewController.swift
//  VIPER-practice
//
//  Created by 大西玲音 on 2021/05/01.
//

import UIKit

final class TopViewController: UIViewController {
    
    @IBAction private func buttonDidTapped(_ sender: Any) {
        self.show(next: GitHubSearchRouter.assembleModules())
    }
    
}
