//
//  HZHomeDetailViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/20.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import MJRefresh

class HZHomeDetailViewController: HZBaseViewController {
	var tableView: UITableView!
	
	var iconImageView: UIImageView!
	var pid: String!
	var category: String!
	var cellViewModel: HZHomeCellViewModel?
	//var commentDataArray = [[String: Any]]()
	var disposeBag = DisposeBag()
	
	init(_ pid: String!, category: String! = "sy") {
		super.init(nibName: nil, bundle: nil)
		self.pid = pid
		self.category = category;
	}
	
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.white
		
		iconImageView = UIImageView.init(image: UIImage.init(named: "avatar_default"))
		iconImageView.frame = CGRect.init(x: 0, y: 7, width: 30, height: 30);
		iconImageView.layer.cornerRadius = 15;
		iconImageView.layer.masksToBounds = true
		iconImageView.isHidden = true
		self.navigationItem.titleView = iconImageView;
		
        // Do any additional setup after loading the view.
		self.tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.backgroundColor = UIColor.white
		self.tableView.separatorStyle = .none
		self.tableView.rowHeight = UITableView.automaticDimension
		self.tableView.estimatedRowHeight = 150
		self.tableView.register(HZHomeDetailTableViewCell.self, forCellReuseIdentifier: "HZHomeDetailTableViewCell")
		self.view.addSubview(self.tableView!)
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
		self.tableView.ex_prepareToShow()
		self.dataRequest()
    }
	
	func dataRequest() -> Void {
//		let param = ["pid":self.pid as Any,
//					 "category":self.category as Any,
//					 "type":"0"
//		]
		
		let param = ["pid":self.pid as Any,
					 "category":self.category as Any,
					 "type":"get",
					 "pageNumber":1
		]
//		let param = ["category":"sy",
//					 "subType":12,
//					 "pageNumber":1
//			] as [String : Any]
		
		HZHomeDetailNetworkManager.shared.comment(param).subscribe(onNext: { [weak self] (value :[Any]) in
		//	self.tableView.ex
//			if self?.tableView.mj_header?.isRefreshing() == true {
//				self?.tableView.mj_header?.endRefreshing()
//			}
//			
//			if self?.tableView.mj_footer?.isRefreshing() == true {
//				self?.tableView.mj_footer?.endRefreshing()
//			}
//			self?.tableView.reloadData()
//			self!.tableView.ex_makeViewVisible()
		}, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
	}

}

extension HZHomeDetailViewController :UITableViewDelegate, UITableViewDataSource {
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let contentOffset: CGPoint = scrollView.contentOffset
		if contentOffset.y < -20 {
			self.iconImageView.isHidden = false
		} else {
			self.iconImageView.isHidden = true
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return 1
		}
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			let cell: HZHomeDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HZHomeDetailTableViewCell") as! HZHomeDetailTableViewCell
			cell.viewModel = self.cellViewModel
			return cell
		} else {
			return UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "UITableViewCell")
		}
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		if 0 == section {
			return nil;
		} else {
			let headerView = UIView.init()
			headerView.backgroundColor = UIColor.white
			let titleLabel = UILabel.init()
			titleLabel.text = "全部评论"
			titleLabel.font = HZFont(fontSize: 12)
			titleLabel.textColor = UIColorWith24Hex(rgbValue: 0xB7B7B7)
			headerView.addSubview(titleLabel);
			titleLabel.snp.makeConstraints { (make) in
				make.left.equalTo(10)
				make.centerY.equalTo(0);
			}
			return headerView
		}
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		if 0 == section {
			return 0.00001
		} else {
			return 44
		}
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		if 0 == section {
			let footerView = UIView.init()
			footerView.backgroundColor = UIColorWith24Hex(rgbValue: 0xF0F0F5)
			return footerView
		} else {
			return nil;
		}
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		if 0 == section {
			return 3.0
		} else {
			return 0.00001
		}
	}
}
