//
//  HZMyHomepageTableViewCell.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/17.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZMyHomepageTableViewCell: UITableViewCell {
	var bgView: UIView!
	var titleLabel: UILabel!
	var contentLabel: UILabel!
	var contentIamgeView: UIImageView!
	var iconImageView: UIImageView!
	var userNameLabel: UILabel!
	var messageTypeLabel:UILabel!
	var messageTimeLabel: UILabel!
	var readCountLabel: UILabel!
	var messageStatusLabel: UILabel!
	var removeBtn: UIButton!
	var disposeBag: DisposeBag! = DisposeBag.init()
	
	typealias HZRemoveMessageBlock = (_ messageId: String?) -> Void
	var removeMessageBlock: HZRemoveMessageBlock?

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.viewsLayout()
	}
	
	func viewsLayout() -> Void {
		self.backgroundColor = .clear
		self.bgView = UIView.init()
		self.bgView.backgroundColor = .clear
		self.contentView.addSubview(self.bgView)
		self.bgView.snp.makeConstraints { (make) in
			make.top.leading.equalTo(5)
			make.bottom.lessThanOrEqualTo(-5).priority(900)
			make.trailing.equalTo(-5)
		}
		
		self.titleLabel = UILabel.init()
		self.titleLabel.textColor = .black
		self.titleLabel.text = "我是程序员G"
		self.titleLabel.font = HZFont(fontSize: 18)
		self.bgView.addSubview(self.titleLabel)
		self.titleLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.bgView.snp.leading).offset(15)
			make.top.equalTo(12)
			make.trailing.equalTo(self.bgView.snp.trailing).offset(-15)
		}
		
		self.contentLabel = UILabel.init()
		self.contentLabel.textColor = UIColorWith24Hex(rgbValue: 0x444444)
		self.contentLabel.font = HZFont(fontSize: 18)
		self.contentLabel.numberOfLines = 1
		self.contentLabel.text = "sadfasdfasdflakfjw2e3u9sdlfkjasdlfjkasdfljkasdfljkasldfjasldfjkasldfjasldfjkasl;dfjalskfjas;ldfjk"
		self.bgView.addSubview(self.contentLabel)
		self.contentLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.titleLabel)
			make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
			make.trailing.equalTo(self.bgView.snp.trailing).offset(-15)
		}
		
		contentIamgeView = UIImageView.init(image: UIImage.init(named: ""))
		self.bgView.addSubview(self.contentIamgeView)
		self.contentIamgeView.snp.makeConstraints { (make) in
			make.leading.equalTo(self.titleLabel)
			make.size.equalTo(CGSize.init(width: 80, height: 80))
			make.top.equalTo(self.contentLabel.snp.bottom).offset(13.5)
		}
		
		iconImageView = UIImageView.init(image: UIImage.init(named: "avatar_default"))
		iconImageView.layer.cornerRadius = 15
		iconImageView.layer.masksToBounds = true
		self.bgView.addSubview(self.iconImageView)
		self.iconImageView.snp.makeConstraints { (make) in
			make.leading.equalTo(self.titleLabel)
			make.size.equalTo(CGSize.init(width: 30, height: 30))
			make.top.equalTo(self.contentIamgeView.snp.bottom).offset(10)
			make.bottom.equalTo(self.bgView.snp.bottom).offset(-8)
		}
		
		userNameLabel = UILabel.init()
		userNameLabel.textColor = UIColorWith24Hex(rgbValue: 0x666666)
		userNameLabel.font = HZFont(fontSize: 13)
		userNameLabel.text = "彪悍的人生不需要解释"
		self.bgView.addSubview(userNameLabel)
		userNameLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.iconImageView.snp.trailing).offset(8)
			make.centerY.equalTo(self.iconImageView.snp.centerY).offset(-10)
			make.width.lessThanOrEqualTo(150)
		}
		
		
		self.messageTimeLabel = UILabel.init()
		messageTimeLabel.textColor = UIColorWith24Hex(rgbValue: 0x666666)
		messageTimeLabel.font = HZFont(fontSize: 13)
		messageTimeLabel.text = "2020-09-15"
		self.bgView.addSubview(messageTimeLabel)
		messageTimeLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.userNameLabel.snp.leading)
			make.top.equalTo(self.userNameLabel.snp.bottom).offset(8)
		}
		
		self.readCountLabel = UILabel.init()
		readCountLabel.textColor = UIColorWith24Hex(rgbValue: 0x666666)
		readCountLabel.font = HZFont(fontSize: 13)
		readCountLabel.text = "阅读0"
		self.bgView.addSubview(readCountLabel)
		readCountLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.messageTimeLabel.snp.trailing).offset(30)
			make.centerY.equalTo(self.messageTimeLabel.snp.centerY)
		}
		
		self.messageStatusLabel = UILabel.init()
		self.messageStatusLabel.layer.cornerRadius = 6
		self.messageStatusLabel.layer.masksToBounds = true
		self.messageStatusLabel.textColor = .white
		self.messageStatusLabel.text = "审核中"
		self.messageStatusLabel.font = HZFont(fontSize: 13)
		self.messageStatusLabel.backgroundColor = UIColorWith24Hex(rgbValue: 0xFF4500)
		self.bgView.addSubview(self.messageStatusLabel)
		self.messageStatusLabel.snp.makeConstraints { (make) in
			make.trailing.equalTo(self.bgView.snp.trailing).offset(-20)
			make.centerY.equalTo(self.messageTimeLabel.snp.centerY)
			make.height.equalTo(16)
		}
		
		self.removeBtn = UIButton.init()
		self.removeBtn.backgroundColor = .clear
		self.removeBtn.isHidden = true
		self.removeBtn.setImage(UIImage.init(named: "delete_allshare"), for: .normal)
		self.removeBtn.rx.tap.subscribe(onNext: { [weak self] () in
			guard let weakself = self else {
				return
			}
			//删除
			weakself.removeMessageBlock?("123")
		}).disposed(by: disposeBag)
		self.bgView.addSubview(self.removeBtn)
		self.removeBtn.snp.makeConstraints { (make) in
			make.trailing.equalTo(self.bgView.snp.trailing).offset(-15)
			make.centerY.equalTo(self.messageTimeLabel.snp.centerY)
			make.size.equalTo(CGSize.init(width: 35, height: 30))
		}
		
	
		self.messageTypeLabel = UILabel.init()
		self.messageTypeLabel.layer.cornerRadius = 6
		self.messageTypeLabel.layer.masksToBounds = true
		self.messageTypeLabel.textColor = .white
		self.messageTypeLabel.text = "求职招聘"
		self.messageTypeLabel.backgroundColor = UIColorWith24Hex(rgbValue: 0xF87107)
		self.messageTypeLabel.font = HZFont(fontSize: 13)
		self.bgView.addSubview(self.messageTypeLabel)
		self.messageTypeLabel.snp.makeConstraints { (make) in
			make.centerY.equalTo(self.userNameLabel.snp.centerY)
			make.centerX.equalTo(self.messageStatusLabel.snp.centerX)
		}
	}
}
