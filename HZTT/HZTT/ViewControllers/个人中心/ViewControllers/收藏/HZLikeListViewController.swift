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
	var dataSource: Array<Any> = Array.init()
	
	var disposeBag: DisposeBag = DisposeBag.init()

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
		self.tableView.separatorStyle = .none
		self.tableView.estimatedRowHeight = 80
		self.tableView.rowHeight = UITableView.automaticDimension
		self.tableView.tableFooterView = UIView.init()
		self.tableView.register(HZMyHomepageTableViewCell.self, forCellReuseIdentifier: "HZMyHomepageTableViewCell")
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
		self.view.addSubview(self.tableView)
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
		
		self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
			guard let weakself = self else {
				return
			}
			
			weakself.tableView.mj_footer.isHidden = false
			weakself.tableView.mj_footer.state = .idle
			weakself.dataRequest()
		})
		
		self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { [weak self] in
			guard let weakself = self else {
				return
			}
			
			let pageCount = weakself.dataSource.count/10 == 0 ? 1 : weakself.dataSource.count/10 + 1
			weakself.dataRequest(pageNumber: pageCount)
		})
		self.tableView.mj_footer.isHidden = true
	}
	
	func dataRequest(pageNumber count: Int = 1) -> Void {
		
		guard let uid = HZUserInfo.share().user_id else {return}
		let d = ["category":"sy" ,
				 "uid": uid ,
				 "pageNumber":count,
				 "type":1
				 ] as [String : Any]
		
		HZMeProfileNetwordManager.shared.getScURL(d).subscribe { [weak self] (value) in
			guard let weakself = self else {
				return
			}
			
			if weakself.tableView.mj_footer.isRefreshing() == true {
				weakself.tableView.mj_footer.endRefreshing()
			}
			
			if weakself.tableView.mj_header.isRefreshing() == true {
				weakself.tableView.mj_header.endRefreshing()
			}
			
			if count == 1 {
				weakself.dataSource.removeAll()
			}
			weakself.tableView.reloadData()
		}.disposed(by: disposeBag)
	}
}

extension HZLikeListViewController :UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSource.count == 0 ? 1 : self.dataSource.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if self.dataSource.count > 0  {
			let cell = tableView.dequeueReusableCell(withIdentifier: "HZMyHomepageTableViewCell") as! HZMyHomepageTableViewCell
			cell.selectionStyle = .none
			return cell
		} else {
			let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
			cell.selectionStyle = .none
			cell.textLabel?.text = "暂无收藏"
			cell.textLabel?.textColor = .lightGray
			cell.textLabel?.textAlignment = .center
			cell.accessoryType = .none
			cell.isUserInteractionEnabled = false
			return cell
		}
	}
}
