//
//  HZMyProfileTableViewCell.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/10.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZMyProfileTableViewCell: UITableViewCell {
	
	var textView: IQTextView!
	let disposeBag: DisposeBag! = DisposeBag.init()
	
	open var rx_CellTextView: BehaviorRelay<Any?>! = BehaviorRelay.init(value: nil)

    required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.viewsLayout()
		self.createRACSignal()
	}
	
	func viewsLayout() -> Void {
		self.textView = IQTextView.init()
		self.textView.placeholder = "介绍自己,让更多的人认识你."
		self.textView.font = HZFont(fontSize: 15)
		//self.textView.contentInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
		self.textView.backgroundColor = .white
		self.contentView.addSubview(self.textView)
		self.textView.snp.makeConstraints { (make) in
			make.top.equalTo(0)
			make.leading.equalTo(15)
			make.trailing.equalTo(-15)
			make.bottom.lessThanOrEqualTo(0).priority(900)
			make.height.equalTo(200)
		}
	}
	
	func createRACSignal() -> Void {
		self.textView.rx.text.subscribe(onNext: { (value) in
			self.rx_CellTextView.accept(value)
		}).disposed(by: disposeBag)
	}
}
