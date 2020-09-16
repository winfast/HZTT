//
//  HZMessageListViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/15.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import MJRefresh

class HZMessageListViewController: HZBaseViewController {
	
	var tableView: UITableView!
	var dataSource: Array<String>! = Array()
	
	let disposeBag: DisposeBag! = DisposeBag.init()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		self.viewsLayout()
		self.dataRequest()
	}
	
	deinit {
		print(self)
	}

	func viewsLayout() -> Void {
		self.navigationItem.title = "消息"
		
		let clearBtn = UIButton.init(type: .custom)
		clearBtn.setTitle("清空", for: .normal)
		clearBtn.setTitleColor(.gray, for: .normal)
		clearBtn.titleLabel?.font = HZFont(fontSize: 15)
		clearBtn.rx.tap
			.subscribe(onNext: { [weak self] () in
				//选择清空所有的数据
				guard let weakself = self else {
					return
				}
				
				weakself.tableView.setEditing(!weakself.tableView.isEditing, animated: true)
			})
			.disposed(by: disposeBag)
		clearBtn.contentHorizontalAlignment = .left
		self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: clearBtn)
		
		self.tableView = UITableView.init(frame: .zero, style: .plain)
		self.tableView.delegate = self;
		self.tableView.dataSource = self;
		self.tableView.backgroundColor = .clear
		self.tableView.separatorStyle = .none
		self.tableView.estimatedRowHeight = 80
		self.tableView.separatorStyle = .singleLine
		self.tableView.rowHeight = UITableView.automaticDimension
		self.tableView.tableFooterView = UIView.init()
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
		self.tableView.register(HZMessageInfoTableViewCell.self, forCellReuseIdentifier: "HZMessageInfoTableViewCell")
		self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
			guard let weakself = self else {
				return
			}
			
			weakself.dataRequest()
		})
		
		self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {  [weak self] in
			guard let weakself = self else {
				return
			}
			
			let page = weakself.dataSource.count/10 + 1
			weakself.dataRequest(page)
		})
		
		self.view.addSubview(self.tableView)
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
	}
	
	func dataRequest(_ pageNumber: Int! = 1) -> Void {
		
	}
}

extension HZMessageListViewController : UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.dataSource.count == 0 ? 1 : self.dataSource.count
		//return 10
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if self.dataSource.count == 0 {
			let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
			cell.selectionStyle = .none
			cell.textLabel?.text = "暂无消息"
			cell.textLabel?.textColor = .lightGray
			cell.textLabel?.textAlignment = .center
			cell.accessoryType = .none
			cell.isUserInteractionEnabled = false
			return cell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: "HZMessageInfoTableViewCell") as! HZMessageInfoTableViewCell
			cell.selectionStyle = .none
			cell.accessoryType = .none
			return cell
		}
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		if self.dataSource.count == 0 {
			return true
		} else {
			return true
		}
	}
	
	func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		if self.dataSource.count == 0 {
			return .none
		} else {
			return .delete
		}
	}
	
	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
		let deleteAction = UITableViewRowAction.init(style: .normal, title: "删除") { (action, indexPath) in
			//选择删除
		}
		deleteAction.backgroundColor = .red
		return [deleteAction]
	}
}
