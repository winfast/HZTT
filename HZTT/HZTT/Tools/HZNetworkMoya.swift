//
//  HZNetworkMoya.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/18.
//  Copyright © 2020 Galanz. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Moya
import Alamofire
import SwiftyJSON

enum HZHomeNetworkMoya {
	case getPostList(_ param: [String:Any])
	case detail(_ param: [String:Any])
	case comment(_ param: [String:Any])
	case publish(_ param: [String:Any])
	case login(_ param: [String:Any])
	case updateProfileUrl(_ param: [String:Any])
}

extension HZHomeNetworkMoya: TargetType {
	
	var task: Task {
		var parammter: [String:Any] = [:]
		switch self {
		case let .getPostList(param):
			parammter = param
		case let .detail(param):
			parammter = param
		case let .comment(param):
			parammter = param
		case let .login(param):
			parammter = param
		case let .updateProfileUrl(param):
			parammter = param
		default:
			parammter = [:]
		}
		//添加常量
		if HZUserInfo.isLogin() {
			parammter.updateValue(HZUserInfo.share().token!, forKey: "t")
			parammter.updateValue(HZUserInfo.share().user_id!, forKey: "uid")
		}
		return .requestParameters(parameters: parammter, encoding: URLEncoding.default)
	}
	
	var headers: [String : String]? {
		//添加常量
	//	return [:]
		if HZUserInfo.isLogin() {
			return ["Authorization":HZUserInfo.share().token!]
		} else {
			return [:]
		}
		
	}
	
	var path: String {
		switch self {
		case .getPostList:
			return "getPostList.php"
		case .detail:
			return "detail.php"
		case .comment:
			return "comment.php"
		case .publish:
			return "publish.php"
		case .login:
			return "login.php"
		case .updateProfileUrl:
			return "updateProfile.php"
		default:
			return ""
		}
	}
	
	//请求方式
	var method: Moya.Method {
		switch self {
		case .getPostList, .detail, .comment, .login, .updateProfileUrl:
			return .post
		case .publish:
			return .post
		default:
			return .get
		}
	 }
	
	var sampleData: Data {
		return "{}".data(using: String.Encoding.utf8)!
	}
	
	var baseURL: URL {
		return URL(string: "http://39.106.164.101:80/tt/")!
	}
}
