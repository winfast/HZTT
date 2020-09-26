//
//  HZLoginTableViewCell.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/9.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit


class HZLoginTableViewCell: UITableViewCell {
	
	public enum HZLoginCellBtnTag : Int {
        case login = 0
		case register = 1
		case forget = 2
    }
	
	open var appLogoImageView: UIImageView!
	open var phoneTextField: UITextField!
	var passwordTextField: UITextField!
	var loginBtn: UIButton!
	var registerBtn: UIButton!
	var forgetPasswordBtn: UIButton!
	
	let disposeBag = DisposeBag()
	
	typealias HZClickLoginCellBtnBlock = (_ btn :UIButton?) -> Void
	open var clickLoginCellBtnBlock :HZClickLoginCellBtnBlock?
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.selectionStyle = .none
		self.viewsLayout()
		self.createRACSignal()
	}
	
	func viewsLayout() -> Void {
		appLogoImageView = UIImageView.init(image: UIImage.init(named: "600x153"))
		appLogoImageView.backgroundColor = .clear
		self.contentView.addSubview(appLogoImageView)
		appLogoImageView.snp.makeConstraints { (make) in
			make.centerX.equalTo(self.contentView.snp.centerX)
			make.top.equalTo(20)
			make.size.equalTo(CGSize.init(width: 300, height: 76))
		}
		
		phoneTextField = UITextField.init()
		phoneTextField.backgroundColor = .clear
		phoneTextField.placeholder = "请输入手机号"
		phoneTextField.textAlignment = .center
		phoneTextField.font = HZFont(fontSize: 15)
		phoneTextField.clearButtonMode = .whileEditing
		phoneTextField.keyboardType = .numberPad
		phoneTextField.textColor = UIColor.black
		self.contentView.addSubview(phoneTextField)
		phoneTextField.snp.makeConstraints { (make) in
			make.leading.equalTo(30)
			make.trailing.equalTo(-30)
			make.height.equalTo(50)
			make.top.equalTo(self.appLogoImageView.snp.bottom).offset(30)
		}
		
		let phoneLineView = UIView.init()
		phoneLineView.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
		self.contentView.addSubview(phoneLineView)
		phoneLineView.snp.makeConstraints { (make) in
			make.leading.trailing.equalTo(self.phoneTextField)
			make.height.equalTo(1)
			make.bottom.equalTo(self.phoneTextField.snp.bottom)
		}
		
		passwordTextField = UITextField.init()
		passwordTextField.backgroundColor = .clear
		passwordTextField.placeholder = "请输入密码"
		passwordTextField.textAlignment = .center
		passwordTextField.font = HZFont(fontSize: 15)
		passwordTextField.textColor = UIColor.black
		passwordTextField.isSecureTextEntry = true
		passwordTextField.clearButtonMode = .whileEditing
		self.contentView.addSubview(passwordTextField)
		passwordTextField.snp.makeConstraints { (make) in
			make.leading.equalTo(30)
			make.trailing.equalTo(-30)
			make.height.equalTo(50)
			make.top.equalTo(self.phoneTextField.snp.bottom).offset(20)
		}
		
		let passwordLineView = UIView.init()
		passwordLineView.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
		self.contentView.addSubview(passwordLineView)
		passwordLineView.snp.makeConstraints { (make) in
			make.leading.trailing.equalTo(self.passwordTextField)
			make.height.equalTo(1)
			make.bottom.equalTo(self.passwordTextField.snp.bottom)
		}
		
		self.loginBtn = UIButton.init(type: .custom)
		self.loginBtn.setBackgroundImage(HZImageWithColor(color: UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)), for: .disabled)
		self.loginBtn.setBackgroundImage(HZImageWithColor(color: UIColor.init(red: 0.78, green: 0.06, blue: 0.17, alpha: 1)), for: .normal)
		self.loginBtn.setTitleColor(.white, for: .normal)
		self.loginBtn.setTitle("登录", for: .normal)
		self.loginBtn.layer.cornerRadius = 5
		self.loginBtn.isEnabled = false
		self.loginBtn.tag = HZLoginCellBtnTag.login.rawValue
		self.loginBtn.layer.masksToBounds = true
		self.loginBtn.addTarget(self, action: #selector(clickLoginCellBtn(_ :)), for: .touchUpInside)
		self.contentView.addSubview(self.loginBtn)
		self.loginBtn.snp.makeConstraints { (make) in
			make.leading.equalTo(15)
			make.trailing.equalTo(-10)
			make.height.equalTo(45)
			make.top.equalTo(self.passwordTextField.snp.bottom).offset(30)
		}
		
		self.registerBtn = UIButton.init(type: .custom)
		self.registerBtn.backgroundColor = .clear
		self.registerBtn.setTitle("注册账号", for: .normal)
		self.registerBtn.titleLabel?.font = HZFont(fontSize: 13)
		self.registerBtn.contentHorizontalAlignment = .left
		self.registerBtn.tag = HZLoginCellBtnTag.register.rawValue
		self.registerBtn.setTitleColor(UIColor.init(red: 0.33, green: 0.33, blue: 0.33, alpha: 1), for: .normal)
		self.registerBtn.addTarget(self, action: #selector(clickLoginCellBtn(_ :)), for: .touchUpInside)
		self.contentView.addSubview(self.registerBtn)
		self.registerBtn.snp.makeConstraints { (make) in
			make.leading.equalTo(self.loginBtn.snp.leading).offset(15)
			make.top.equalTo(self.loginBtn.snp.bottom).offset(10)
			make.height.equalTo(30)
		}
		
		self.forgetPasswordBtn = UIButton.init(type: .custom)
		self.forgetPasswordBtn.backgroundColor = .clear
		self.forgetPasswordBtn.setTitle("忘记密码", for: .normal)
		self.forgetPasswordBtn.titleLabel?.font = HZFont(fontSize: 13)
		self.forgetPasswordBtn.contentHorizontalAlignment = .right
		self.forgetPasswordBtn.tag = HZLoginCellBtnTag.forget.rawValue
		self.forgetPasswordBtn.setTitleColor(UIColor.init(red: 0.33, green: 0.33, blue: 0.33, alpha: 1), for: .normal)
		self.forgetPasswordBtn.addTarget(self, action: #selector(clickLoginCellBtn(_ :)), for: .touchUpInside)
		self.contentView.addSubview(self.forgetPasswordBtn)
		self.forgetPasswordBtn.snp.makeConstraints { (make) in
			make.trailing.equalTo(self.loginBtn.snp.trailing).offset(-15)
			make.top.equalTo(self.registerBtn)
			make.height.equalTo(30)
		}
	}
	
	@objc func clickLoginCellBtn(_ sender: UIButton) -> Void {
		if self.clickLoginCellBtnBlock != nil {
			self.clickLoginCellBtnBlock!(sender)
		}
	}
	
	func createRACSignal() -> Void {
		let userNameValid :Observable<Bool> = self.phoneTextField.rx.text.orEmpty.map { (value) -> Bool in
			return value.count > 1
		}.share(replay: 1, scope: .whileConnected)
		
		let passwordInvalid :Observable<Bool> = self.passwordTextField.rx.text.orEmpty.map { (value) -> Bool in
			return value.count > 5
		}.share(replay: 1, scope: .whileConnected)
		
		Observable.combineLatest(userNameValid, passwordInvalid).map { (value: (Bool, Bool)) -> Bool in
			return value.0 && value.1
		}.share(replay: 1, scope: .whileConnected).bind(to: self.loginBtn.rx.isEnabled).disposed(by: disposeBag)
	}
}
