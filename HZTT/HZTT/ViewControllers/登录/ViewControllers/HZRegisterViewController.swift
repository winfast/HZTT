//
//  HZRegisterViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/9.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZRegisterViewController: HZBaseViewController {

    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.navigationItem.title = "用户注册"
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
		self.tableView.separatorStyle = .none
		self.tableView.register(HZRegisterTableViewCell.self, forCellReuseIdentifier: "HZRegisterTableViewCell")
		self.view.addSubview(self.tableView)
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
	}
}

extension HZRegisterViewController :UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "HZRegisterTableViewCell") as! HZRegisterTableViewCell
		cell.selectionStyle = .none
		
		return cell
	}
}
