//
//  HZModifyInfoViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/10.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZModifyInfoViewController: HZBaseViewController {
	
	var tableView: UITableView!
	
	var userDataInfoArray: Array<String>!
	
	var rx_nickName: BehaviorRelay<Any?> = BehaviorRelay.init(value: nil)
	var rx_sex: BehaviorRelay<Any?>!
	var rx_birthday: BehaviorRelay<Any?>!
	var rx_city: BehaviorRelay<Any?>!
	var rx_notes: BehaviorRelay<Any?>!
	
	let disposeBag :DisposeBag = DisposeBag.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.navigationItem.title = "修改资料"
		self.view.backgroundColor = UIColor.init(red:244/255.0, green: 245/255.0, blue: 247/255.0, alpha: 1)
		self.viewsLayout()
    }
	
	func viewsLayout() -> Void {
		
		let rightbtn = UIButton (frame: CGRect (x: 0, y: 0, width: 40, height: 30))
		rightbtn.setTitle("提交", for: .normal)
		rightbtn.setTitleColor(UIColor.darkGray , for: .normal)
		rightbtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
		rightbtn.addTarget(self, action: #selector(saveAction(_ :)), for: .touchUpInside)
		let rightitem = UIBarButtonItem.init(customView: rightbtn)
		self.navigationItem.rightBarButtonItem = rightitem
		
		self.userDataInfoArray = ["昵称：", "性别：", "生日：", "城市："];
		
		let headerView = HZModifyHeaderIconView.init(frame: CGRect.init(x: 0, y: 0, width: HZSCreenWidth(), height: 166))
		headerView.backgroundColor = .clear
		self.tableView = UITableView.init(frame: .zero, style: .grouped)
		self.tableView.backgroundColor = .clear
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.tableHeaderView = headerView
		self.tableView.separatorStyle = .none
		self.tableView.register(HZModifyInfoTextFieldTableViewCell.self, forCellReuseIdentifier: "HZModifyInfoTextFieldTableViewCell")
		self.tableView.register(HZModifyInfoLabelTableViewCell.self, forCellReuseIdentifier: "HZModifyInfoLabelTableViewCell")
		self.tableView.register(HZMyProfileTableViewCell.self, forCellReuseIdentifier: "HZMyProfileTableViewCell")
		self.view.addSubview(self.tableView)
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
	}
	
	@objc func saveAction(_ sender: UIButton) -> Void {
	
	}

}

extension HZModifyInfoViewController :UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if 0 == section {
			return 4
		}
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			if 0 == indexPath.row {
				let cell = tableView.dequeueReusableCell(withIdentifier: "HZModifyInfoTextFieldTableViewCell") as! HZModifyInfoTextFieldTableViewCell
				cell.selectionStyle = .none
				cell.modifyTypeLabel.text = self.userDataInfoArray[indexPath.row]
				if indexPath.row == 0 {
					cell.accessoryType = .none
				} else {
					cell.accessoryType = .disclosureIndicator
				}
				cell.modifyResultTextField.text = HZUserInfo.share().showName
				self.rx_nickName = cell.rx_CellTextField
				cell.rx_CellTextField.accept(HZUserInfo.share().showName)
				return cell
			} else {
				let cell = tableView.dequeueReusableCell(withIdentifier: "HZModifyInfoLabelTableViewCell") as! HZModifyInfoLabelTableViewCell
				cell.selectionStyle = .none
				cell.modifyTypeLabel.text = self.userDataInfoArray[indexPath.row]
				if indexPath.row == 0 {
					cell.accessoryType = .none
				} else {
					cell.accessoryType = .disclosureIndicator
				}
				
				if 1 == indexPath.row {
					cell.modifyResultLabel.text = HZUserInfo.share().sex == "0" ? "女" : "男"
					self.rx_sex = cell.rx_CellLabel
					cell.rx_CellLabel.accept(HZUserInfo.share().showName)
				} else if 2 == indexPath.row {
					self.rx_birthday = cell.rx_CellLabel
					cell.modifyResultLabel.text = HZUserInfo.share().bornDate
					cell.rx_CellLabel.accept(HZUserInfo.share().bornDate)
				}
				else if 3 == indexPath.row {
					self.rx_city = cell.rx_CellLabel
					cell.modifyResultLabel.text = HZUserInfo.share().location
					cell.rx_CellLabel.accept(HZUserInfo.share().location)
				}
				return cell
			}
			
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: "HZMyProfileTableViewCell") as! HZMyProfileTableViewCell
			cell.selectionStyle = .none
			cell.textView.text = HZUserInfo.share().notes
			self.rx_notes = cell.rx_CellTextView
			cell.rx_CellTextView.accept(HZUserInfo.share().notes)
			return cell
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.section == 1 || ( indexPath.section == 0 && indexPath.row == 0) {
			return
		}
		
		if 1 == indexPath.row {
			let _ = HZDataPickView.showWithView(self.view.window, HZDataPickViewType.sex.rawValue) { [weak self] (value) in
				//NSlog
				guard let weakself = self else {
					return
				}
				weakself.rx_sex.accept(value)
			}
		} else if 2 == indexPath.row {
			let _ = HZDatePickView.showWithView(self.view.window) { [weak self] (value) in
				guard let weakself = self else {
					return
				}
				weakself.rx_birthday.accept(value)
			}
		}
		else if 3 == indexPath.row {
			let _ = HZDataPickView.showWithView(self.view.window, HZDataPickViewType.city.rawValue) { [weak self] (value) in
				//NSlog
				guard let weakself = self else {
					return
				}
				weakself.rx_city.accept(value)
			}
		}
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		if section == 0  {
			return 45
		} else {
			return 20
		}
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		if section == 0 {
			let view = UIView.init()
			view.backgroundColor = UIColor.clear
			let contentLabel = UILabel.init()
			contentLabel.text = "个人描述"
			contentLabel.textColor = UIColor.init(red: 0.43, green: 0.43, blue: 0.45, alpha: 1)
			contentLabel.font = HZFont(fontSize: 13)
			view.addSubview(contentLabel)
			contentLabel.snp.makeConstraints { (make) in
				make.top.equalTo(23)
				make.leading.equalTo(20)
			}
			return view
		}
		return UIView.init()
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return nil
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 0.000001
	}

}
