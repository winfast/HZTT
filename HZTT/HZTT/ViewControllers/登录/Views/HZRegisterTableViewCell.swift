//
//  HZRegisterTableViewCell.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/9.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

public enum HZRegisterCellBtnTag : Int {
	case sendCode = 0
	case register = 1
	case agreement = 2
}

class HZRegisterTableViewCell: UITableViewCell {
	


	open var phoneTextField : UITextField!
	open var codeTextField: UITextField!
	open var codeBtn: UIButton!
	open var passwordTextField: UITextField!
	open var validPasswordTextField: UITextField!
	open var registerBtn: UIButton!
	open var readAgreementBtn: UIButton!
	open var linkLabel: LinkLabel!
	
	let disposeBag = DisposeBag()
	
	typealias HZClickRegisterCellBtnBlock = (_ btn :UIView?) -> Void
	open var clickRegisterCellBtnBlock :HZClickRegisterCellBtnBlock?

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.viewsLayout()
		self.createRACSignal()
	}
	
	func viewsLayout() -> Void {
		//手机号
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
		
		self.registerBtn = UIButton.init(type: .custom)
		self.registerBtn.setBackgroundImage(HZImageWithColor(color: UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)), for: .disabled)
		self.registerBtn.setBackgroundImage(HZImageWithColor(color: UIColor.init(red: 0.78, green: 0.06, blue: 0.17, alpha: 1)), for: .normal)
		self.registerBtn.setTitleColor(.white, for: .normal)
		self.registerBtn.setTitle("注册", for: .normal)
		self.registerBtn.layer.cornerRadius = 5
		self.registerBtn.isEnabled = false
		self.registerBtn.tag = HZRegisterCellBtnTag.register.rawValue
		self.registerBtn.layer.masksToBounds = true
		self.registerBtn.addTarget(self, action: #selector(clickRegisterCellBtn(_ :)), for: .touchUpInside)
		self.contentView.addSubview(self.registerBtn)
		self.registerBtn.snp.makeConstraints { (make) in
			make.leading.equalTo(15)
			make.trailing.equalTo(-15)
			make.height.equalTo(45)
			make.top.equalTo(self.validPasswordTextField.snp.bottom).offset(20)
		}
		
		self.readAgreementBtn = UIButton.init(type: .custom)
		self.readAgreementBtn.layer.cornerRadius = 5
		self.readAgreementBtn.setImage(UIImage.init(named: "select_reviewbar_all"), for: .normal)
		self.readAgreementBtn.setImage(UIImage.init(named: "select_reviewbar_all_press"), for: .selected)
		self.readAgreementBtn.layer.masksToBounds = true
		self.readAgreementBtn.addTarget(self, action: #selector(clickRegisterCellBtn(_ :)), for: .touchUpInside)
		self.contentView.addSubview(self.readAgreementBtn)
		self.readAgreementBtn.snp.makeConstraints { (make) in
			make.leading.equalTo(15)
			make.size.equalTo(CGSize.init(width: 40, height: 40))
			make.top.equalTo(self.registerBtn.snp.bottom).offset(10)
		}
		
		self.linkLabel = LinkLabel.init()
		self.linkLabel.linkTextColor = UIColor.init(red: 0, green: 0.48, blue: 1.0, alpha: 1.0)
		self.linkLabel.font = HZFont(fontSize: 12)
		self.linkLabel.textColor = UIColor.lightGray
		self.linkLabel.text = "我已阅读并同意郸城头条“用户协议”"
		self.linkLabel.tag = HZRegisterCellBtnTag.agreement.rawValue
		self.linkLabel.textAlignment = .left
		self.linkLabel.addRegularString("“用户协议”")
		self.linkLabel.regularLinkClickBlock = { [weak self] (clickedString) -> Void  in
			guard let weakself = self else {
				return
			}
			if weakself.clickRegisterCellBtnBlock != nil {
				weakself.clickRegisterCellBtnBlock!(weakself.linkLabel)
			}
		}
		self.contentView.addSubview(self.linkLabel)
		self.linkLabel.snp.makeConstraints { (make) in
			make.left.equalTo(self.readAgreementBtn.snp.right).offset(-6)
			make.centerY.equalTo(self.readAgreementBtn.snp.centerY)
		}
	
	}
	
	func createRACSignal() -> Void {
		let phoneObservable: Observable<Bool> = self.phoneTextField.rx.text.map { (value) -> Bool in
			return value == nil ? false : true
		}.share(replay: 1, scope: .whileConnected)
		
		let codeObservable: Observable<Bool> = self.codeTextField.rx.text.map { (value) -> Bool in
			return value == nil ? false : true
		}.share(replay: 1, scope: .whileConnected)
		
		let passwordObservable: Observable<Bool> = self.passwordTextField.rx.text.map { (value) -> Bool in
			guard let currValue = value else {
				return false
			}
			return currValue.lengthOfBytes(using: .utf8) < 6 ? false : true
		}.share(replay: 1, scope: .whileConnected)
		
		let validPasswordObservable: Observable<Bool> = self.validPasswordTextField.rx.text.map { (value) -> Bool in
			return value == nil ? false : true
		}.share(replay: 1, scope: .whileConnected)
		
		Observable.combineLatest(phoneObservable, codeObservable, passwordObservable, validPasswordObservable).map { (value) -> Bool in
			return value.0 && value.1 && value.2 && value.3
		}.bind(to: self.registerBtn.rx.isEnabled).disposed(by: disposeBag)
	}
	

	@objc func clickRegisterCellBtn(_ sender: UIButton) -> Void {
		if (self.clickRegisterCellBtnBlock != nil) {
			self.clickRegisterCellBtnBlock!(sender)
		}
	}
}
