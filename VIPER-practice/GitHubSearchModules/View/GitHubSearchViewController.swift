//
//  GitHubSearchViewController.swift
//  VIPER-practice
//
//  Created by 大西玲音 on 2021/04/30.
//

import UIKit

protocol GitHubSearchView: AnyObject {
    func initView()
    func startLoading()
    func finishLoading()
    func reloadTableView(items: [GitHubSearchEntity])
}

final class GitHubSearchViewController: UIViewController {

    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    
    // presenterへのアクセスはprotocolを介して行う
    private var presenter: GitHubSearchPresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GitHubSearchTableViewCell.nib,
                           forCellReuseIdentifier: GitHubSearchTableViewCell.identifier)
        searchButton.addTarget(self, action: #selector(searchButtonDidTapped), for: .touchUpInside)
        // presenterにイベントを通知
        presenter.viewDidLoad()
        
    }
    
    func inject(presenter: GitHubSearchPresentation) {
        self.presenter = presenter
    }

}

// MARK: - @objc func
@objc private extension GitHubSearchViewController {
    
    func searchButtonDidTapped() {
        // presenterにイベントを通知
        presenter.searchButtonDidTapped(word: textField.text)
    }
    
}

// MARK: - GitHubSearchView
extension GitHubSearchViewController: GitHubSearchView {
    
    func initView() {
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.indicator.isHidden = true
        }
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.indicator.isHidden = false
        }
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.indicator.isHidden = true
        }
    }
    
    func reloadTableView(items: [GitHubSearchEntity]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

// MARK: - UITableViewDelegate
extension GitHubSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // presenterにイベントを通知
        presenter.selectItem(indexPath: indexPath)
    }
    
}

// MARK: - UITableViewDataSource
extension GitHubSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // presenterにイベントを通知
        return presenter.getSearchedItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GitHubSearchTableViewCell.identifier,
                                                 for: indexPath) as! GitHubSearchTableViewCell
        // presenterにイベントを通知
        let item = presenter.getSearchedItems()[indexPath.row]
        cell.configure(gitHubSearch: item)
        return cell
    }
    
}
