//
//  HZLoginViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/9.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZLoginViewController: HZBaseViewController {
	
	var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.navigationItem.title = "手机号登录"
		self.viewsLayout()
    }
	
	func viewsLayout() -> Void {
		
		let backBtn :UIButton = UIButton.init(type: .custom)
		backBtn.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
		backBtn.setImage(UIImage (named: "leftbackicon_sdk_login"), for: .normal)
		backBtn.contentHorizontalAlignment = .left
		//backBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -5, bottom: 0, right: 0)
		backBtn.addTarget(self, action: #selector(clickBackBtn(_ :)), for: .touchUpInside)
		let leftItem :UIBarButtonItem = UIBarButtonItem.init(customView: backBtn)
		self.navigationItem.leftBarButtonItem = leftItem
		
		self.tableView = UITableView.init(frame: .zero, style: .plain)
		self.tableView.backgroundColor = UIColor.white
		self.tableView.delegate = self;
		self.tableView.dataSource = self;
		self.tableView.separatorStyle = .none
		self.tableView.rowHeight = self.view.bounds.size.height - HZNavBarHeight()
		self.tableView.showsVerticalScrollIndicator = false
		self.tableView.register(HZLoginTableViewCell.self, forCellReuseIdentifier: "HZLoginTableViewCell")
		self.view.addSubview(self.tableView)
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
	}
	
	@objc func clickBackBtn(_ sender: UIButton) -> Void {
		self.dismiss(animated: true, completion: nil)
	}
}

extension HZLoginViewController :UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "HZLoginTableViewCell") as! HZLoginTableViewCell
		cell.backgroundColor = .white
		return cell
	}
}
