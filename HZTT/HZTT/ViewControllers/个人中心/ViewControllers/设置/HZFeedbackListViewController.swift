//
//  HZFeedbackListViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/13.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import MJRefresh

class HZFeedbackListViewController: HZBaseViewController {
    
    var tableView: UITableView!
	var dataSource: Array<String>! = Array.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.viewsLayout()
		self.dataRequest()
    }
	
	func viewsLayout() -> Void {
		self.view.backgroundColor = .white
		self.navigationItem.title = "最新留言"
		
		self.tableView = UITableView.init(frame: .zero, style: .plain)
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.separatorStyle = .none
		self.tableView.estimatedRowHeight = 80
		self.tableView.rowHeight = UITableView.automaticDimension
		self.tableView.register(HZFansTableViewCell.self, forCellReuseIdentifier: "HZFansTableViewCell")
		self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] () in
			guard let weakself = self else {
				return
			}
			
			weakself.dataSource.removeAll()
			weakself.dataRequest();
		})
		
		self.tableView.mj_footer = MJRefreshAutoStateFooter.init(refreshingBlock: {  [weak self] () in
			guard let weakself = self else {
				return
			}
			
			let page: Int = weakself.dataSource.count/10 + 1
			weakself.dataRequest(page);
		})
		self.view.addSubview(self.tableView)
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
	}
	
	func dataRequest(_ pageNumber: Int? = 1) -> Void {
		
	}

}

extension HZFeedbackListViewController :UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSource.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		return UITableViewCell.init()
	}
}
