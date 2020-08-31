//
//  HZImage.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/17.
//  Copyright © 2020 Galanz. All rights reserved.
//

import Foundation
import UIKit

func HZImageWithColor(color: UIColor) -> UIImage? {
	let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
	UIGraphicsBeginImageContext(rect.size)
	let ctx = UIGraphicsGetCurrentContext()
	ctx?.setFillColor(color.cgColor)
	ctx?.fill(rect)
	let image = UIGraphicsGetImageFromCurrentImageContext()
	UIGraphicsEndImageContext()
	return image
}
