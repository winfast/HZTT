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
    var topView : UIControl!
    var avatarImageV : UIImageView!
    var titleLabel : UILabel!
    var subTitleLabel : UILabel!
	var unLoginTopView: UIControl!
	
	var likeValueLabel: UILabel!
	var fanValueLabel: UILabel!
	var pointValueLabel: UILabel!
	
	let disposeBag: DisposeBag = DisposeBag.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
		self.navigationItem.title = "";
		self.hbd_barAlpha = 0.0
		self.hbd_barHidden = true 
		//self.edgesForExtendedLayout = .all;
        self.view.backgroundColor = UIColor.init(red:244/255.0, green: 245/255.0, blue: 247/255.0, alpha: 1)
        
        setupTableView()
        setupTopView()
		setupUnLoginTopView()
		
		if HZUserInfo.isLogin() {
			self.tableView.tableHeaderView = self.topView
		} else {
			self.tableView.tableHeaderView = self.unLoginTopView;
		}
    }
    
    func setupTableView() {
		self.tableView = UITableView.init(frame: .zero, style: .grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
		self.tableView.backgroundColor = .clear
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Mecell")
		//self.tableView.tableFooterView = UIView()
		self.tableView.contentInset = UIEdgeInsets.init(top: -20, left: 0, bottom: 10, right: 0)
		extendedLayoutIncludesOpaqueBars = true;
//		if #available(iOS 11.0, *) {
//			self.tableView.contentInsetAdjustmentBehavior = .never;
//		} else {
			self.automaticallyAdjustsScrollViewInsets = false;
//		}
        self.view.addSubview(self.tableView)
       
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
		
		HZUserInfo.share().rx.observe(String.self, "token").subscribe(onNext: { (value) in
			if value == nil || value?.lengthOfBytes(using: .utf8) == 0 {
				self.tableView.tableHeaderView = self.unLoginTopView;
			} else {
				self.tableView.tableHeaderView = self.topView
			}
		}).disposed(by: disposeBag)
    }
    
    func setupTopView() {
        self.topView = UIControl(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 200))
        self.topView.backgroundColor = UIColor.white
		self.topView.addTarget(self, action: #selector(clickTopView(_ :)), for: .touchUpInside)
        
        self.avatarImageV = UIImageView()
        self.avatarImageV.layer.cornerRadius = 40
        self.avatarImageV.layer.masksToBounds = true
        self.avatarImageV.image = UIImage(named: "unlogin_head")
        self.titleLabel = UILabel()
        self.titleLabel.text = ""
		self.titleLabel.font = HZFont(fontSize: 22)
        self.subTitleLabel = UILabel()
        self.subTitleLabel.text = "查看或编辑个人资料"
        self.subTitleLabel.font = UIFont.systemFont(ofSize: 15)
        self.subTitleLabel.textColor = UIColor.gray
        self.topView.addSubview(self.avatarImageV)
        self.topView.addSubview(self.titleLabel)
        self.topView.addSubview(self.subTitleLabel)
		
		let lineView = UIView.init()
		lineView.backgroundColor = UIColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
		self.topView.addSubview(lineView)
		
		let likeLabel = UILabel.init()
		likeLabel.textColor = UIColor.init(white: 0.41, alpha: 1)
		likeLabel.text = "收到的赞"
		likeLabel.font = HZFont(fontSize: 12)
		self.topView.addSubview(likeLabel)
		likeLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.topView.snp.leadingMargin).offset(20)
			make.bottom.equalTo(-15)
		}
		
		likeValueLabel = UILabel.init()
		likeValueLabel.font = HZBFont(fontSize: 16)
		likeValueLabel.text = "0"
		likeValueLabel.textColor = .black
		self.topView.addSubview(likeValueLabel)
		likeValueLabel.snp.makeConstraints { (make) in
			make.centerX.equalTo(likeLabel.snp.centerX)
			make.bottom.equalTo(likeLabel.snp.top).offset(-5)
		}
		
		
		let fanLabel = UILabel.init()
		fanLabel.textColor = UIColor.init(white: 0.41, alpha: 1)
		fanLabel.text = "粉丝"
		fanLabel.font = HZFont(fontSize: 12)
		self.topView.addSubview(fanLabel)
		fanLabel.snp.makeConstraints { (make) in
			make.centerX.equalTo(self.topView.snp.centerX)
			make.centerY.equalTo(likeLabel.snp.centerY)
		}
		
		fanValueLabel = UILabel.init()
		fanValueLabel.font = HZBFont(fontSize: 16)
		fanValueLabel.textColor = .black
		self.topView.addSubview(fanValueLabel)
		fanValueLabel.snp.makeConstraints { (make) in
			make.centerX.equalTo(fanLabel.snp_centerXWithinMargins)
			make.bottom.equalTo(fanLabel.snp.top).offset(-5)
		}
		
		
		let pointLabel = UILabel.init()
		pointLabel.textColor = UIColor.init(white: 0.41, alpha: 1)
		pointLabel.text = "积分"
		pointLabel.font = HZFont(fontSize: 12)
		self.topView.addSubview(pointLabel)
		pointLabel.snp.makeConstraints { (make) in
			make.trailing.equalTo(self.topView.snp.trailingMargin).offset(-50)
			make.centerY.equalTo(likeLabel.snp.centerY)
		}
		
		pointValueLabel = UILabel.init()
		pointValueLabel.font = HZBFont(fontSize: 16)
		pointValueLabel.textColor = .black
		self.topView.addSubview(pointValueLabel)
		pointValueLabel.snp.makeConstraints { (make) in
			make.centerX.equalTo(pointLabel.snp_centerXWithinMargins)
			make.bottom.equalTo(pointLabel.snp.top).offset(-5)
		}
		
		let infoBtn = UIButton.init(type: .custom)
		infoBtn.backgroundColor = .clear
		infoBtn.setImage(UIImage.init(named: "detail"), for: .normal)
		self.topView.addSubview(infoBtn)
		infoBtn.snp.makeConstraints { (make) in
			make.leading.equalTo(pointLabel.snp.trailing).offset(5)
			make.size.equalTo(CGSize.init(width: 30, height: 30))
			make.centerY.equalTo(pointLabel.snp.centerY)
		}
        
        self.avatarImageV.snp.makeConstraints { (make) in
            make.right.equalTo(self.topView.snp_rightMargin).offset(-10)
			make.top.equalTo(self.topView.snp.topMargin).offset(40)
            make.width.height.equalTo(80)
        }
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.topView).offset(25)
            make.right.equalTo(self.avatarImageV.snp_rightMargin).offset(-20)
			make.centerY.equalTo(self.avatarImageV.snp.centerY).offset(-10)
        }
        self.subTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.topView).offset(25)
            make.right.equalTo(self.avatarImageV).offset(-20)
            make.top.equalTo(self.titleLabel.snp_bottomMargin).offset(12)
        }
		
		lineView.snp.makeConstraints { (make) in
			make.left.equalTo(self.titleLabel.snp.left).offset(5);
			make.right.equalTo(self.topView.snp.right).offset(-30)
			make.height.equalTo(0.5)
			make.bottom.equalTo(likeValueLabel.snp.top).offset(-10)
		}
		
		//数据绑定, 用户更新用户信息的时候, 不用发送通知刷新UI, 通过数据绑定直接刷新UI
		self.createRACSignal()
    }
	
	func setupUnLoginTopView() -> Void {
		self.unLoginTopView = UIControl(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 120))
		self.unLoginTopView.backgroundColor = UIColor.white
		self.unLoginTopView.addTarget(self, action: #selector(clickTopView(_ :)), for: .touchUpInside)
		//self.tableView.tableHeaderView = self.unLoginTopView
		
		let defaultImagView = UIImageView()
		defaultImagView.image = UIImage(named: "avatar_default")
		self.unLoginTopView.addSubview(defaultImagView)
		defaultImagView.snp.makeConstraints { (make) in
			make.leading.equalTo(20)
			make.size.equalTo(CGSize.init(width: 60, height: 60))
			make.centerY.equalTo(self.unLoginTopView.snp.centerY).offset(10)
		}
		
		let loginLabel = UILabel.init()
		loginLabel.text = "前往登录"
		loginLabel.textColor = UIColor.init(white: 0.41, alpha: 1.0)
		loginLabel.font = HZBFont(fontSize: 14)
		self.unLoginTopView.addSubview(loginLabel)
		loginLabel.snp.makeConstraints { (make) in
			make.centerY.equalTo(defaultImagView.snp.centerY)
			make.leading.equalTo(defaultImagView.snp.trailing).offset(15)
		}
		
		let accessIamgeView = UIImageView.init()
		accessIamgeView.image = UIImage.init(named: "arrow_right_setup")
		unLoginTopView.addSubview(accessIamgeView)
		accessIamgeView.snp.makeConstraints { (make) in
			make.centerY.equalTo(defaultImagView.snp.centerY)
			make.trailing.equalTo(self.unLoginTopView.snp.trailing).offset(-30)
			make.size.equalTo(CGSize.init(width: 16, height: 16))
		}
	}
	
	func createRACSignal() -> Void {
		HZUserInfo.share().rx.observe(String.self, "showName").map { (value) -> String in
			guard let currShowName = value else {
				return ""
			}
			return currShowName
		}.bind(to: self.titleLabel.rx.text).disposed(by: disposeBag)
		
		HZUserInfo.share().rx.observe(String.self, "fanCnt").map { (value) -> String in
			guard let currFanCnt = value else {
				return ""
			}
			return currFanCnt
		}.bind(to: self.fanValueLabel.rx.text).disposed(by: disposeBag)
		
		HZUserInfo.share().rx.observe(String.self, "zanCnt").map { (value) -> String in
			guard let currZanCnt = value else {
				return ""
			}
			return currZanCnt
		}.bind(to: self.likeValueLabel.rx.text).disposed(by: disposeBag)
		
		HZUserInfo.share().rx.observe(String.self, "score").map { (value) -> String in
			guard let currScore = value else {
				return ""
			}
			return currScore
		}.bind(to: self.pointValueLabel.rx.text).disposed(by: disposeBag)
	}
	
	@objc func clickTopView(_ sender: UIControl) -> Void {
		if HZUserInfo.isLogin() == true {
			let vc = HZModifyInfoViewController.init()
			self.navigationController?.pushViewController(vc, animated: true)
		} else {
			let vc = HZLoginViewController.init()
			let nav = HZNavigationController.init(rootViewController: vc)
			self.present(nav, animated: true, completion: nil)
		}
		
//		let vc = HZLoginViewController.init()
//		let nav = HZNavigationController.init(rootViewController: vc)
//		self.tabBarController?.present(nav, animated: true, completion: nil)

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
		cell.backgroundColor = .white
        let name : String = dataArr[indexPath.row]
        let image : String = imageArr[indexPath.row]
        cell.textLabel?.text = name
        cell.imageView?.image = UIImage(named: image)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // MBProgressHUD.showToast("暂未开通", inView: self.view)
		//MBProgressHUD.showHub("124", inView: self.view)
		if indexPath.row == 0 {
			let vc = HZMyHomePageViewController.init()
			self.navigationController?.pushViewController(vc, animated: true)
		} else {
			let vc = HZSettingViewController.init()
			self.navigationController?.pushViewController(vc, animated: true)
		}

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 6
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = UIView.init()
		view.backgroundColor = .clear
		return view
	}
}
