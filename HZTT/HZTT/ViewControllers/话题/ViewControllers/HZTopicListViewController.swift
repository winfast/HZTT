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
			self?.messageArray.removeAll();
			self?.dataRequest()
		})
		
		let footer: MJRefreshAutoNormalFooter = MJRefreshAutoNormalFooter.init(refreshingBlock: { [weak self] in
			self?.dataRequest(((self?.messageArray!.count)!/20 == 0 ? 1 : (self?.messageArray!.count)!/20))
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
		
		HZHomeNetworkManager.shared.getPostList(param).subscribe(onNext: { [weak self] (value :[HZHomeCellViewModel]) in
			if self?.tableView.mj_header.isRefreshing() == true {
				self?.tableView.mj_header.endRefreshing()
			}
			
			if self?.tableView.mj_footer.isRefreshing() == true {
				self?.tableView.mj_footer.endRefreshing()
			}
			self?.messageArray = (self?.messageArray)! + value
			if self?.messageArray!.count == 0 {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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



