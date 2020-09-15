//
//  HZWebViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/29.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import WebKit

class HZWebViewController: HZBaseViewController {
	
	var progressView: UIProgressView?
	var webView: WKWebView?
	open var url: String! = ""
	
	deinit {
		self.webView?.removeObserver(self, forKeyPath: "estimatedProgress")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		

		self.view.backgroundColor = .white
		
		self.navigationLayout()
		
		if url.lengthOfBytes(using: .utf8) == 0 {
			return
		}
		
		self.webView = WKWebView.init(frame: .zero)
		self.webView?.scrollView.delegate = self
		self.webView?.uiDelegate = self
		self.webView?.navigationDelegate = self
		self.webView?.allowsBackForwardNavigationGestures = true
		self.webView?.scrollView.showsVerticalScrollIndicator = false
		self.view.addSubview(self.webView!)
		self.webView?.snp.makeConstraints{ (make) in
			make.edges.equalTo(0)
		}

		self.progressView = UIProgressView.init()
		self.progressView?.trackTintColor = .clear
		self.progressView?.progressTintColor = UIColorWith24Hex(rgbValue: 0x333333)
		self.view.addSubview(self.progressView!);
		self.progressView?.snp.makeConstraints({ (make) in
			make.top.equalTo(self.webView!.snp.top);
			make.left.right.equalTo(0);
			make.height.equalTo(2);
		})
		
		var request: URLRequest = URLRequest.init(url: URL.init(string:"http://39.106.164.101:80/tt/" + url)!)
		request.cachePolicy = .reloadIgnoringLocalCacheData
		self.webView?.load(request)
		
		self.webView?.addObserver(self, forKeyPath: "estimatedProgress", options:NSKeyValueObservingOptions.new, context: nil)
    }
	
	func navigationLayout() -> Void {
		let leftBtn :UIButton = UIButton.init(type: .custom)
		leftBtn.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
		leftBtn.setImage(UIImage (named: "leftbackicon_sdk_login"), for: .normal)
		leftBtn.contentHorizontalAlignment = .left
		//backBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -5, bottom: 0, right: 0)
		leftBtn.addTarget(self, action: #selector(clickLeftBtn(_ :)), for: .touchUpInside)
		self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBtn)
	}
	
	@objc func clickLeftBtn(_ sender: UIButton) -> Void {
		if (self.navigationController?.viewControllers.count)! > 1 {
			self.navigationController?.popViewController(animated: true)
			return
		}
		self.dismiss(animated: true, completion: nil)
	}
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		let progressNumber: NSNumber = change![NSKeyValueChangeKey.newKey] as! NSNumber;
		let progress: Float = progressNumber.floatValue
		if progress == 1.0  {
			self.progressView?.setProgress(0, animated: true)
            self.progressView?.isHidden = true;
		} else {
			self.progressView?.setProgress(progress, animated: true)
            self.progressView?.isHidden = false;
		}
	}
}

extension HZWebViewController : UIScrollViewDelegate, WKNavigationDelegate, WKUIDelegate {
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		if self.navigationItem.title == nil {
			self.navigationItem.title = webView.title
		}
		
		webView.evaluateJavaScript("document.documentElement.style.webkitUserSelect='none';", completionHandler: nil);
        webView.evaluateJavaScript("document.documentElement.style.webkitTouchCallout='none';", completionHandler: nil);
	}
	
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        //HUD.show(info: error.localizedDescription)
    }
}
