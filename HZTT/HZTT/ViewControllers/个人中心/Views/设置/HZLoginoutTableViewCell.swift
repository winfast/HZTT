//
//  HZLoginoutTableViewCell.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/12.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZLoginoutTableViewCell: UITableViewCell {
	
	open var loginoutLabel: UILabel!

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.viewsLayout()
	}
	
	func viewsLayout() -> Void {
		self.loginoutLabel = UILabel.init()
		self.loginoutLabel.backgroundColor = .clear
		self.loginoutLabel.text = "退出登录"
		self.loginoutLabel.textColor = UIColor.init(red: 0.85, green: 0.24, blue: 0.2, alpha: 1)
		self.loginoutLabel.font = HZFont(fontSize: 16)
		self.contentView.addSubview(self.loginoutLabel)
		self.loginoutLabel.snp.makeConstraints { (make) in
			make.top.equalTo(0)
			make.bottom.lessThanOrEqualTo(0).priority(900)
			make.height.equalTo(50)
			make.centerX.equalTo(self.contentView.snp.centerX)
		}
	}


}
