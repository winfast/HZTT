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
		default:
			parammter = [:]
		}
		//添加常量
		//parammter.updateValue("ea27d51c1193b238f0c1ee9304ec5471", forKey: "t")
		//parammter.updateValue("1f431f1d98f169be4d2aaee70e14bfda", forKey: "uid")
		return .requestParameters(parameters: parammter, encoding: URLEncoding.default)
	}
	
	var headers: [String : String]? {
		//添加常量
		return [:]
		//return ["Authorization":"ea27d51c1193b238f0c1ee9304ec5471"]
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
		default:
			return ""
		}
	}
	
	//请求方式
	var method: Moya.Method {
		switch self {
		case .getPostList,.detail,.comment,.login:
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
