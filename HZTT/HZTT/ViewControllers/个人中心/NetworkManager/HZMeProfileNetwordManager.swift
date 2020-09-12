//
//  HZMeProfileNetwordManager.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/12.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Moya
import SwiftyJSON

class HZMeProfileNetwordManager: UITableViewCell {

    static let shared = HZMeProfileNetwordManager()
	private let provider = MoyaProvider<HZHomeNetworkMoya>()
	
	func updateProfileUrl(_ param: [String: Any]) -> Observable<JSON> {
		return Observable<JSON>.create { (observable) -> Disposable in
			self.provider.request(.updateProfileUrl(param), callbackQueue: DispatchQueue.main, progress: nil) { [weak self] response in
				switch response {
                case let .success(results):
					let userInfo = self?.parsePostList(results.data)
					observable.onNext(userInfo!)
					observable.onCompleted()
                case let .failure(error):
                    observable.onError(error)
                }
			}
			return Disposables.create()
		}
	}
	
	func parsePostList(_ data: Any)->JSON? {
		//let json = JSON(data)
		let json = JSON(data)
		let dicts :[String:Any]? = json.dictionaryObject;
		if dicts!["status"] as? Int == 200 {
			return JSON.init(dicts!["body"] as Any)
		} else {
			return nil
		}
	}

}
