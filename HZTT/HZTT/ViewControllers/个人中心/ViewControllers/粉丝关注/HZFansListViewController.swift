//
//  HZFansListViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/14.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import JXSegmentedView
import MJRefresh

class HZFansListViewController: HZBaseViewController {
	
	var tableView: UITableView!
	var dataSource: Array<String>!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.viewsLayout()
    }
	
	func viewsLayout() -> Void {
		self.tableView = UITableView.init(frame: .zero, style: .plain)
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.separatorStyle = .none
		self.tableView.estimatedRowHeight = 0
		self.tableView.rowHeight = UITableView.automaticDimension
		self.tableView.register(HZFansTableViewCell.self, forCellReuseIdentifier: "HZFansTableViewCell")
		self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] () in
			guard let weakself = self else {
				return
			}
			
			weakself.dataSource.removeAll()
			weakself.dataRequest(1);
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

extension HZFansListViewController :UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 0
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "HZFansTableViewCell") as! HZFansTableViewCell
		cell.selectionStyle = .none
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = HZMyHomePageViewController.init()
		vc.uid = "123123123"
		self.navigationController?.pushViewController(vc, animated: true)
	}
}

extension HZFansListViewController : JXSegmentedListContainerViewListDelegate {
	func listView() -> UIView {
		return self.view
	}
}
