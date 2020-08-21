//
//  HZCommentModel.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/21.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxSwift
import RxCocoa

class HZCommentModel: NSObject {
	@objc dynamic var uid: String?
	@objc dynamic var praise: String?
	@objc dynamic var date: String?
	@objc dynamic var u_nickName: String?
	@objc dynamic var ID :String?
	@objc dynamic var content: String?
	@objc dynamic var replyCnt: String?
	@objc dynamic var u_name: String?
	@objc dynamic var postId: String?
	@objc dynamic var u_avatar: String?
	
	static func commentMoldeWithJson(jsonValue: JSON) -> HZCommentModel  {
		let commentModel = HZCommentModel.init()
		commentModel.uid = jsonValue["uid"].stringValue
		commentModel.praise = jsonValue["praise"].stringValue
		commentModel.date = jsonValue["date"].stringValue
		commentModel.u_nickName = jsonValue["u_nickName"].stringValue
		commentModel.ID = jsonValue["id"].stringValue
		commentModel.content = jsonValue["content"].stringValue
		commentModel.replyCnt = jsonValue["replyCnt"].stringValue
		commentModel.u_name = jsonValue["u_name"].stringValue
		commentModel.postId = jsonValue["postId"].stringValue
		commentModel.u_avatar = jsonValue["u_avatar"].stringValue
		return commentModel
	}
}
