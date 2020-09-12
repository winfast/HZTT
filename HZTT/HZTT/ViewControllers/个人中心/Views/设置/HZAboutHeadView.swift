//
//  HZAboutHeadView.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/8.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZAboutHeadView: UIView {
	
	var imageView: UIImageView! = UIImageView.init()
	var textLabel: UILabel! = UILabel.init()

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.viewsLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
		
		
	}
	
	func viewsLayout() -> Void {
		let info = Bundle.main.infoDictionary
		let iconsDict = info!["CFBundleIcons"] as! Dictionary<String,Any>
		let primaryIcon = iconsDict["CFBundlePrimaryIcon"] as! Dictionary<String,Any>
		let iconsArr = primaryIcon["CFBundleIconFiles"] as! Array<String>
		let iconLastName = iconsArr.last;
		imageView.image = UIImage.init(named: iconLastName!)
		imageView.layer.cornerRadius = 5;
		imageView.layer.masksToBounds = true
		self.addSubview(imageView)
		imageView.snp.makeConstraints { (make) in
			make.centerX.equalTo(self.snp.centerX)
			make.top.equalTo(25)
			make.size.equalTo(CGSize.init(width: 100, height: 100))
		}
		
		let version = info!["CFBundleShortVersionString"] as! String
		textLabel.text = "郸城头条" + version
		self.addSubview(self.textLabel)
		textLabel.snp.makeConstraints { (make) in
			make.centerX.equalTo(self.snp.centerX)
			make.top.equalTo(self.imageView.snp.bottom).offset(10)
		}
	}

}
