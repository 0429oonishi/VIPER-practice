//
//  WebViewController.swift
//  VIPER-practice
//
//  Created by 大西玲音 on 2021/05/01.
//

import UIKit
import WebKit

protocol WebView: AnyObject {
    func fetch(url: URL)
}

final class WebViewController: UIViewController {

    @IBOutlet private weak var webView: WKWebView!
    
    private var presenter: WebPresentation!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
    }
    
    func inject(presenter: WebPresentation) {
        self.presenter = presenter
    }
    
}

// MARK: - WebView
extension WebViewController: WebView {
    
    func fetch(url: URL) {
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
    
}
