//
//  GitHubSearchTableViewCell.swift
//  VIPER-practice
//
//  Created by 大西玲音 on 2021/04/30.
//

import UIKit

final class GitHubSearchTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var urlLabel: UILabel!
    
}

// MARK: - configure
extension GitHubSearchTableViewCell {
    
    func configure(gitHubSearch: GitHubSearch?) {
        titleLabel.text = gitHubSearch?.name
        urlLabel.text = gitHubSearch?.urlString
    }
    
}
