//
//  HZHomeDetailNetworkManager.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/20.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Moya
import SwiftyJSON

class HZHomeDetailNetworkManager: NSObject {
	static let shared = HZHomeDetailNetworkManager()
	private let provider = MoyaProvider<HZHomeNetworkMoya>()
	
	func detail(_ param: [String: Any]) -> Observable<HZHomeCellViewModel> {
		return Observable<HZHomeCellViewModel>.create { (observable) -> Disposable in
			self.provider.request(.detail(param), callbackQueue: DispatchQueue.main, progress: nil) { [weak self] response in
				switch response {
				case let .success(result):
					let detailData = self!.parseDetait(result.data)
					if detailData?.data != nil {
						observable.onNext((detailData?.data)!)
						observable.onCompleted()
					} else {
						observable.onError((detailData?.error)!)
					}
				case let .failure(error):
					observable.onError(error)
				}
				
			}
			return Disposables.create()
		}
	}
	
	func comment(_ param: [String: Any]) -> Observable<[Any]> {
		return Observable<[Any]>.create { observable -> Disposable in
			self.provider.request(.comment(param), callbackQueue: DispatchQueue.main, progress: nil) { [weak self] response in
				switch response {
				case let .success(result):
					let detailData = self!.parseComment(result.data)
					observable.onNext(detailData!)
					observable.onCompleted()
				case let .failure(error):
					observable.onError(error)
				}
				
			}
			return Disposables.create()
		}
	}
	
	func parseComment(_ data: Any) ->[Any]! {
		let json = JSON(data)
		let dicts :[String:Any]? = json.dictionaryObject;
		return []
	}
	
	func parseDetait(_ data: Any) -> (data: HZHomeCellViewModel?, error: NSError?)! {
		let json = JSON(data)
		let dicts :[String:Any]? = json.dictionaryObject;
		let status = dicts!["status"] as! Int
		return (nil, NSError.init(domain: "数据异常", code: status, userInfo: nil))
	}
}
