//
//  HZModifyHeaderIconView.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/10.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZModifyHeaderIconView: UIView {
	
	var iconImageBtn: UIButton!
	var contentLabel: UILabel!

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.viewsLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func viewsLayout() -> Void {
		self.iconImageBtn = UIButton.init()
		self.iconImageBtn.setImage(UIImage.init(named: "avatar_default"), for: .normal)
		self.addSubview(iconImageBtn)
		self.iconImageBtn.snp.makeConstraints { (make) in
			make.centerX.equalTo(self.snp.centerX)
			make.top.equalTo(20)
			make.size.equalTo(CGSize.init(width: 90, height: 90))
		}
		
		
		self.contentLabel = UILabel.init()
		self.contentLabel.font = HZFont(fontSize: 14)
		self.contentLabel.text = "点击修改头像"
		self.contentLabel.textColor = UIColor.init(white: 0.41, alpha: 1)
		self.addSubview(self.contentLabel)
		self.contentLabel.snp.makeConstraints { (make) in
			make.top.equalTo(self.iconImageBtn.snp.bottom).offset(10)
			make.centerX.equalTo(self.snp.centerX)
		}
		
	}
}
