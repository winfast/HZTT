//
//  HZCellViewModel.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/18.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HZHomeCellViewModel: NSObject {
	
	@objc dynamic var homeModel: HZHomeModel?
	
	open var praiseCnt: Int?
	open var images: Array<String>?
	open var postDate: String?
	open var content: String?
	open var pid :String?
	open var status: Int?
	open var readCnt: Int?
	open var uid: String?
	
	var disposeBag: DisposeBag = DisposeBag()

//	open var praiseCntBehaviorRelay: BehaviorRelay<Int>?
//	open var imagesBehaviorRelay: BehaviorRelay<Array<String>>?
//	open var postDateBehaviorRelay: BehaviorRelay<String>?
//	open var contentBehaviorRelay: BehaviorRelay<String>?
//	open var pidBehaviorRelay: BehaviorRelay<String>?
//	open var statusBehaviorRelay: BehaviorRelay<Int>?
//	open var readCntBehaviorRelay: BehaviorRelay<Int>?
//	open var uidBehaviorRelay: BehaviorRelay<String>?
	
	init(model: HZHomeModel) {
		super.init()
		self.createRAC()
		self.homeModel = model
	}
	
	func createRAC() -> Void {
//		praiseCntBehaviorRelay = BehaviorRelay<Int>(value: (homeModel?.praiseCnt)!)
//		imagesBehaviorRelay  = BehaviorRelay<Array<String>>(value: (homeModel?.images)!)
//		postDateBehaviorRelay = BehaviorRelay<String>(value: (homeModel?.postDate)!)
//		contentBehaviorRelay = BehaviorRelay<String>(value: (homeModel?.content)!)
//		pidBehaviorRelay = BehaviorRelay<String>(value: (homeModel?.postDate)!)
//		statusBehaviorRelay = BehaviorRelay<Int>(value: (homeModel?.status)!)
//		readCntBehaviorRelay = BehaviorRelay<Int>(value: (homeModel?.readCnt)!)
//		uidBehaviorRelay = BehaviorRelay<String>(value: (homeModel?.uid)!)
		
		self.rx.observe(Int.self, "homeModel.praiseCnt").distinctUntilChanged().subscribe(onNext: { [weak self](value :Int?) in
			self?.praiseCnt = value
		}).disposed(by: disposeBag)
		
		self.rx.observe(Array<String>.self, "images").distinctUntilChanged().subscribe(onNext: { [weak self](value :Array<String>?) in
			self?.images = value
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "postDate").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
			self?.postDate = value
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "content").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
			self?.content = value
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "pid").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
			self?.pid = value
		}).disposed(by: disposeBag)
		
		self.rx.observe(Int.self, "status").distinctUntilChanged().subscribe(onNext: { [weak self](value :Int?) in
			self?.status = value
		}).disposed(by: disposeBag)
		
		self.rx.observe(Int.self, "readCnt").distinctUntilChanged().subscribe(onNext: { [weak self](value :Int?) in
			self?.readCnt = value
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "uid").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
			self?.uid = value
		}).disposed(by: disposeBag)
	}

}
