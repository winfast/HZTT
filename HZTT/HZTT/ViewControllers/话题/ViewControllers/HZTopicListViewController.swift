//
//  HZTopicListViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/25.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import JXSegmentedView
import MJRefresh

class HZTopicListViewController: HZBaseViewController {

	var category: String!
	var type: String!
	var tableView: UITableView!
	var messageArray: Array<HZHomeCellViewModel>! = []
	var disposeBag: DisposeBag! = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view.
		self.tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.separatorStyle = .none
		self.tableView.tableFooterView = UIView.init()
		self.tableView.rowHeight = UITableView.automaticDimension
		self.tableView.estimatedRowHeight = 150
		self.tableView.register(HZTopicListTableViewCell.self, forCellReuseIdentifier: "HZTopicListTableViewCell")
		self.view.addSubview(self.tableView!)
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
		
		self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
			self?.tableView.mj_footer.isHidden = false
			self?.tableView.mj_footer.state = .idle
			
			self?.dataRequest()
		})
		
		let footer: MJRefreshAutoNormalFooter = MJRefreshAutoNormalFooter.init(refreshingBlock: { [weak self] in
			guard let weakself = self else {
				return
			}
			weakself.dataRequest(weakself.messageArray!.count/20 == 0 ? 1 : weakself.messageArray!.count/20 + 1)
		})
		footer.setTitle("已经是最后一条数据", for: .noMoreData)
		self.tableView.mj_footer = footer
		self.tableView.ex_prepareToShow()
		self.dataRequest()
    }
	
	func dataRequest(_ pageNumber: Int! = 1) -> Void {
		let param = ["category":self.category!,
					 "subType":Int(self.type)!,
					 "pageNumber":pageNumber as Any
			] as [String:Any]
		
		HZHomeNetworkManager.shared.getPostList(param)
			.subscribe(onNext: { [weak self] (value :[HZHomeCellViewModel]) in
				guard let weakself = self else {
					return
				}
				
				if weakself.tableView.mj_header.isRefreshing() == true {
					weakself.tableView.mj_header.endRefreshing()
				}
				
				if weakself.tableView.mj_footer.isRefreshing() == true {
					weakself.tableView.mj_footer.endRefreshing()
				}
				
				if pageNumber == 1 {
					weakself.messageArray.removeAll();
				}
				
				weakself.messageArray = (self?.messageArray)! + value
				if weakself.messageArray!.count == 0 {
					weakself.tableView.mj_footer.isHidden = true
					weakself.tableView.mj_footer.state = .noMoreData
				} else {
					if value.count < 20 {
						weakself.tableView.mj_footer.state = .noMoreData
					}
				}
				
				weakself.tableView.reloadData()
				weakself.tableView.ex_makeViewVisible()
				}, onError: nil, onCompleted: nil, onDisposed: nil)
			.disposed(by: disposeBag)
	}
    

	func showCloseAlertView(_ messageId: String) -> Void {
		let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (action) in
			
		}
		
		let okAction = UIAlertAction.init(title: "确定", style: .destructive) { (action) in
			//屏蔽消息接口, 肯定传消息ID
		}
		
		let alertViewController = UIAlertController.init(title: "不喜欢这条动态,确定屏蔽", message: nil, preferredStyle: .alert)
		alertViewController.addAction(cancelAction)
		alertViewController.addAction(okAction)
		self.navigationController?.present(alertViewController, animated: true, completion: nil)
	}
}

extension HZTopicListViewController :UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.messageArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell :HZTopicListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HZTopicListTableViewCell") as! HZTopicListTableViewCell
		cell.viewModel = self.messageArray[indexPath.row]
		cell.clickCloseBlock = { [weak self] (_ btn :UIButton?) -> Void in
			guard let weakself = self else {
				return
			}
			
			weakself.showCloseAlertView(cell.viewModel.pid!)
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let pid = self.messageArray[indexPath.row].pid
		let vc: HZHomeDetailViewController = HZHomeDetailViewController.init(pid, category: "zt")
		self.navigationController?.pushViewController(vc, animated: true)
	}
}

extension HZTopicListViewController :JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
		return self.view
    }
}



