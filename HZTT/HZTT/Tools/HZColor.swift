//
//  HZColor.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/17.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

func UIColorWith24Hex(rgbValue: UInt) -> UIColor {
	return UIColor.init(red: CGFloat((rgbValue>>16 & 0xFF))/255.0, green: CGFloat((rgbValue>>8 & 0xFF))/255.0, blue: CGFloat((rgbValue & 0xFF))/255.0, alpha: 1.0)
}

func UIColorWithHexAndAlpha(rgbValue: UInt, alpha: CGFloat) -> UIColor {
	return UIColor.init(red: CGFloat((rgbValue>>16 & 0xFF))/255.0, green: CGFloat((rgbValue>>8 & 0xFF))/255.0, blue: CGFloat((rgbValue & 0xFF))/255.0, alpha: alpha)
}

func UIColorWith32Hex(rgbValue: UInt) -> UIColor {
	return UIColor.init(red: CGFloat((rgbValue>>24 & 0xFF))/255.0, green: CGFloat((rgbValue>>16 & 0xFF))/255.0, blue: CGFloat((rgbValue>>8 & 0xFF))/255.0, alpha: CGFloat((rgbValue & 0xFF))/255.0)
}


