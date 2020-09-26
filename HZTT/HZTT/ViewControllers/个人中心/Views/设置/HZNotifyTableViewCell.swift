//
//  HZNotifyTableViewCell.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/18.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZNotifyTableViewCell: UITableViewCell {
	
	var switchBtn: UISwitch!
	var statusLabel: UILabel!
	
	var disposeBag: DisposeBag = DisposeBag.init()
	

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.viewsLayout()
	}
	
	func viewsLayout() -> Void {
		switchBtn = UISwitch.init()
		switchBtn.backgroundColor = .clear
		self.contentView.addSubview(self.switchBtn)
		switchBtn.rx.controlEvent(.valueChanged).subscribe(onNext: { () in
			
		}).disposed(by: disposeBag)
		self.switchBtn.snp.makeConstraints { (make) in
			make.centerY.equalTo(self.contentView.snp.centerY)
			make.trailing.equalTo(-20)
		}
		
		statusLabel = UILabel.init()
		statusLabel.backgroundColor = .clear
		statusLabel.textColor = .lightGray
		statusLabel.text = "已开启"
		statusLabel.font = HZFont(fontSize: 15)
		self.contentView.addSubview(statusLabel)
		statusLabel.snp.makeConstraints { (make) in
			make.trailing.equalTo(self.switchBtn.snp.leading).offset(-10)
			make.centerY.equalTo(self.switchBtn.snp.centerY)
		}
	}
	
	
}
