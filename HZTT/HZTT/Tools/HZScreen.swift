//
//  HZScreen.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/18.
//  Copyright © 2020 Galanz. All rights reserved.
//

import Foundation

func HZSCreenWidth() -> CGFloat {
	return UIScreen.main.bounds.size.width;
}

func HZSCreenHeight() -> CGFloat {
	return UIScreen.main.bounds.size.height;
}

func HZStatusBarHeight() -> CGFloat {
	return UIApplication.shared.statusBarFrame.size.height
}

func HZNavBarHeight() -> CGFloat {
	return HZStatusBarHeight() + 44.0
}

func HZAdpatedWidth(x: CGFloat) -> CGFloat {
	return CGFloat(ceill(Double(x))) * (HZSCreenWidth()/375.0)
}


