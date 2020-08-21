//
//  HZCommentTableViewCell.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/21.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZCommentTableViewCell: UITableViewCell {
	
	var iconImageView: UIImageView!
	var userNameLabel: UILabel!
	var commentContentLabel: UILabel!
	var commentTimeLabel: UILabel!
	var complainBtn: UIButton!
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.viewLayout()
		//self.createRAC()
	}
	
	
	func viewLayout() -> Void {
		self.iconImageView = UIImageView.init(image: UIImage.init(named: "avatar_default"))
		self.iconImageView.backgroundColor = UIColor.clear
		self.iconImageView.layer.cornerRadius = 15;
		self.iconImageView.layer.masksToBounds = true
		self.contentView.addSubview(self.iconImageView)
		self.iconImageView.snp.makeConstraints { (make) in
			make.left.equalTo(self.contentView.snp.left).offset(20)
			make.top.equalTo(self.contentView.snp.top).offset(8)
			make.height.width.equalTo(30)
		}
		
		self.userNameLabel = UILabel.init()
		self.userNameLabel.font = HZFont(fontSize: 15)
		self.userNameLabel.textColor = UIColor.darkGray
		self.contentView.addSubview(self.userNameLabel)
		self.userNameLabel.snp.makeConstraints { (make) in
			make.left.equalTo(self.iconImageView.snp.right).offset(8)
			make.top.equalTo(self.iconImageView.snp.top).offset(2)
		}
		
		self.commentContentLabel = UILabel.init()
		self.commentContentLabel.font = HZFont(fontSize: 15)
		self.commentContentLabel.numberOfLines = 0
		self.commentContentLabel.textColor = UIColor.black
		self.contentView.addSubview(self.commentContentLabel)
		self.commentContentLabel.snp.makeConstraints { (make) in
			make.left.equalTo(self.userNameLabel.snp.left)
			make.right.equalTo(self.contentView.snp.right).offset(30)
			make.top.equalTo(self.userNameLabel.snp.top).offset(8)
		}
		
		self.commentTimeLabel = UILabel.init()
		self.commentTimeLabel.font = HZFont(fontSize: 12)
		self.commentTimeLabel.numberOfLines = 0
		self.commentTimeLabel.textColor = UIColorWith24Hex(rgbValue: 0x696969)
		self.contentView.addSubview(self.commentTimeLabel)
		self.commentTimeLabel.snp.makeConstraints { (make) in
			make.left.equalTo(self.userNameLabel.snp.left)
			make.top.equalTo(self.userNameLabel.snp.top).offset(8)
			make.bottom.lessThanOrEqualTo(self.contentView.snp.bottom).offset(-8)
		}
		
		self.complainBtn = UIButton.init(type: .custom)
		self.complainBtn.backgroundColor = UIColor.clear
		self.complainBtn.setTitleColor(UIColorWith24Hex(rgbValue: 0xB8B8B8), for: .normal)
		self.complainBtn.setTitle("举报", for: .normal)
		self.contentView.addSubview(self.complainBtn)
		self.complainBtn.snp.makeConstraints { (make) in
			make.right.equalTo(self.contentView.snp.right).offset(-20);
			make.height.width.equalTo(CGSize.init(width: 50, height: 30));
			make.bottom.equalTo(self.contentView.snp.bottom)
		}
	}
	
//	func createRAC() -> Void {
//		self.rx.observe(String.self, "").distinctUntilChanged().bind(to: <#T##ObserverType...##ObserverType#>)
//	}
}
