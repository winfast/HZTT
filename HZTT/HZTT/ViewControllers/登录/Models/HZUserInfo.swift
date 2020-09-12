//
//  HZUser.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/11.
//  Copyright © 2020 Galanz. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class HZUserInfo : NSObject {

	@objc open dynamic var token: String?
	open var user_id: String?  //用户ID
	open var nickName: String?
	open var role: String?
	open var praise: String?
	open var bornDate: String?
	open var avatar: String?
	open var fans: String?  //粉丝数量
	@objc open dynamic var zanCnt: String? //
	@objc open dynamic var sex: String? // 0女性  1男性
	open var name: String?
	@objc open dynamic var avatar_thumb: String?
	@objc open dynamic var notes: String?  //个人建议
	@objc open dynamic var  score: String?
	@objc open dynamic var location: String?  //地址
	@objc open dynamic var fanCnt: String?
	@objc open dynamic var age: String?
	open var status: String?
	
	@objc open dynamic var showName: String?  //UI层显示的名字
	
	//static let share = HZUserInfo()
	
	private static var userInfo: HZUserInfo?
	
	class func share() ->HZUserInfo {
		guard let instance = userInfo else {
			userInfo = HZUserInfo()
			return userInfo!
		}
		return instance
	}

	func saveUserInfo(_ currUserInfo: JSON) -> Void {
		token = currUserInfo["token"].stringValue
		user_id = currUserInfo["user_id"].stringValue
		nickName = currUserInfo["nickName"].stringValue
		role = currUserInfo["role"].stringValue
		praise = currUserInfo["praise"].stringValue
		bornDate = currUserInfo["bornDate"].stringValue
		avatar = currUserInfo["avatar"].stringValue
		fans = currUserInfo["fans"].stringValue
		zanCnt = currUserInfo["zanCnt"].stringValue
		sex = currUserInfo["sex"].stringValue
		name = currUserInfo["name"].stringValue
		avatar_thumb = currUserInfo["avatar_thumb"].stringValue
		notes = currUserInfo["notes"].stringValue
		score = currUserInfo["score"].stringValue
		location = currUserInfo["location"].stringValue
		fanCnt = currUserInfo["fanCnt"].stringValue
		age = currUserInfo["age"].stringValue
		status = currUserInfo["status"].stringValue
		
		if name != nil {
			showName = name
		} else {
			showName = nickName
		}
		
//		let userDefault = UserDefaults.standard
//		userDefault.setValue(currUserInfo.dictionaryValue, forKeyPath: "userInfo")
//		userDefault.synchronize()
	}
	
	func clearUserInfo(_ completeHandle:() -> Void) -> Void {
		
	}
	
	func updateNickName(_ currNickName: String) -> Void {
		nickName = currNickName
		showName = currNickName
	}
	
	static func isLogin() -> Bool {
		if HZUserInfo.share().token != nil {
			return true
		}
		return false
	}
}
