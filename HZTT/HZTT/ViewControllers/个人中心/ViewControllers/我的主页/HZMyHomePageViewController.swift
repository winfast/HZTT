//
//  HZMyHomePageViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/10.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import MJRefresh

class HZMyHomePageViewController: HZBaseViewController {
	
	var tableView: UITableView!
	let disposeBag: DisposeBag = DisposeBag.init()
	var uid :String?
	var dataSource: Array<String>! = Array.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.viewsLayout()
		self.dataRequest()
    }
	
	func viewsLayout() -> Void {
		let headerView = HZMyHomePageHeaderView.init()
		headerView.frame = CGRect.init(x: 0, y: 0, width: HZSCreenWidth(), height: 220)
		
		self.tableView = UITableView.init(frame: .zero, style: .plain)
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.separatorStyle = .none
		self.tableView.tableHeaderView = headerView
		self.tableView.register(HZMyHomepageTableViewCell.self, forCellReuseIdentifier: "HZMyHomepageTableViewCell")
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
		self.view.addSubview(self.tableView)
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
		
		self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { [weak self] in
			guard let weakself = self else {
				return
			}
			
			//继续请求列表
			weakself.dataRequest()
		})
		
		self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
			guard let weakself = self else {
				return
			}
			weakself.tableView.mj_footer?.isHidden = false
			weakself.tableView.mj_footer.state = .idle
			weakself.dataRequest()
		})
	}
	
	func dataRequest(_ pageNumber: Int = 1) -> Void {
		if HZUserInfo.isLogin() == false {
			return
		}
		var d: [String : Any];
		if uid != nil {
			d = ["category":"sy" ,
				 "uid": uid! ,
				 "pageNumber":pageNumber,
				 "type":0,
				] as [String : Any]
		} else {
			d = ["category":"sy" ,
				 "uid": HZUserInfo.share().user_id! ,
				 "pageNumber":1,
				 "type":0,
				] as [String : Any]
		}
		
		HZMeProfileNetwordManager.shared.getScURL(d).subscribe(onNext: { (value) in
			
		}).disposed(by: disposeBag)
	}
}

extension HZMyHomePageViewController :UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.dataSource.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "HZMyHomepageTableViewCell") as! HZMyHomepageTableViewCell
		cell.selectionStyle = .none
		return cell
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let point = scrollView.contentOffset
		if point.y > 5 {
			self.navigationItem.title = HZUserInfo.share().showName
		} else {
			self.navigationItem.title = ""
		}
	}
}
