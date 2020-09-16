//
//  HZProtocol.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/15.
//  Copyright © 2020 Galanz. All rights reserved.
//

import Foundation

/*
1:协议定义
   提供实现的入口
   遵循协议的类型需要对其进行实现
2:协议扩展
   为入口提供默认实现
   根据入口提供额外实现
*/

//面向协议编程
//面向对象编程
protocol HZProtocol  {
	var name : String { get }
	func greet() -> String?
}

extension HZProtocol {
	
	var name: String {
		return "abc"
	}
	
	func greet() -> String? {
		return self.name
	}
}
