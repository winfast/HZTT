//
//  HZCommentCellViewModel.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/21.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HZCommentCellViewModel: NSObject {
	
	@objc dynamic var commentModel: HZCommentModel?
	
	@objc dynamic var uid: String?
	@objc dynamic var praise: String?
	@objc dynamic var date: String?
	@objc dynamic var u_nickName: String?
	@objc dynamic var ID :String?
	@objc dynamic var content: String?
	@objc dynamic var replyCnt: String?
	@objc dynamic var u_name: String?
	@objc dynamic var postId: String?
	@objc dynamic var u_avatar: String?
	
	var disposeBag: DisposeBag = DisposeBag()
	
	init(model: HZCommentModel) {
		super.init()
		self.commentModel = model
		self.createRAC()
	}
	
	func createRAC() -> Void {
		
		self.rx.observe(String.self, "commentModel.praise").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
			self?.praise = value
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "commentModel.uid").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
				self?.uid = value
			}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "commentModel.date").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
				self?.date = value
			}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "commentModel.u_nickName").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
				self?.u_nickName = value
			}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "commentModel.ID").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
				self?.ID = value
			}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "commentModel.content").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
				self?.content = value
			}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "commentModel.replyCnt").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
				self?.replyCnt = value
			}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "commentModel.u_name").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
				self?.u_name = value
			}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "commentModel.postId").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
				self?.postId = value
			}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "commentModel.u_avatar").distinctUntilChanged().subscribe(onNext: { [weak self](value :String?) in
				self?.u_avatar = value
			}).disposed(by: disposeBag)
		
		
		

	}

}
