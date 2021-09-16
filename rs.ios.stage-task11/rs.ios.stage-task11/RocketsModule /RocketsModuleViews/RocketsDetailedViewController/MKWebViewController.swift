//
//  MKWebViewController.swift
//  rs.ios.stage-task11
//
//  Created by dev on 15.09.21.
//

import UIKit
import WebKit

class MKWebViewController: UIViewController {
    private var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webSettings = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webSettings)
        webView.load(URLRequest(url:url!))
        
        self.view.addSubview(webView)
        webView.frame = self.view.bounds
    }
    
    init(withURL url: URL) {
        super.init(nibName: nil, bundle: nil)
        self.url = url
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
