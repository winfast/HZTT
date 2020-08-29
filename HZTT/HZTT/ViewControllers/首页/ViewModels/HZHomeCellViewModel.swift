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
	
	@objc dynamic open var praiseCnt: Int = 0
	@objc dynamic open var images: Array<String>?
	@objc dynamic open var postDate: String?
	@objc dynamic open var content: String?
	@objc dynamic open var pid :String?
	@objc dynamic open var status: Int = 0
	@objc dynamic open var readCnt: Int = 0
	@objc dynamic open var uid: String?
	@objc dynamic open var sc: String?
	
	@objc dynamic open var avatar_thumb: String?
	@objc dynamic open var nickName: String?
	@objc dynamic open var name: String?
	@objc dynamic var type: String?
	@objc dynamic var fanCnt :String?
	
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
		self.homeModel = model
		self.createRAC()
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
			self?.praiseCnt = value ?? 0
		}).disposed(by: disposeBag)
		
		self.rx.observe(Array<String>.self, "homeModel.images").distinctUntilChanged().subscribe(onNext: { [weak self](value :Array<String>?) in
			self?.images = value
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "homeModel.postDate").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
			self?.postDate = value
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "homeModel.content").distinctUntilChanged().subscribe(onNext: { [weak self] (value :String?) in
			self?.content = value
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "homeModel.pid").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
			self?.pid = value
		}).disposed(by: disposeBag)
		
		self.rx.observe(Int.self, "homeModel.status").distinctUntilChanged().subscribe(onNext: { [weak self](value :Int?) in
			self?.status = value ?? 0
		}).disposed(by: disposeBag)
		
		self.rx.observe(Int.self, "homeModel.readCnt").distinctUntilChanged().subscribe(onNext: { [weak self](value :Int?) in
			self?.readCnt = value ?? 0
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "homeModel.uid").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
			self?.uid = value
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "homeModel.type").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
			self?.type = value
		}).disposed(by: disposeBag)
	
		self.rx.observe(String.self, "homeModel.user.nickName").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
			self?.nickName = value
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "homeModel.user.name").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
			self?.name = value
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "homeModel.user.avatar_thumb").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
			self?.avatar_thumb = value
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "homeModel.user.fanCnt").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
			self?.fanCnt = value
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "homeModel.sc").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
			self?.sc = value
		}).disposed(by: disposeBag)
	}

}
