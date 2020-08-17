//
//  HZHomeViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/17.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import SnapKit

class HZHomeViewController: HZBaseViewController {
	
	var tableView: UITableView!
	

    override func viewDidLoad() {
        super.viewDidLoad()
		self.viewLayout()
    }
	
	func viewLayout() -> Void {
		
		self.navigationController?.navigationBar.shadowImage = imageWithColor(color: UIColorWith24Hex(rgbValue: 0xFF0000))
		self.navigationItem.title = "";
		
		self.tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.separatorColor = UIColor.gray
		self.tableView.tableFooterView = UIView.init()
		self.tableView.rowHeight = UITableView.automaticDimension
		self.tableView.estimatedRowHeight = 150
		self.view.addSubview(self.tableView!)
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
	}
}

extension HZHomeViewController :UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 0
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		return UITableViewCell()
	}
}
