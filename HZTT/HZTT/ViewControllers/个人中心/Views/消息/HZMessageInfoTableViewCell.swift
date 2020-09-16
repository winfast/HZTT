//
//  HZMessageInfoTableViewCell.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/16.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZMessageInfoTableViewCell: UITableViewCell {
	
	var iconImageView: UIImageView!
	var userNameLabel: UILabel!
	var messageTimeLabel: UILabel!
	var messageTypeLabel: UILabel!
	var messageContentLabel: UILabel!

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.viewsLayout()
	}
	
	func viewsLayout() -> Void {
		self.iconImageView = UIImageView.init()
		self.iconImageView.backgroundColor = .clear
		self.iconImageView.layer.cornerRadius = 20
		self.iconImageView.image = UIImage.init(named: "avatar_default")
		self.iconImageView.layer.masksToBounds = true
		self.contentView.addSubview(self.iconImageView)
		self.iconImageView.snp.makeConstraints { (make) in
			make.top.equalTo(10)
			make.leading.equalTo(15)
			make.size.equalTo(CGSize.init(width: 40, height: 40))
		}
		
		self.userNameLabel = UILabel.init()
		self.userNameLabel.textColor = .black
		self.userNameLabel.text = "正儿八经的程序员GG"
		self.userNameLabel.font = HZFont(fontSize: 16)
		self.contentView.addSubview(self.userNameLabel)
		self.userNameLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.iconImageView.snp.trailing).offset(10)
			make.trailing.equalTo(-20)
			make.top.equalTo(self.iconImageView.snp.top)
		}
		
		self.messageTimeLabel = UILabel.init()
		self.messageTimeLabel.textColor = .lightGray
		self.messageTimeLabel.text = "2017-12-05"
		self.messageTimeLabel.font = HZFont(fontSize: 14)
		self.contentView.addSubview(self.messageTimeLabel)
		self.messageTimeLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.userNameLabel)
			make.top.equalTo(self.userNameLabel.snp.bottom).offset(10)
		}
		
		self.messageTypeLabel = UILabel.init()
		self.messageTypeLabel.textColor = .darkGray
		self.messageTypeLabel.font = HZFont(fontSize: 14)
		self.messageTypeLabel.text = "评论了你的动态"
		self.contentView.addSubview(self.messageTypeLabel)
		self.messageTypeLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.messageTimeLabel.snp.trailing).offset(5)
			make.centerY.equalTo(self.messageTimeLabel.snp.centerY)
		}
		
		self.messageContentLabel = UILabel.init()
		self.messageContentLabel.textColor = UIColorWith24Hex(rgbValue: 0x666666)
		self.messageContentLabel.font = HZFont(fontSize: 14)
		self.messageContentLabel.text = "1212121231231231231231231231313123131231231231312"
		self.contentView.addSubview(self.messageContentLabel)
		self.messageContentLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.userNameLabel)
			make.bottom.lessThanOrEqualTo(self.contentView.snp.bottom).offset(-10).priority(900)
			make.top.equalTo(self.messageTimeLabel.snp.bottom).offset(15);
			make.trailing.equalTo(self.contentView.snp.trailing).offset(-30)
		}
	}
}
