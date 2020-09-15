//
//  HZForgetPasswordTableViewCell.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/9.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZForgetPasswordTableViewCell: UITableViewCell {
	
	var phoneTextField: UITextField!
	var codeTextField: UITextField!
	var codeBtn: UIButton!
	var passwordTextField: UITextField!
	var validPasswordTextField: UITextField!
	var modifyBtn: UIButton!
	let disposeBag: DisposeBag = DisposeBag.init()
	
	var timer :Disposable?

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.viewsLayout()
		self.createRACSignal()
	}
	
	func viewsLayout() -> Void {
		phoneTextField = UITextField.init()
		phoneTextField.backgroundColor = UIColor.clear
		phoneTextField.clearButtonMode = .whileEditing
		phoneTextField.placeholder = "输入手机号"
		phoneTextField.font = HZFont(fontSize: 15)
		self.contentView.addSubview(phoneTextField)
		phoneTextField.snp.makeConstraints { (make) in
			make.leading.equalTo(30)
			make.trailing.equalTo(-30)
			make.top.equalTo(30)
			make.height.equalTo(50)
		}
		
		let phoneLineView = UIView.init()
		phoneLineView.backgroundColor = UIColorWith24Hex(rgbValue: 0xE5E5E5)
		self.contentView.addSubview(phoneLineView)
		phoneLineView.snp.makeConstraints { (make) in
			make.left.right.equalTo(self.phoneTextField)
			make.height.equalTo(1)
			make.bottom.equalTo(phoneTextField.snp.bottom)
		}
		
		//验证码
		codeTextField = UITextField.init()
		codeTextField.backgroundColor = UIColor.clear
		codeTextField.clearButtonMode = .whileEditing
		codeTextField.placeholder = "输入验证码"
		codeTextField.font = HZFont(fontSize: 15)
		self.contentView.addSubview(codeTextField)
		codeTextField.snp.makeConstraints { (make) in
			make.leading.equalTo(30)
			make.trailing.equalTo(-80 - 20 - 20)
			make.top.equalTo(self.phoneTextField.snp.bottom).offset(10)
			make.height.equalTo(50)
		}
		
		codeBtn = UIButton.init(type: .custom)
		codeBtn.setTitleColor(UIColor.init(red: 0.83, green: 0.15, blue: 0.22, alpha: 1), for: .normal)
		codeBtn.setTitle("获取验证码", for: .normal)
		codeBtn.tag = HZRegisterCellBtnTag.sendCode.rawValue
		codeBtn.titleLabel?.font = HZFont(fontSize: 13)
		codeBtn.rx.tap
		.subscribe(onNext: { [weak self] () in
			guard let weakself = self else {
				return
			}
			weakself.endEditing(true)
			if weakself.phoneTextField.text?.lengthOfBytes(using: .utf8) != 11 {
				MBProgressHUD.showToast("请输入正确的手机号码", inView: weakself.window)
				return
			}
			
			//启动定时器
			weakself.timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] (value) in
				guard let weakself = self else {
					return
				}
				
				if value > 60 {
					weakself.codeBtn.isEnabled = true
					weakself.codeBtn.setTitle("获取验证码", for: .normal)
					weakself.timer!.dispose()
					weakself.timer = nil
				} else {
					weakself.codeBtn.isEnabled = false
					weakself.codeBtn.setTitle("\(value)" + "S", for: .normal)
				}
			})
		}).disposed(by: disposeBag)
		self.contentView.addSubview(self.codeBtn)
		self.codeBtn.snp.makeConstraints { (make) in
			make.right.equalTo(-20)
			make.width.equalTo(80)
			make.height.equalTo(40)
			make.bottom.equalTo(self.codeTextField.snp.bottom)
		}
		
		let codeLineView = UIView.init()
		codeLineView.backgroundColor = UIColorWith24Hex(rgbValue: 0xE5E5E5)
		self.contentView.addSubview(codeLineView)
		codeLineView.snp.makeConstraints { (make) in
			make.left.right.equalTo(phoneLineView)
			make.height.equalTo(1)
			make.bottom.equalTo(codeTextField.snp.bottom)
		}
		
		passwordTextField = UITextField.init()
		passwordTextField.backgroundColor = UIColor.clear
		passwordTextField.clearButtonMode = .whileEditing
		passwordTextField.isSecureTextEntry = true
		passwordTextField.placeholder = "设置密码(6位以上的字母或数字)"
		passwordTextField.font = HZFont(fontSize: 15)
		self.contentView.addSubview(passwordTextField)
		passwordTextField.snp.makeConstraints { (make) in
			make.leading.equalTo(30)
			make.trailing.equalTo(-30)
			make.top.equalTo(self.codeTextField.snp.bottom).offset(10)
			make.height.equalTo(50)
		}
		
		let passwordLineView = UIView.init()
		passwordLineView.backgroundColor = UIColorWith24Hex(rgbValue: 0xE5E5E5)
		self.contentView.addSubview(passwordLineView)
		passwordLineView.snp.makeConstraints { (make) in
			make.left.right.equalTo(phoneLineView)
			make.height.equalTo(1)
			make.bottom.equalTo(passwordTextField.snp.bottom)
		}
		
		validPasswordTextField = UITextField.init()
		validPasswordTextField.backgroundColor = UIColor.clear
		validPasswordTextField.clearButtonMode = .whileEditing
		validPasswordTextField.isSecureTextEntry = true
		validPasswordTextField.placeholder = "请再次输入密码"
		validPasswordTextField.font = HZFont(fontSize: 15)
		self.contentView.addSubview(validPasswordTextField)
		validPasswordTextField.snp.makeConstraints { (make) in
			make.leading.equalTo(30)
			make.trailing.equalTo(-30)
			make.top.equalTo(self.passwordTextField.snp.bottom).offset(10)
			make.height.equalTo(50)
		}
		
		let validPasswordLineView = UIView.init()
		validPasswordLineView.backgroundColor = UIColorWith24Hex(rgbValue: 0xE5E5E5)
		self.contentView.addSubview(validPasswordLineView)
		validPasswordLineView.snp.makeConstraints { (make) in
			make.left.right.equalTo(phoneLineView)
			make.height.equalTo(1)
			make.bottom.equalTo(validPasswordTextField.snp.bottom)
		}
		
		self.modifyBtn = UIButton.init(type: .custom)
		self.modifyBtn.setBackgroundImage(HZImageWithColor(color: UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)), for: .disabled)
		self.modifyBtn.setBackgroundImage(HZImageWithColor(color: UIColor.init(red: 0.78, green: 0.06, blue: 0.17, alpha: 1)), for: .normal)
		self.modifyBtn.setTitleColor(.white, for: .normal)
		self.modifyBtn.setTitle("修改", for: .normal)
		self.modifyBtn.layer.cornerRadius = 5
		self.modifyBtn.isEnabled = false
		self.modifyBtn.layer.masksToBounds = true
		self.modifyBtn.rx.tap.subscribe(onNext: { [weak self] () in
			guard let weakself = self else {
				return
			}
			
			
		}).disposed(by: disposeBag)
		
		self.contentView.addSubview(self.modifyBtn)
		self.modifyBtn.snp.makeConstraints { (make) in
			make.leading.equalTo(15)
			make.trailing.equalTo(-10)
			make.height.equalTo(45)
			make.top.equalTo(self.validPasswordTextField.snp.bottom).offset(30)
		}
	}
	
	func createRACSignal() -> Void {
		let phoneValid: Observable<Bool> = self.phoneTextField.rx.text.map { (value) -> Bool in
			guard let valueItem = value else {
				return false
			}
			
			return valueItem.lengthOfBytes(using: .utf8) > 0 ? true : false
		}
		
		let codeValid: Observable<Bool> = self.codeTextField.rx.text.map { (value) -> Bool in
			guard let valueItem = value else {
				return false
			}
			
			return valueItem.lengthOfBytes(using: .utf8) > 0 ? true : false
		}
		
		let passwordvalid: Observable<Bool> = self.passwordTextField.rx.text.map { (value) -> Bool in
			guard let valueItem = value else {
				return false
			}
			
			return valueItem.lengthOfBytes(using: .utf8) > 6 ? true : false
		}
		
		let comfirmPasswordvalid: Observable<Bool> = self.validPasswordTextField.rx.text.map { (value) -> Bool in
			guard let valueItem = value else {
				return false
			}
			
			return valueItem.lengthOfBytes(using: .utf8) > 0 ? true : false
		}
		
		Observable.combineLatest(phoneValid, codeValid, passwordvalid, comfirmPasswordvalid).map { (value) -> Bool in
			return value.0 && value.1 && value.2 && value.3
		}.bind(to: self.modifyBtn.rx.isEnabled).disposed(by: disposeBag)
		
	}


}
