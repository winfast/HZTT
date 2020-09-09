//
//  HZLivelihoodViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/22.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import MJRefresh

class HZLivelihoodViewController: HZBaseViewController {

    var tableView: UITableView!
    var headerView: HZLivelihoodHeaderView!
    var messageList: Array<HZHomeCellViewModel>! = []
    
	let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        
        super.viewDidLoad()
        self.navigationItem.title = "生活"
        
        self.viewsLayout()
		self.tableView.ex_prepareToShow()
		self.dataRequest()
    }
    
    func viewsLayout() -> Void {
        self.view.backgroundColor = UIColor.white
        self.headerView = HZLivelihoodHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: HZSCreenWidth(), height: 190))
        self.headerView.dataSource = [
			["imageName": "item_new_01", "title":"吃喝玩乐", "type":"20"],
            ["imageName": "item_new_02", "title":"求职招聘", "type":"21"],
            ["imageName": "item_new_03", "title":"商家信息", "type":"22"],
            ["imageName": "item_new_04", "title":"相亲交友", "type":"23"],
            ["imageName": "item_new_05", "title":"房屋信息", "type":"24"],
            ["imageName": "item_new_06", "title":"打车出行", "type":"25"],
            ["imageName": "item_new_07", "title":"二手交集", "type":"26"],
            ["imageName": "item_new_08", "title":"便民信息", "type":"27"]
        ]
		self.headerView.selectedLivelihoodIndex = { [weak self] (_ selectedIndex: Int) -> Void in
			guard let strongSelf = self else {
				return
			}
			
			let vc :HZLivelihoodTypeViewController = HZLivelihoodTypeViewController.init()
			vc.category = "life"
			vc.navigationItem.title = strongSelf.headerView.dataSource[selectedIndex]["title"]
			vc.type = strongSelf.headerView.dataSource[selectedIndex]["type"]
			strongSelf.navigationController?.pushViewController(vc, animated: true)
		}
        self.tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        self.tableView.backgroundColor = .white
        self.tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.delegate = self
        self.tableView.dataSource = self
		self.tableView.rowHeight = UITableView.automaticDimension
		self.tableView.estimatedRowHeight = 80
        self.tableView.tableHeaderView = self.headerView
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
				 "subType": 0] as [String : Any]
		
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

extension HZLivelihoodViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let pid = self.messageList[indexPath.row].pid
		let vc: HZHomeDetailViewController = HZHomeDetailViewController.init(pid, category: "life")
		self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: HZLivelihoodTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HZLivelihoodTableViewCell") as! HZLivelihoodTableViewCell
		cell.selectionStyle = .none
		cell.viewModel = self.messageList[indexPath.row]
		return cell
    }
	
}
