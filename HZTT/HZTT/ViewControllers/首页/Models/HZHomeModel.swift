//
//  HZHomeModel.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/18.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxSwift
import RxCocoa

class HZUser: NSObject {
	
	var lastLaunchDate: String?
	var avatar_thumb: String?
	var avatar: String?
	var user_id: String?
	var bornDate: String?
	var fanCnt :Int?
	var name: String?
	var nickName: String?
	var status: Int?
	var ID: Int?
	var praise: Int?
	var notes: String?
	var fans: Int?
	var sex: Int?
	var last_login_time: String?
	var score: String?
	var zanCnt: String?

	static func userWithJson(jsonValue: JSON) -> HZUser {
		let userModel = HZUser.init()
		userModel.lastLaunchDate = jsonValue["lastLaunchDate"].stringValue
		userModel.avatar_thumb = jsonValue["avatar_thumb"].stringValue
		userModel.avatar = jsonValue["avatar"].stringValue
		userModel.user_id = jsonValue["user_id"].stringValue
		userModel.bornDate = jsonValue["bornDate"].stringValue
		userModel.fanCnt = jsonValue["fanCnt"].intValue
		userModel.name = jsonValue["name"].stringValue
		userModel.nickName = jsonValue["nickName"].stringValue
		userModel.status = jsonValue["status"].intValue
		userModel.ID = jsonValue["id"].intValue
		userModel.praise = jsonValue["praise"].intValue
		userModel.notes = jsonValue["notes"].stringValue
		userModel.fans = jsonValue["fans"].intValue
		userModel.sex = jsonValue["sex"].intValue
		userModel.last_login_time = jsonValue["last_login_time"].stringValue
		userModel.score = jsonValue["score"].stringValue
		userModel.zanCnt = jsonValue["zanCnt"].stringValue
		return userModel
	}
}

class HZHomeModel: NSObject {
	@objc dynamic var praiseCnt: Int = 0
	@objc dynamic var images: Array<String>?
	@objc dynamic var postDate: String?
	@objc dynamic var content: String?
	@objc dynamic var pid :String?
	@objc dynamic var status: Int = 0
	@objc dynamic var readCnt: Int = 0
	@objc dynamic var uid: String?
	@objc dynamic var user: HZUser?
	
	static func homeMoldeWithJson(jsonValue: JSON) -> HZHomeModel  {
		let homeModel = HZHomeModel.init()
		homeModel.praiseCnt = jsonValue["praiseCnt"].intValue
		let imageStr = jsonValue["images"].stringValue
		
		let imagesArray = imageStr.split(separator: ",")
//		homeModel.images = imagesArray.compactMap({ (value) -> String? in
//			return String(value)
//		})
		homeModel.images = imagesArray.compactMap { "\($0)" }
		homeModel.postDate = jsonValue["postDate"].stringValue
		homeModel.content = jsonValue["content"].stringValue
		homeModel.pid = jsonValue["pid"].stringValue
		homeModel.status = jsonValue["status"].intValue
		homeModel.readCnt = jsonValue["readCnt"].intValue
		homeModel.uid = jsonValue["uid"].stringValue
		let userJson = JSON(jsonValue["user"].dictionary as Any)
		homeModel.user = HZUser.userWithJson(jsonValue:userJson)
		return homeModel
	}
}


