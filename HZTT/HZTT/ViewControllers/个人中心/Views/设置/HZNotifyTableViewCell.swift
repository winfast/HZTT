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
	

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.viewsLayout()
	}
	
	func viewsLayout() -> Void {
		
	}
}
