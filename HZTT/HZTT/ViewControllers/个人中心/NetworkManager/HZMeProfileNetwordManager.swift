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
	
	func getScURL(_ param: [String:Any]) -> Observable<[Any]?> {
		return Observable<[Any]?>.create { (observable) -> Disposable in
			let task = self.provider.request(.getScUrl(param), callbackQueue: DispatchQueue.main, progress: nil) { [weak self] response in
				switch response {
				case let .success(results):
					let userInfo = self?.parseScList(results.data)
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
	
	func feedback(_ param: [String:Any]) -> Observable<Any> {
		return Observable<Any>.create { (observable) -> Disposable in
			let task = self.provider.request(.feedBack(param)) { [weak self] (response) in
				guard let weakself = self else {
					return
				}
				
				switch response {
				case let .success(results):
					//let userInfo = weakself.parseScList(results.data)
					observable.onNext("success" as! Any)
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
	
	func blackListURL(_ param: [String:Any]) -> Observable<[Any]?> {
		return Observable<[Any]?>.create { (observable) -> Disposable in
			let task = self.provider.request(.blackListUrl(param), callbackQueue: DispatchQueue.main, progress: nil) { [weak self] response in
				switch response {
				case let .success(results):
					let balckList = self?.parseBlakcList(results.data)
					observable.onNext(balckList)
					
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
	
	func parseBlakcList(_ data: Any) -> [Any]? {
		let json = JSON(data)
		let dicts :[String:Any]? = json.dictionaryObject;
		if dicts!["status"] as? Int == 200 {
			return Array.init()
		} else {
			return Array.init()
		}
	}
	
	func parseScList(_ data: Any) -> [Any]? {
		return nil
	}
	
	func swapValues<E>(_ a: inout E, _ b: inout E) {
		(a, b) = (b, a)
	}


}
