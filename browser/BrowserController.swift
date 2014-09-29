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

class BrowserController: UIViewController, UIScrollViewDelegate, WKNavigationDelegate {
    
    var webView:WKWebView?;
    @IBOutlet var toolBar:UIToolbar?
    @IBOutlet var headerView: UIView?
    @IBOutlet var headerLabel: UILabel?
    @IBOutlet var placeholderView: UIView?
    
    @IBOutlet var buttonRefresh: UIBarButtonItem?
    @IBOutlet var buttonBack: UIBarButtonItem?
    @IBOutlet var buttonSearch: UIBarButtonItem?
    @IBOutlet var buttonAction: UIBarButtonItem?
    @IBOutlet var buttonClose: UIBarButtonItem?
    
    override init() {
        super.init(nibName: "BrowserView", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self._addBottomBorder(self.headerView!)
        self._initializeWebview()
        self._loadUrl("http://tumblr.com")
    }
    
    func _initializeWebview() {
        let frame = self.placeholderView!.bounds
        self.webView = WKWebView(frame: frame)
        
        self.webView!.allowsBackForwardNavigationGestures = true
        self.webView!.scrollView.delegate = self
        self.webView!.navigationDelegate = self
        self.webView!.autoresizingMask = .FlexibleWidth | .FlexibleHeight

        self.placeholderView!.addSubview(self.webView!)
    }
    
    @IBAction func buttonClicked(sender:UIBarButtonItem) {
        switch(sender) {
        case self.buttonBack!:
            self.webView!.goBack()
        case self.buttonSearch!:
            self._loadUrl("https://www.bing.com")
        case self.buttonRefresh!:
            self.webView!.reload()
        case self.buttonAction!:
            self._shareExtension()
        case self.buttonClose!:
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
        if let url = self.webView!.URL
        {
            let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            self.navigationController?.presentViewController(activityController, animated: true, completion: nil)
        }
    }
    
    func _loadUrl(url:String) {
        self.headerLabel!.text = "loading ..."
        let url = NSURL(string: url)
        let request = NSURLRequest(URL:url)
        self.webView!.loadRequest(request)
    }

    func webView(webView: WKWebView!, didFinishNavigation navigation: WKNavigation!) {
        self.headerLabel!.text = self.webView!.URL.host
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

