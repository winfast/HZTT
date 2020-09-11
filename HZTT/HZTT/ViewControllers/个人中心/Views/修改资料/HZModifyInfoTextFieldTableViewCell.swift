//
//  HZModifyInfoTextFieldTableViewCell.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/10.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZModifyInfoTextFieldTableViewCell: UITableViewCell {
	
	open var modifyTypeLabel: UILabel!
	open var modifyResultTextField: UITextField!
	
	open var rx_CellTextField: BehaviorRelay<Any?>! = BehaviorRelay.init(value: nil)
	
	let disposeBag :DisposeBag = DisposeBag.init()
	

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.viewsLayout()
		self.createRACSingal()
	}
	
	func viewsLayout() -> Void {
		self.modifyTypeLabel = UILabel.init()
		self.modifyTypeLabel.textColor = UIColor.gray
		self.modifyTypeLabel.font = HZFont(fontSize: 15)
		self.contentView.addSubview(self.modifyTypeLabel)
		self.modifyTypeLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(30)
			make.top.equalTo(0)
			make.height.equalTo(50)
			make.bottom.lessThanOrEqualTo(0).priority(900)
		}
	
		self.modifyResultTextField = UITextField.init()
		self.modifyResultTextField.textColor = UIColor.black
		self.modifyResultTextField.font = HZFont(fontSize: 15)
		self.contentView.addSubview(self.modifyResultTextField)
		self.modifyResultTextField.snp.makeConstraints { (make) in
			make.leading.equalTo(self.modifyTypeLabel.snp.trailing).offset(20)
			make.trailing.equalTo(self.contentView.snp.trailing).offset(-50)
			make.centerY.equalTo(self.modifyTypeLabel.snp.centerY)
		}
		
		//保证左边显示全部
		self.modifyTypeLabel.setContentHuggingPriority(UILayoutPriority.required, for: NSLayoutConstraint.Axis.horizontal)
		self.modifyTypeLabel.setContentCompressionResistancePriority(UILayoutPriority.required, for: NSLayoutConstraint.Axis.horizontal)
	}
	
	func createRACSingal() -> Void {
		self.modifyResultTextField.rx.text.subscribe(onNext: { (value) in
			self.rx_CellTextField.accept(value)
		}).disposed(by: disposeBag)
	}
}

class HZModifyInfoLabelTableViewCell: UITableViewCell {
	
	open var modifyTypeLabel: UILabel!
	open var modifyResultLabel: UILabel!
	
	open var rx_CellLabel: BehaviorRelay<Any?>! = BehaviorRelay.init(value: nil)
	
	let disposeBag :DisposeBag = DisposeBag.init()
	

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.viewsLayout()
		self.createRACSingal()
	}
	
	func viewsLayout() -> Void {
		self.modifyTypeLabel = UILabel.init()
		self.modifyTypeLabel.textColor = UIColor.gray
		self.modifyTypeLabel.font = HZFont(fontSize: 15)
		self.contentView.addSubview(self.modifyTypeLabel)
		self.modifyTypeLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(30)
			make.top.equalTo(0)
			make.height.equalTo(50)
			make.bottom.lessThanOrEqualTo(0).priority(900)
		}
		
		self.modifyResultLabel = UILabel.init()
		self.modifyResultLabel.textColor = UIColor.black
		self.modifyResultLabel.font = HZFont(fontSize: 15)
		self.contentView.addSubview(self.modifyResultLabel)
		self.modifyResultLabel.snp.makeConstraints { (make) in
			make.leading.equalTo(self.modifyTypeLabel.snp.trailing).offset(20)
			make.trailing.equalTo(self.contentView.snp.trailing).offset(-50)
			make.centerY.equalTo(self.modifyTypeLabel.snp.centerY)
		}
		
		//保证左边显示全部
		self.modifyTypeLabel.setContentHuggingPriority(UILayoutPriority.required, for: NSLayoutConstraint.Axis.horizontal)
		self.modifyTypeLabel.setContentCompressionResistancePriority(UILayoutPriority.required, for: NSLayoutConstraint.Axis.horizontal)
	}
	
	func createRACSingal() -> Void {
		self.rx_CellLabel.asObservable().map { (value: Any) -> String? in
			
			switch(value) {
			case let currValue as String:
				return currValue
			case let currValue as (String, String):
				return currValue.0 + currValue.1
			default:
				return nil
			}
		}.bind(to: self.modifyResultLabel.rx.text).disposed(by: disposeBag)
	}
}




