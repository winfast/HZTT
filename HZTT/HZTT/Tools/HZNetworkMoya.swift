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
}

extension HZHomeNetworkMoya: TargetType {
	
	var task: Task {
		var parammter: [String:Any] = [:]
		switch self {
		case let .getPostList(param):
			parammter = param
		case let .detail(param):
			parammter = param
		default:
			parammter = [:]
		}
		return .requestParameters(parameters: parammter, encoding: URLEncoding.default)
	}
	
	var headers: [String : String]? {
		return [:]
	}
	
	var path: String {
		switch self {
		case .getPostList:
			return "getPostList.php"
		case .detail:
			return "detail.php"
		default:
			return ""
		}
	}
	
	//请求方式
	var method: Moya.Method {
		switch self {
		case .getPostList,.detail:
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
