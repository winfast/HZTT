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
		self.tableView.register(HZFansTableViewCell.self, forCellReuseIdentifier: "HZFansTableViewCell")
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
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
    }
    
    func dataRequest(_ pageNumber: Int! = 1) -> Void {
        
    }
}

extension HZBlacklistViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.dataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "HZFansTableViewCell") as! HZFansTableViewCell
		cell.selectionStyle = .none
		cell.removeBtn.isHidden = false
		return cell
    }
}
