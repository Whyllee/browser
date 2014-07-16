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
    
    @IBOutlet var buttonRefresh: UIBarButtonItem
    @IBOutlet var buttonBack: UIBarButtonItem
    @IBOutlet var buttonSearch: UIBarButtonItem
    @IBOutlet var buttonAction: UIBarButtonItem
    @IBOutlet var buttonClose: UIBarButtonItem
    
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
    
    @IBAction func buttonClicked(sender:UIBarButtonItem) {
        switch(sender) {
        case buttonBack:
            self.webView!.goBack()
        case buttonSearch:
            self._loadUrl("https://www.bing.com/images")
        case buttonRefresh:
            self.webView!.reload()
        case buttonAction:
            self._shareExtension()
        case buttonClose:
            self.dismissViewControllerAnimated(true, completion: nil)
        default:
            self.webView!.loadHTMLString("Hello world!", baseURL: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func _shareExtension() {
        let activityController = UIActivityViewController()
        self.navigationController.pushViewController(activityController, animated: true)
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

