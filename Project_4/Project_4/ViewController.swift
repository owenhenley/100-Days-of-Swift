//
//  ViewController.swift
//  Project_4
//
//  Created by Owen Henley on 03/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    // MARK: - Elements
    private var webView: WKWebView!
    private var progressView: UIProgressView!

    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        setupWebView()
        let url = URL(string: "https://www.google.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        addObservers()
    }

    // MARK: - Methods
    /// Setup the navigation for the main view.
    private func setupNavigation() {
        let openButton = UIBarButtonItem(title: "Open",
                                         style: .plain,
                                         target: self,
                                         action: #selector(openTapped))
        navigationItem.rightBarButtonItem = openButton

        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))

        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)

        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
    }

    /// Open the action sheet with a list of addresses.
    @objc private func openTapped() {
        let alertController = UIAlertController(title: "Open page...",
                                                message: nil,
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "apple.com",
                                                style: .default,
                                                handler: openPage))
        alertController.addAction(UIAlertAction(title: "hackingwithswift.com",
                                                style: .default,
                                                handler: openPage))
        alertController.addAction(UIAlertAction(title: "google.com",
                                               style: .default,
                                               handler: openPage))
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel))

        alertController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(alertController, animated: true)
    }

    /// Open the page selected in the action sheet.
    ///
    /// - Parameter action: The action sheet, alert action.
    private func openPage(_ action: UIAlertAction) {
        guard let linkAddress = action.title else {
            return
        }

        guard let url = URL(string: "https://" + linkAddress) else {
            return
        }

        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    /// Add the observers for the progress view.
    private func addObservers() {
        webView.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.estimatedProgress),
                            options: .new,
                            context: nil)
    }
}

// MARK: - WKNavigationDelegate
extension ViewController: WKNavigationDelegate {
    /// Set up the web view.
    private func setupWebView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}

