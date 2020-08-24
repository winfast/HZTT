//
//  MeVC.swift
//  HZTT
//
//  Created by Sam on 2020/8/21.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class MeVC: HZBaseViewController {
    
    var dataArr = ["我的主页","消息","收藏","粉丝关注","分享给好友","设置"]
    var imageArr = ["uc_account","uc_message","uc_shouc","uc_app","uc_zhaop","uc_system"]
    var tableView : UITableView!
    var topView : UIView!
    var avatarImageV : UIImageView!
    var titleLabel : UILabel!
    var subTitleLabel : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.red
        self.navigationController?.navigationBar.isHidden = true
        setupTableView()
        setupTopView()
    }
    
    func setupTableView() {
        self.tableView = UITableView(frame: self.view.frame)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Mecell")
        self.view.addSubview(self.tableView)
        self.tableView.tableFooterView = UIView()
    }
    
    func setupTopView() {
        self.topView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 120))
        self.topView.backgroundColor = UIColor.clear
        self.tableView.tableHeaderView = self.topView
        
        self.avatarImageV = UIImageView()
        self.avatarImageV.layer.cornerRadius = 40
        self.avatarImageV.layer.masksToBounds = true
        self.avatarImageV.image = UIImage(named: "unlogin_head")
        self.titleLabel = UILabel()
        self.titleLabel.text = "夜空中最亮的星"
        self.subTitleLabel = UILabel()
        self.subTitleLabel.text = "查看或编辑个人资料"
        self.subTitleLabel.font = UIFont.systemFont(ofSize: 14)
        self.subTitleLabel.textColor = UIColor.gray
        self.topView.addSubview(self.avatarImageV)
        self.topView.addSubview(self.titleLabel)
        self.topView.addSubview(self.subTitleLabel)
        
        self.avatarImageV.snp.makeConstraints { (make) in
            make.right.equalTo(self.topView.snp_rightMargin).offset(-20)
            make.centerY.equalTo(self.topView.snp_centerYWithinMargins).offset(0)
            make.width.height.equalTo(80)
        }
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.topView).offset(40)
            make.right.equalTo(self.avatarImageV.snp_rightMargin).offset(-20)
            make.centerY.equalTo(self.topView.snp_centerYWithinMargins).offset(-10)
            make.height.equalTo(30)
        }
        self.subTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.topView).offset(40)
            make.right.equalTo(self.avatarImageV).offset(-20)
            make.top.equalTo(self.titleLabel.snp_bottomMargin).offset(12)
            make.height.equalTo(24)
            
        }
        
    }
   
}

extension MeVC :UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell =  tableView.dequeueReusableCell(withIdentifier: "Mecell")!
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        let name : String = dataArr[indexPath.row]
        let image : String = imageArr[indexPath.row]
        cell.textLabel?.text = name
        cell.imageView?.image = UIImage(named: image)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MBProgressHUD.showToast("暂未开通", inView: self.view)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
}
