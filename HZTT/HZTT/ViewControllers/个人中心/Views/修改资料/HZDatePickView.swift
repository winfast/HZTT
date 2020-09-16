//
//  HZDatePickView.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/10.
//  Copyright © 2020 Galanz. All rights reserved.
//  时间选择器

import UIKit

class HZDatePickView: UIView {
	
	private var whiteView: UIView!
	private var completionHandler: ((Any) -> Void)?
	private var okBtn: UIButton!
	private var cancelBtn: UIButton!
	private var datePickView: UIDatePicker!
	
	private var dataSource: Array<Any>!

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.viewsLayout()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	open class func showWithView(_ view :UIView? = UIApplication.shared.keyWindow, withCompletionHandler: ((Any) -> Void)? = nil ) -> HZDatePickView! {
		let datePickerView  = HZDatePickView.init()
		datePickerView.completionHandler = withCompletionHandler
		datePickerView.backgroundColor = .clear
		view?.addSubview(datePickerView)
		datePickerView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}

		datePickerView.layoutIfNeeded()
		let height: CGFloat = datePickerView.whiteView.bounds.size.height
		datePickerView.whiteView.transform = CGAffineTransform.init(translationX: 0, y: height);
		datePickerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)

		UIView.animate(withDuration: 0.25, animations: {
			datePickerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
			datePickerView.whiteView.transform = .identity
		}, completion: nil)
		return datePickerView
	}

	func viewsLayout() -> Void {
		let tap = UITapGestureRecognizer.init(target: self, action: #selector(clickBgView(_ :)))
		self.isUserInteractionEnabled = true
		self.addGestureRecognizer(tap)
		
		self.whiteView = UIView.init()
		self.whiteView.backgroundColor = UIColor.white
		self.addSubview(self.whiteView)
		self.whiteView.snp.makeConstraints { (make) in
			make.leading.trailing.equalTo(0);
			make.bottom.equalTo(self.snp.bottom).offset(0)
		}
		
		self.okBtn = UIButton.init(type: .custom)
		self.okBtn.backgroundColor = .clear
		self.okBtn.setTitleColor(UIColor.init(red: 0.15, green: 0.4, blue: 0.78, alpha: 1), for: .normal)
		self.okBtn.titleLabel?.font = HZFont(fontSize: 15)
		self.okBtn.addTarget(self, action: #selector(clickOKBtn(_ :)), for: .touchUpInside)
		self.okBtn.setTitle("确定", for: .normal)
		whiteView.addSubview(self.okBtn)
		self.okBtn.snp.makeConstraints { (make) in
			make.top.equalTo(0)
			make.right.equalTo(-10)
			make.height.equalTo(45)
			make.width.equalTo(60)
		}
		
		self.cancelBtn = UIButton.init(type: .custom)
		self.cancelBtn.backgroundColor = .clear
		self.cancelBtn.setTitleColor(UIColor.init(red: 0.15, green: 0.4, blue: 0.78, alpha: 1), for: .normal)
		self.cancelBtn.titleLabel?.font = HZFont(fontSize: 15)
		self.cancelBtn.addTarget(self, action: #selector(clickCancelBtn(_ :)), for: .touchUpInside)
		self.cancelBtn.setTitle("取消", for: .normal)
		whiteView.addSubview(self.cancelBtn)
		self.cancelBtn.snp.makeConstraints { (make) in
			make.top.equalTo(0)
			make.left.equalTo(10)
			make.height.equalTo(45)
			make.width.equalTo(60)
		}
		
		self.datePickView = UIDatePicker.init()
		self.datePickView.datePickerMode = .date
		let locale = Locale.init(identifier: "Chinese")
		self.datePickView.locale = locale
		self.datePickView.maximumDate = Date.init()
		
		whiteView.addSubview(self.datePickView)
		self.datePickView.snp.makeConstraints { (make) in
			make.leading.trailing.equalTo(0)
			make.height.equalTo(175)
			make.top.equalTo(self.cancelBtn.snp.bottom).offset(0)
			if HZStatusBarHeight() > 20 {
				make.bottom.equalTo(self.whiteView.snp.bottom).offset(-34)
			} else {
				make.bottom.equalTo(self.whiteView.snp.bottom)
			}
		}
	}
	
	@objc func clickBgView(_ sender: UITapGestureRecognizer) -> Void {
		self.dismiss(completion: nil)
	}
	
	@objc func clickOKBtn(_ sender: UIButton) -> Void {
		
		self.dismiss { (fishish) in
			//完成默写功能
			if self.completionHandler != nil {
				let dateFormat = DateFormatter.init()
				dateFormat.dateFormat = "yyyy-MM-dd"
				let stringValue = dateFormat.string(from: self.datePickView.date);
				self.completionHandler!(stringValue)
			}
		}
	}
	
	@objc func clickCancelBtn(_ sender: UIButton) -> Void {
		self.dismiss(completion: nil)
	}
	
	func dismiss(completion: ((Bool) -> Void)? = nil) -> Void {
		let height: CGFloat = self.whiteView.bounds.size.height
		self.whiteView.transform = .identity
		self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)

		UIView.animate(withDuration: 0.25, animations: {
			self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.0)
			self.whiteView.transform = CGAffineTransform.init(translationX: 0, y: height)
		}) { (finish) in
			self.removeFromSuperview()
			if completion != nil {
				completion!(finish)
			}
		}
	}
}
