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

class HZMeProfileNetwordManager: NSObject {

    static let shared = HZMeProfileNetwordManager()
	private let provider = MoyaProvider<HZHomeNetworkMoya>()
	
	func updateProfileUrl(_ param: [String: Any]) -> Observable<JSON> {
		return Observable<JSON>.create { (observable) -> Disposable in
			let task = self.provider.request(.updateProfileUrl(param), callbackQueue: DispatchQueue.main, progress: nil) { [weak self] response in
				switch response {
				case let .success(results):
					let userInfo = self?.parseUpdateProfileUrl(results.data)
					observable.onNext(userInfo!)
					observable.onCompleted()
				case let .failure(error):
					observable.onError(error)
				}
			}
			return Disposables.create {
				task.cancel()
			}
		}
	}
	
	func getScURL<T>(_ param: [String:Any]) -> Observable<[T]?> {
		return Observable<[T]?>.create { (observable) -> Disposable in
			let task = self.provider.request(.getScUrl(param), callbackQueue: DispatchQueue.main, progress: nil) { [weak self] response in
				switch response {
				case let .success(results):
					let userInfo = self?.parseScList(results.data) as [T]?
					observable.onNext(userInfo)
					
					observable.onCompleted()
				case let .failure(error):
					observable.onError(error)
				}
			}
			return Disposables.create {
				task.cancel()
			}
		}
	}
	
	func parseUpdateProfileUrl(_ data: Any)->JSON? {
		//let json = JSON(data)
		let json = JSON(data)
		let dicts :[String:Any]? = json.dictionaryObject;
		if dicts!["status"] as? Int == 200 {
			return JSON.init(dicts!["body"] as Any)
		} else {
			return nil
		}
	}
	
	func parseScList<T>(_ data: Any) -> [T]? {
		return nil
	}
	
	func swapValues<E>(_ a: inout E, _ b: inout E) {
		(a, b) = (b, a)
	}


}
