//
//  ViewController.swift
//  browser
//
//  Created by Yin Li on 7/13/14.
//  Copyright (c) 2014 Whyllee. All rights reserved.
//

import UIKit
import WebKit
import QuartzCore

class ViewController: UIViewController, UIScrollViewDelegate, WKNavigationDelegate {
    
    var webView:WKWebView?;
    @IBOutlet var toolBar:UIToolbar
    @IBOutlet var headerView: UIView
    @IBOutlet var headerLabel: UILabel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self._addBottomBorder(self.headerView)
        self._initializeWebview()
    }
    
    func _initializeWebview() {
        var frame = self.view.bounds;
        let top = self.headerView.bounds.size.height
        let bottom = self.toolBar.bounds.size.height
        frame.origin.y += top
        frame.size.height -= top + bottom
        self.webView = WKWebView(frame: frame)
        
        self.webView!.allowsBackForwardNavigationGestures = true
        self.webView!.scrollView.delegate = self
        self.webView!.navigationDelegate = self
        
        self._loadUrl("http://tumblr.com")

        self.view.addSubview(self.webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func _loadUrl(url:String) {
        self.headerLabel.text = "loading ..."
        let url = NSURL(string: url)
        let request = NSURLRequest(URL:url)
        self.webView!.loadRequest(request)
    }

    func webView(webView: WKWebView!, didFinishNavigation navigation: WKNavigation!) {
        self.headerLabel.text = self.webView!.URL.host
    }
    
    func _addBottomBorder(view:UIView) {
        let bottomBorder = CALayer();
        let y = view.frame.size.height - 1.0;
        let w = view.frame.size.width
        bottomBorder.frame = CGRectMake(0.0, y, w, 1.0);
        
        bottomBorder.backgroundColor = UIColor(white: 0.5, alpha: 0.6).CGColor
        view.layer.addSublayer(bottomBorder)
    }
}

