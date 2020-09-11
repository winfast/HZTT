//
//  HZMyHomePageHeaderView.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/10.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZMyHomePageHeaderView: UIView {
	
	var headerImageView: UIImageView!
	var userNickName: UILabel!
	
	var sexImageView: UIImageView!
	var ageValueLabel: UILabel!
	
	var addressImageView: UIImageView!
	var addressLabel: UILabel!
	
	var profileLabel: UILabel!
	
	//收藏
	var likeLabel: UILabel!
	var likeValueLabel: UILabel!
	
	//粉丝
	var fansLabel: UILabel!
	var fansValueLabel: UILabel!

	//积分
	var pointLabel: UILabel!
	var pointValueLabel: UILabel!
	
	let disposeBag :DisposeBag = DisposeBag()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.viewsLayout()
		self.createRACSingal()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func viewsLayout() -> Void {
		self.backgroundColor = UIColor.init(red: 0.98, green: 0.98, blue: 0.99, alpha: 1)
		
		self.headerImageView = UIImageView.init()
		self.headerImageView.image = UIImage.init(named: "avatar_default")
		self.headerImageView.backgroundColor = .clear
		self.addSubview(self.headerImageView)
		self.headerImageView.snp.makeConstraints { (make) in
			make.leading.equalTo(15)
			make.top.equalTo(20)
			make.size.equalTo(CGSize.init(width: 80, height: 80))
		}
		
		self.userNickName = UILabel.init()
		self.userNickName.textColor = .black
		self.userNickName.font = HZBFont(fontSize: 18)
		self.addSubview(self.userNickName)
		self.userNickName.snp.makeConstraints { (make) in
			make.leading.equalTo(self.headerImageView.snp.trailing).offset(10)
			make.top.equalTo(self.headerImageView.snp.top).offset(45)
		}
		
		sexImageView = UIImageView.init()
		sexImageView.backgroundColor = .clear
		sexImageView.image = UIImage.init(named: "girl")
		self.addSubview(sexImageView)
		sexImageView.snp.makeConstraints { (make) in
			make.leading.equalTo(25)
			make.top.equalTo(self.headerImageView.snp.bottom).offset(8)
			make.size.equalTo(CGSize.init(width: 14, height: 14))
		}
		
		self.ageValueLabel = UILabel.init()
		self.ageValueLabel.font = HZFont(fontSize: 13)
		self.ageValueLabel.textColor = UIColor.darkGray
		self.ageValueLabel.text = "0岁"
		self.addSubview(self.ageValueLabel)
		self.ageValueLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.sexImageView.snp.trailing).offset(10)
			make.centerY.equalTo(self.sexImageView.snp.centerY)
		}
		
		self.addressImageView  = UIImageView.init()
		addressImageView.backgroundColor = .clear
		addressImageView.image = UIImage.init(named: "locationicon_repost_press")
		self.addSubview(addressImageView)
		addressImageView.snp.makeConstraints { (make) in
			make.leading.equalTo(self.sexImageView.snp.leading)
			make.top.equalTo(self.sexImageView.snp.bottom).offset(10)
			make.size.equalTo(CGSize.init(width: 14, height: 14))
		}
		
		self.addressLabel = UILabel.init()
		self.addressLabel.font = HZFont(fontSize: 13)
		self.addressLabel.textColor = UIColor.darkGray
		self.addressLabel.text = "不知"
		self.addSubview(self.addressLabel)
		self.addressLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.addressImageView.snp.trailing).offset(10)
			make.centerY.equalTo(self.addressImageView.snp.centerY)
		}
		
		self.profileLabel = UILabel.init()
		self.profileLabel.font = HZFont(fontSize: 13)
		self.profileLabel.textColor = UIColor.darkGray
		self.profileLabel.numberOfLines = 1;
		self.profileLabel.text = "签名: "
		self.addSubview(self.profileLabel)
		self.profileLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.sexImageView.snp.leading)
			make.top.equalTo(self.addressImageView.snp.bottom).offset(8)
			make.trailing.equalTo(-25).priority(900)
		}
		
		self.likeLabel = UILabel.init()
		self.likeLabel.backgroundColor = .clear
		self.likeLabel.font = HZFont(fontSize: 12)
		self.likeLabel.textColor = .darkGray
		self.likeLabel.text = "收到的赞"
		self.addSubview(self.likeLabel)
		self.likeLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.sexImageView.snp.leading)
			make.top.equalTo(self.profileLabel.snp.bottom).offset(12)
		}
		
		self.likeValueLabel = UILabel.init()
		self.likeValueLabel.backgroundColor = .clear
		self.likeValueLabel.font = HZFont(fontSize: 18)
		self.likeValueLabel.text = "0"
		self.addSubview(self.likeValueLabel)
		self.likeValueLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.likeLabel.snp.trailing).offset(5)
			make.centerY.equalTo(self.likeLabel.snp.centerY)
		}
		
		self.fansLabel = UILabel.init()
		self.fansLabel.backgroundColor = .clear
		self.fansLabel.font = HZFont(fontSize: 12)
		self.fansLabel.textColor = .darkGray
		self.fansLabel.text = "粉丝"
		self.addSubview(self.fansLabel)
		self.fansLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.likeValueLabel.snp.leading).offset(30)
			make.centerY.equalTo(self.likeLabel.snp.centerY)
		}
		
		self.fansValueLabel = UILabel.init()
		self.fansValueLabel.backgroundColor = .clear
		self.fansValueLabel.font = HZFont(fontSize: 18)
		self.fansValueLabel.text = "0"
		self.addSubview(self.fansValueLabel)
		self.fansValueLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.fansLabel.snp.trailing).offset(5)
			make.centerY.equalTo(self.likeLabel.snp.centerY)
		}
		
		self.pointLabel = UILabel.init()
		self.pointLabel.backgroundColor = .clear
		self.pointLabel.font = HZFont(fontSize: 12)
		self.pointLabel.textColor = .darkGray
		self.pointLabel.text = "积分"
		self.addSubview(self.pointLabel)
		self.pointLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.fansValueLabel.snp.leading).offset(30)
			make.centerY.equalTo(self.likeLabel.snp.centerY)
		}
		
		self.pointValueLabel = UILabel.init()
		self.pointValueLabel.backgroundColor = .clear
		self.pointValueLabel.font = HZFont(fontSize: 18)
		self.pointValueLabel.text = "0"
		self.addSubview(self.pointValueLabel)
		self.pointValueLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.pointLabel.snp.trailing).offset(5)
			make.centerY.equalTo(self.likeLabel.snp.centerY)
		}
	}
	
	func createRACSingal() -> Void {
		let userInfo = HZUserInfo.share()
		userInfo.rx.observe(String.self, "notes").filter { (value) -> Bool in
			guard let _ = value else {
				return false
			}
			return true
		}.map { (value) -> String in
			return "签名: " + value!
		}.bind(to: self.profileLabel.rx.text).disposed(by: disposeBag)
		
		userInfo.rx.observe(String.self, "age").map { (value) -> String in
			guard let currAage = value else {
				return "0"
			}
			return currAage
		}.bind(to: self.ageValueLabel.rx.text).disposed(by: disposeBag)
		
		userInfo.rx.observe(String.self, "showName").map { (value) -> String in
			guard let currShowName = value else {
				return ""
			}
			return currShowName
		}.bind(to: self.userNickName.rx.text).disposed(by: disposeBag)
		
		userInfo.rx.observe(String.self, "location").map { (value) -> String in
			guard let currLocation = value else {
				return "不知"
			}
			return currLocation
		}.bind(to: self.addressLabel.rx.text).disposed(by: disposeBag)
		
		
		userInfo.rx.observe(String.self, "sex").map { (value) -> UIImage? in
			guard let currSex = value else {
				return UIImage.init(named: "girl")
			}
			return UIImage.init(named: currSex == "0" ? "girl" : "boy")
		}.bind(to: self.sexImageView.rx.image).disposed(by: disposeBag)
		
		
		userInfo.rx.observe(String.self, "age").map { (value) -> String in
			guard let currAge = value else {
				return "0"
			}
			return currAge
		}.bind(to: self.ageValueLabel.rx.text).disposed(by: disposeBag)
	}
}
