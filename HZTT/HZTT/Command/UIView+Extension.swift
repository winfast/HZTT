//
//  UIView+Extension.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/19.
//  Copyright © 2020 Galanz. All rights reserved.
//

import Foundation

public extension UIView {
	func ex_prepareToShow() -> Void {
		self.alpha = 0.0
	}
	
	func ex_makeViewVisible() -> Void {
		if self.alpha == 1.0 {
			return
		}
		
		UIView.animate(withDuration: 0.35) {
			self.alpha = 1.0
		}
	}
}
