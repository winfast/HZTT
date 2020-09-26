//
//  HZHomeListViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/19.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import JXSegmentedView
import MJRefresh

class HZHomeListViewController: HZBaseViewController {
	
	var tableView: UITableView!
	var messageList: Array<HZHomeCellViewModel>! = []
	
	private var type: String!
	private var category: String!
	
	var disposeBag = DisposeBag()
	
	required init?(coder: NSCoder) {
		 fatalError("init(coder:) has not been implemented")
	}
	
	init(_ type: String, _ category: String = "sy") {
		super.init(nibName: nil, bundle: nil)
		self.type = type;
		self.category = category
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
		
		self.tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.separatorColor = UIColor.gray
		self.tableView.tableFooterView = UIView.init()
		self.tableView.rowHeight = UITableView.automaticDimension
		self.tableView.estimatedRowHeight = 150
		self.tableView.register(HZHomeTableViewCell.self, forCellReuseIdentifier: "HZHomeTableViewCell")
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
			weakself.dataRequest(pageNumber: (weakself.messageList!.count/20 == 0 ? 1 : weakself.messageList!.count/20 + 1))
		})
		footer.setTitle("已经是最后一条数据", for: .noMoreData)
		self.tableView.mj_footer = footer
		self.tableView.ex_prepareToShow()
		self.dataRequest()
    }
    
	func dataRequest(pageNumber: Int = 1) -> Void {
		if 1 == pageNumber {
			self.messageList.removeAll();
		}
		let param = ["category":"sy",
					 "subType":Int(self.type)!,
					 "pageNumber":pageNumber
		] as [String:Any]
		HZHomeNetworkManager.shared.getPostList(param).subscribe(onNext: { [weak self] (value :[HZHomeCellViewModel]) in
			if self?.tableView.mj_header.isRefreshing() == true {
				self?.tableView.mj_header.endRefreshing()
			}
			
			if self?.tableView.mj_footer.isRefreshing() == true {
				self?.tableView.mj_footer.endRefreshing()
			}
			self?.messageList = (self?.messageList)! + value
			if self?.messageList!.count == 0 {
				self?.tableView.mj_footer.isHidden = true
				self?.tableView.mj_footer.state = .noMoreData
			} else {
				if value.count < 20 {
					self?.tableView.mj_footer.state = .noMoreData
				}
			}
			
			self?.tableView.reloadData()
			self!.tableView.ex_makeViewVisible()
			}, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
	}
	
	func showCloseAlertView(_ messageId: String!) -> Void {
		let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (action) in
			
		}
		
		let okAction = UIAlertAction.init(title: "确定", style: .destructive) { (action) in
			
		}
		
		let alertViewController = UIAlertController.init(title: "不喜欢这条动态,确定屏蔽", message: nil, preferredStyle: .alert)
		alertViewController.addAction(cancelAction)
		alertViewController.addAction(okAction)
		self.navigationController?.present(alertViewController, animated: true, completion: nil)
	}
}

extension HZHomeListViewController :UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return messageList!.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: HZHomeTableViewCell =  tableView.dequeueReusableCell(withIdentifier: "HZHomeTableViewCell") as! HZHomeTableViewCell
		cell.viewModel = self.messageList![indexPath.row]
		cell.selectionStyle = .none
		cell.clickCloseBlock = { [weak self] (_ btn :UIButton?) in
			guard let weakself = self else {
				return
			}
			
			weakself.showCloseAlertView(cell.viewModel!.pid)
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cellViewModel :HZHomeCellViewModel = self.messageList[indexPath.row]
		let vc: HZHomeDetailViewController = HZHomeDetailViewController.init(cellViewModel.pid, category: "sy")
		self.navigationController?.pushViewController(vc, animated: true)
	}
}

extension HZHomeListViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
