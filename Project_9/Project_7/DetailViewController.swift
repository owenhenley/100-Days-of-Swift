//
//  DetailViewController.swift
//  Project_7
//
//  Created by Owen Henley on 13/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var webview: WKWebView!
    var detailItem: Petition?

    override func loadView() {
        webview = WKWebView()
        view = webview
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        guard let detailItem = detailItem else {
            return
        }

        let html = """
        <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <style> body { font-size: 150%; } </style>
            </head>
            <body>
                \(detailItem.body)
            </body>
        </html>
        """

        webview.loadHTMLString(html, baseURL: nil)
    }
}

