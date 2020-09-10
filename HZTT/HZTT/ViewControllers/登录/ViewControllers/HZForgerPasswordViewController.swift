//
//  HZForgerPasswordViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/9.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZForgerPasswordViewController: HZBaseViewController {
	
	
	var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		self.navigationItem.title = "忘记密码"
		self.viewsLayout()
	}
	
	func viewsLayout() -> Void {
		
		self.tableView = UITableView.init(frame: .zero, style: .plain)
		self.tableView.backgroundColor = UIColor.white
		self.tableView.delegate = self;
		self.tableView.dataSource = self;
		self.tableView.separatorStyle = .none
		self.tableView.rowHeight = self.view.bounds.size.height - HZNavBarHeight()
		self.tableView.showsVerticalScrollIndicator = false
		self.tableView.register(HZForgetPasswordTableViewCell.self, forCellReuseIdentifier: "HZForgetPasswordTableViewCell")
		self.view.addSubview(self.tableView)
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
	}
}

extension HZForgerPasswordViewController :UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "HZForgetPasswordTableViewCell") as! HZForgetPasswordTableViewCell
		cell.selectionStyle = .none
		return cell
	}
}
