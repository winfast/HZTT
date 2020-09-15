//
//  HZFansTableViewCell.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/14.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZFansTableViewCell: UITableViewCell {
	
	var iconImageView: UIImageView!
	var userNameLabel: UILabel!
	var notesLabel: UILabel!
	var removeBtn: UIButton!
	
	typealias HZClickComplainBlock = (_ btn :UIButton?) -> Void
	open var clickComplainBlock :HZClickComplainBlock?
	
	typealias HZClickFansTableViewCellBtn = (_ btn: UIButton?) -> Void
	var clickFansTableViewCellBtn: HZClickFansTableViewCellBtn?
	
	let disposeBag :DisposeBag = DisposeBag.init()
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.viewsLayout()
	}
	
	func viewsLayout() -> Void {
		self.iconImageView = UIImageView.init()
		self.iconImageView.backgroundColor = UIColor.clear
		self.iconImageView.image = UIImage.init(named: "avatar_default")
		self.contentView.addSubview(self.iconImageView)
		self.iconImageView.snp.makeConstraints { (make) in
			make.top.equalTo(15)
			make.leading.equalTo(self.contentView.snp.leading).offset(12)
			make.size.equalTo(CGSize.init(width: 50, height: 50))
			make.bottom.lessThanOrEqualTo(self.contentView.snp.bottom).offset(-15)
		}
		
		//只有黑名单才显示, 其他的时候影藏该按钮
		self.removeBtn = UIButton.init(type: .custom)
		self.removeBtn.backgroundColor = .clear
		self.removeBtn.setTitle("移除", for: .normal)
		self.removeBtn.layer.borderWidth = 1;
		self.removeBtn.isHidden = true
		self.removeBtn.layer.borderColor = UIColor.init(red: 216 / 255.0, green: 61 / 255.0, blue: 52 / 255.0, alpha: 1).cgColor
		self.removeBtn.setTitleColor(UIColorWith24Hex(rgbValue: 0xD83D34), for: .normal)
		self.removeBtn.rx.tap
			.subscribe(onNext: { [weak self] () in
				//点击了移除
				guard let weakself = self else {
					return
				}
				weakself.clickFansTableViewCellBtn?(weakself.removeBtn)
			})
			.disposed(by: disposeBag)
		self.contentView.addSubview(self.removeBtn)
		self.removeBtn.snp.makeConstraints { (make) in
			make.trailing.equalTo(self.contentView.snp.trailingMargin).offset(0)
			make.centerY.equalTo(self.iconImageView.snp.centerY)
			make.size.equalTo(CGSize.init(width: 60, height: 40))
		}
		
		self.userNameLabel = UILabel.init()
		self.userNameLabel.textColor = .black
		self.userNameLabel.font = HZBFont(fontSize: 16)
		self.userNameLabel.textAlignment = .left
		self.contentView.addSubview(self.userNameLabel)
		self.userNameLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.iconImageView.snp.trailing).offset(8)
			make.top.equalTo(self.iconImageView.snp.top)
			make.trailing.equalTo(self.removeBtn.snp.leading).offset(-5)
		}
		
		self.notesLabel = UILabel.init()
		self.notesLabel.textColor = .darkGray
		self.notesLabel.numberOfLines = 2;
		self.notesLabel.font = HZFont(fontSize: 13)
		self.notesLabel.textAlignment = .left
		self.contentView.addSubview(self.userNameLabel)
		self.userNameLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.userNameLabel.snp.trailing)
			make.top.equalTo(self.userNameLabel.snp.bottom).offset(5)
			make.trailing.equalTo(self.userNameLabel.snp.trailing)
		}
	}
}
