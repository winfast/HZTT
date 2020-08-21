//
//  HomeNetworkManager.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/18.
//  Copyright © 2020 Galanz. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Moya
import SwiftyJSON

class HZHomeNetworkManager: NSObject {
	static let shared = HZHomeNetworkManager()
	private let provider = MoyaProvider<HZHomeNetworkMoya>()
	
	func getPostList(_ param: [String: Any]) -> Observable<[HZHomeCellViewModel]> {
		return Observable<[HZHomeCellViewModel]>.create { (observable) -> Disposable in
			self.provider.request(.getPostList(param), callbackQueue: DispatchQueue.main, progress: nil) { [weak self] response in
				switch response {
                case let .success(results):
					let news = self!.parsePostList(results.data)
					observable.onNext(news!)
                    observable.onCompleted()
                case let .failure(error):
                    observable.onError(error)
                }
			}
			return Disposables.create()
		}
	}

	func parsePostList(_ data: Any)->[HZHomeCellViewModel]? {
		//let json = JSON(data)
		let json = JSON(data)
		let dicts :[String:Any]? = json.dictionaryObject;
		if dicts!["status"] as! Int == 200 {
			var homeCellViewModelsArray :Array<HZHomeCellViewModel> = []
			if let homeArray = dicts!["body"] as? [[String:Any]] {
				for index in 0..<homeArray.count {
					let homeInfoJson = JSON(homeArray[index])
					let homeModel = HZHomeModel.homeMoldeWithJson(jsonValue: homeInfoJson)
					let homeCellViewModel = HZHomeCellViewModel.init(model: homeModel)
					homeCellViewModelsArray.append(homeCellViewModel);
				}
			}
			return homeCellViewModelsArray
		} else {
			return nil
		}
	}
}





