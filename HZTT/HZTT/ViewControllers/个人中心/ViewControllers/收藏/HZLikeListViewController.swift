//
//  HZLikeListViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/17.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import MJRefresh

class HZLikeListViewController: HZBaseViewController {
	
	var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.navigationItem.title = "收藏"
		self.viewsLayout()
    }
	
	func viewsLayout() -> Void {
		self.tableView = UITableView.init(frame: .zero, style: .plain)
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.separatorStyle = .singleLine
		self.tableView.estimatedRowHeight = 80
		self.tableView.rowHeight = UITableView.automaticDimension
		self.tableView.register(HZMyHomepageTableViewCell.self, forCellReuseIdentifier: "HZMyHomepageTableViewCell")
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
		self.view.addSubview(self.tableView)
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
		
		self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
			self?.tableView.mj_footer.isHidden = false
			self?.tableView.mj_footer.state = .idle
			//self?.dataRequest()
		})
		
		self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { [weak self] in
			guard let weakself = self else {
				return
			}
			
			
		})
	}
}

extension HZLikeListViewController :UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "HZMyHomepageTableViewCell") as! HZMyHomepageTableViewCell
		cell.selectionStyle = .none
		
		return cell
	}
}
