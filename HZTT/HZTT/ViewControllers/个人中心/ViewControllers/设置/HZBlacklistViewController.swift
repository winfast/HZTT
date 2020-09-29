//
//  HZBlacklistViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/13.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import MJRefresh

class HZBlacklistViewController: HZBaseViewController {
    
    var tableView: UITableView!
	var dataSource: Array<String>! = Array()
	
	let disposeBag: DisposeBag = DisposeBag.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewsLayout()
        self.dataRequest()
    }
    
    
    func viewsLayout() -> Void {
		self.navigationItem.title = "黑名单"
		
        self.tableView = UITableView.init(frame: .zero, style: .plain)
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = .clear
		self.tableView.estimatedRowHeight = 80
		self.tableView.rowHeight = UITableView.automaticDimension
		self.tableView.tableFooterView = UIView.init()
		self.tableView.separatorStyle = .none
		self.tableView.register(HZFansTableViewCell.self, forCellReuseIdentifier: "HZFansTableViewCell")
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
            guard let weakself = self else {
                return
            }
            
            weakself.dataRequest()
        })
        
		
        self.tableView.mj_footer = MJRefreshAutoStateFooter.init(refreshingBlock: { [weak self] in
            guard let weakself = self else {
                return
            }
			
			let page = weakself.dataSource.count/10 + 1
			weakself.dataRequest(page)
        })
		self.tableView.mj_footer.isHidden = true
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
    }
    
    func dataRequest(_ pageNumber: Int! = 1) -> Void {
		guard let myid = HZUserInfo.share().user_id else {return}
		let d = ["uid":myid , "auhorId":"_author" , "type":1] as [String : Any]
		HZMeProfileNetwordManager.shared.blackListURL(d).subscribe { [weak self] (value) in
			guard let weakself = self else {
				return
			}
			
			if weakself.tableView.mj_header.isRefreshing() == true {
				weakself.tableView.mj_header.endRefreshing()
			}
			
			if weakself.tableView.mj_footer.isRefreshing() == true {
				weakself.tableView.mj_footer.endRefreshing()
			}
			
			if weakself.dataSource.count == 0 {
				weakself.tableView.separatorStyle = .none
			} else {
				weakself.tableView.separatorStyle = .singleLine
			}
			
		}.disposed(by: disposeBag)

    }
}

extension HZBlacklistViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.dataSource.count == 0 ? 1 : self.dataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if self.dataSource.count  > 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "HZFansTableViewCell") as! HZFansTableViewCell
			cell.selectionStyle = .none
			cell.removeBtn.isHidden = false
			return cell
		} else{
			let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
			cell.selectionStyle = .none
			cell.textLabel?.text = "暂无黑名单"
			cell.textLabel?.textColor = .lightGray
			cell.textLabel?.textAlignment = .center
			cell.accessoryType = .none
			cell.isUserInteractionEnabled = false
			return cell
		}
    }
}
