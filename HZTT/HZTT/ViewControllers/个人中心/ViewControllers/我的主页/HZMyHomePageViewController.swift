//
//  HZMyHomePageViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/10.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZMyHomePageViewController: HZBaseViewController {
	
	var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.viewsLayout()
    }
	
	func viewsLayout() -> Void {
		let headerView = HZMyHomePageHeaderView.init()
		headerView.frame = CGRect.init(x: 0, y: 0, width: HZSCreenWidth(), height: 220)
		
		self.tableView = UITableView.init(frame: .zero, style: .plain)
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.separatorStyle = .none
		self.tableView.tableHeaderView = headerView
		self.view.addSubview(self.tableView)
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
	}
}

extension HZMyHomePageViewController :UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		return UITableViewCell.init()
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let point = scrollView.contentOffset
		if point.y > 5 {
			self.navigationItem.title = "123"
		} else {
			self.navigationItem.title = ""
		}
	}
}
