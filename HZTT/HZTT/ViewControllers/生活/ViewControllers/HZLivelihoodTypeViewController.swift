//
//  HZLivelihoodTypeViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/24.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import MJRefresh

class HZLivelihoodTypeViewController: HZBaseViewController {
	var category: String!
	var type: String!
	var tableView: UITableView!
    var messageList: Array<HZHomeCellViewModel>! = []
    
	let disposeBag: DisposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		self.viewsLayout()
		self.tableView.ex_prepareToShow()
		self.dataRequest()
	}
	
	func viewsLayout() -> Void {
		self.view.backgroundColor = UIColor.white
		self.tableView = UITableView.init(frame: CGRect.zero, style: .plain)
		self.tableView.backgroundColor = .white
		self.tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.tableFooterView = UIView.init()
		self.tableView.register(HZLivelihoodTableViewCell.self, forCellReuseIdentifier: "HZLivelihoodTableViewCell")
		self.view.addSubview(self.tableView)
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
		
		let footer :MJRefreshAutoNormalFooter = MJRefreshAutoNormalFooter.init { [weak self] in
			guard let strongself = self else {return;}
			let pageNumber = strongself.messageList.count/20 == 0 ? 1 : strongself.messageList.count/20
			strongself.dataRequest(pageNumber)
		}
		footer.setTitle("已经是最后一条数据", for: .noMoreData)
		self.tableView.mj_footer = footer
		
		self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
			guard let strongself = self else {return;}
			strongself.messageList.removeAll()
			strongself.dataRequest()
		})
		
		
	}
	
	func dataRequest(_ pageNumber: Int = 1) -> Void {
		let d = ["category" : "life",
				 "pageNumber":pageNumber,
				 "subType": Int(self.type) as Any] as [String : Any]
		
		HZHomeNetworkManager.shared.getPostList(d).subscribe(onNext: { [weak self] value in
			guard let strongself = self else {return;}
			if strongself.tableView.mj_header.isRefreshing() == true {
				strongself.tableView.mj_header.endRefreshing()
			}
			
			if strongself.tableView.mj_footer.isRefreshing() == true {
				strongself.tableView.mj_footer.endRefreshing()
			}
			strongself.messageList = (strongself.messageList)! + value
			if strongself.messageList!.count == 0 {
				strongself.tableView.mj_footer.isHidden = true
				strongself.tableView.mj_footer.state = .noMoreData
			} else {
				if value.count < 20 {
					strongself.tableView.mj_footer.state = .noMoreData
				}
			}
			
			strongself.tableView.reloadData()
			strongself.tableView.ex_makeViewVisible()
		}).disposed(by: disposeBag)
	}
}

extension HZLivelihoodTypeViewController : UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return messageList.count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: HZLivelihoodTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HZLivelihoodTableViewCell") as! HZLivelihoodTableViewCell
		cell.viewModel = self.messageList[indexPath.row]
		return cell
	}
}
