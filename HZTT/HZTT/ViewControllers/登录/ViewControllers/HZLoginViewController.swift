//
//  HZLoginViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/9.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZLoginViewController: HZBaseViewController {
	
	var tableView: UITableView!
	
	let disposeBag: DisposeBag = DisposeBag.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.navigationItem.title = "手机号登录"
		self.viewsLayout()
    }
	
	func viewsLayout() -> Void {
		
		let backBtn :UIButton = UIButton.init(type: .custom)
		backBtn.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
		backBtn.setImage(UIImage (named: "leftbackicon_sdk_login"), for: .normal)
		backBtn.contentHorizontalAlignment = .left
		//backBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -5, bottom: 0, right: 0)
		backBtn.addTarget(self, action: #selector(clickBackBtn(_ :)), for: .touchUpInside)
		let leftItem :UIBarButtonItem = UIBarButtonItem.init(customView: backBtn)
		self.navigationItem.leftBarButtonItem = leftItem
		
		self.tableView = UITableView.init(frame: .zero, style: .plain)
		self.tableView.backgroundColor = UIColor.white
		self.tableView.delegate = self;
		self.tableView.dataSource = self;
		self.tableView.separatorStyle = .none
		self.tableView.rowHeight = self.view.bounds.size.height - HZNavBarHeight()
		self.tableView.showsVerticalScrollIndicator = false
		self.tableView.register(HZLoginTableViewCell.self, forCellReuseIdentifier: "HZLoginTableViewCell")
		self.view.addSubview(self.tableView)
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
	}
	
	@objc func clickBackBtn(_ sender: UIButton) -> Void {
		self.dismiss(animated: true, completion: nil)
	}
	
	func showForgetPasswordView() -> Void {
		let vc = HZForgerPasswordViewController.init()
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	func showRegisterView() -> Void {
		let vc = HZRegisterViewController.init()
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	func loginPassword(phone: String, password: String) -> Void {
		self.view.endEditing(true)
		
		//登录请求
		let d = ["phone_number":phone,
				 "pwd":password]
		
		HZUserInfoNetworkManager.shared.login(d).subscribe(onNext: { (value) in
			//登录接口
			MBProgressHUD.showToast("登录成功", inView: self.view.window)
			HZUserInfo.share().saveUserInfo(value)
			self.dismiss(animated: true, completion: nil)
		}).disposed(by: disposeBag)
	}
}

extension HZLoginViewController :UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "HZLoginTableViewCell") as! HZLoginTableViewCell
		cell.backgroundColor = .white
		cell.clickLoginCellBtnBlock = { [weak self] (sender) in
			guard let weakself = self else {
				return
			}
			let tag = sender?.tag
			if tag == 0 {
				weakself.loginPassword(phone: cell.phoneTextField.text!, password: cell.passwordTextField.text!)
			} else if tag == 1 {
				weakself.showRegisterView()
			} else if tag == 2 {
				weakself.showForgetPasswordView()
			}
		}
		return cell
	}
}
