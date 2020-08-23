//
//  HZLivelihoodViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/22.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZLivelihoodViewController: HZBaseViewController {

    var tableView: UITableView!
    var headerView: HZLivelihoodHeaderView!
    var messageList: Array<HZHomeCellViewModel>! = []
    
    
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        
        super.viewDidLoad()
        self.navigationItem.title = "生活"
        
        self.viewsLayout()
    }
    
    func viewsLayout() -> Void {
        self.view.backgroundColor = UIColor.white
        self.headerView = HZLivelihoodHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: HZSCreenWidth(), height: 190))
        self.headerView.dataSource = [
            ["imageName": "item_new_01", "title":"吃喝玩乐"],
            ["imageName": "item_new_02", "title":"求职招聘"],
            ["imageName": "item_new_03", "title":"商家信息"],
            ["imageName": "item_new_04", "title":"相亲交友"],
            ["imageName": "item_new_05", "title":"房屋信息"],
            ["imageName": "item_new_06", "title":"打车出行"],
            ["imageName": "item_new_07", "title":"二手交集"],
            ["imageName": "item_new_08", "title":"便民信息"]
        ]
        self.tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        self.tableView.backgroundColor = .white
        self.tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.tableHeaderView = self.headerView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableHeaderView = self.headerView
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
}

extension HZLivelihoodViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init(style: .default, reuseIdentifier: "UITableViewCell")
    }
}
