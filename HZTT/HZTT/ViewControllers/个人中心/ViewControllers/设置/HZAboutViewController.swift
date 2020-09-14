//
//  HZAboutViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/8.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZAboutViewController: HZBaseViewController {

	var tableView: UITableView!
	var dataSource: Array<[String:Any]>!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.navigationItem.title = "关于"
		self.viewsLayout()
    }
	
	func viewsLayout() -> Void {
		self.dataSource = [
			["title":"简介","className":"HZWebViewController","param":"p/aboutus.html"],
			["title":"使用帮助","className":"HZWebViewController","param":"p/usehelp.html"],
			["title":"用户协议","className":"HZWebViewController","param":"p/userAgreement.html"],
			["title":"隐私政策","className":"HZWebViewController","param":"p/userPrivacy.html"],
			["title":"免责声明","className":"HZWebViewController","param":"p/disclaimer.html"],
			["title":"联系我们","className":"HZWebViewController","param":"p/contactus.html"]]
		
		let headView = HZAboutHeadView.init(frame: CGRect.init(x: 0, y: 0, width: HZSCreenWidth(), height: 200))
		headView.backgroundColor = .clear
		
		self.tableView = UITableView.init(frame: .zero, style: .grouped)
		self.tableView.rowHeight = UITableView.automaticDimension
		self.tableView.estimatedRowHeight = 44
		self.tableView.tableHeaderView = headView
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.separatorStyle = .singleLine
		self.tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 0)
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
		self.view.addSubview(self.tableView)
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
	}
}

extension HZAboutViewController :UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.dataSource.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
		let cellInfo: [String:Any] = self.dataSource[indexPath.row]
		cell?.backgroundColor = .white
		cell?.textLabel?.text = (cellInfo["title"] as! String)
		cell?.textLabel?.font = HZFont(fontSize: 16)
		cell?.accessoryType = .disclosureIndicator
		cell?.selectionStyle = .none
		return cell!
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cellInfo: [String:Any] = self.dataSource[indexPath.row]
		let className = (cellInfo["className"] as! String)
		
		guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
			return;
		}
		
		guard let currClassName = NSClassFromString(nameSpace + "." + className) as? HZBaseViewController.Type else {
			return
		}
		
		let webVC = currClassName.init() as! HZWebViewController
		webVC.url = (cellInfo["param"] as! String)
		self.navigationController?.pushViewController(webVC, animated: true)
		
		/*
        // 准备工作: 命名空间: 必须指定那个bundle(包)
        // 从Info.plist中获取bundle的名字
        let namespace = Bundle.main.infoDictionary!["CFBundleName"] as! String
        // 0.将控制器的字符串转成控制器类型
        let classFromStr: AnyClass? = NSClassFromString(namespace + "." + className)
        let viewControllerClass = classFromStr as! UIViewController.Type
        // 1.创建控制器对象
        let viewController = viewControllerClass.init()
        
        return viewController;
		*/
		
	}
}
