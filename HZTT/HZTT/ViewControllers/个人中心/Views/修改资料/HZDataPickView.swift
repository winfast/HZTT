//
//  HZDataPickView.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/10.
//  Copyright © 2020 Galanz. All rights reserved.
//  数据选择器

import UIKit

enum HZDataPickViewType: Int {
	case sex = 0
	case city = 1
}

class HZDataPickView: UIView {
	
	private var whiteView: UIView!
	private var completionHandler: ((Any) -> Void)?
	private var okBtn: UIButton!
	private var cancelBtn: UIButton!
	private var dataPickView: UIPickerView!
	private var selectedFirstRow: Int! = 0
	
	private var dataSource: Array<Any>!
	private var showType: HZDataPickViewType.RawValue! = HZDataPickViewType.sex.rawValue  {
		
		didSet {
			if self.showType == HZDataPickViewType.sex.rawValue {
				self.dataSource = [["男", "女"]]
			} else {
				guard let path = Bundle.main.path(forResource: "area", ofType: "plist") else {
					return
				}
				
				guard let arr = NSArray.init(contentsOfFile: path) else {
					return
				}
				
				self.dataSource = (arr as! Array<Any>)
			}
			self.dataPickView.reloadAllComponents()
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.viewsLayout()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	open class func showWithView(_ view :UIView? = UIApplication.shared.keyWindow, _ showType: HZDataPickViewType.RawValue, withCompletionHandler: ((Any) -> Void)? = nil ) -> HZDataPickView! {
		let dataPickerView  = HZDataPickView.init()
		dataPickerView.completionHandler = withCompletionHandler
		dataPickerView.showType = showType
		dataPickerView.backgroundColor = .clear
		view?.addSubview(dataPickerView)
		dataPickerView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}

		dataPickerView.layoutIfNeeded()
		let height: CGFloat = dataPickerView.whiteView.bounds.size.height
		dataPickerView.whiteView.transform = CGAffineTransform.init(translationX: 0, y: height);
		dataPickerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)

		UIView.animate(withDuration: 0.25, animations: {
			dataPickerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
			dataPickerView.whiteView.transform = .identity
		}, completion: nil)
		return dataPickerView
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
		
		self.dataPickView = UIPickerView.init()
		self.dataPickView.dataSource = self
		self.dataPickView.delegate = self
		whiteView.addSubview(self.dataPickView)
		self.dataPickView.snp.makeConstraints { (make) in
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
				//let selectedIndex = self.dataPickView.selectedRow(inComponent: 0)
				if self.showType == HZDataPickViewType.sex.rawValue {
					let array: Array<String> = self.dataSource[0] as! Array<String>
					self.completionHandler!(array[self.dataPickView.selectedRow(inComponent: 0)])
				} else {
					let selectedFirstComponetRow = self.dataPickView.selectedRow(inComponent: 0)
					let selectedSecondComponetRow = self.dataPickView.selectedRow(inComponent: 1)
					
					let dictItem = self.dataSource[selectedFirstComponetRow] as! Dictionary<String,Any>
					let province = dictItem["province"] as! String
					let array: Array<String> = dictItem["areas"] as! Array<String>
					let city = array[selectedSecondComponetRow]
					let selectedString = (province, city)
					self.completionHandler!(selectedString)
				}
				
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

extension HZDataPickView: UIPickerViewDelegate, UIPickerViewDataSource {
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		if self.showType == HZDataPickViewType.sex.rawValue {
			return 1
		} else {
			return 2
		}
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		if self.showType == HZDataPickViewType.sex.rawValue {
			let array = self.dataSource[component] as! Array<Any>
			return array.count
		} else {
			let dictItem = self.dataSource[self.selectedFirstRow] as! Dictionary<String,Any>
			let array: Array<String> = dictItem["areas"] as! Array<String>
			return array.count
		}
		
	}
	
	func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
		return 45
	}
	
	    ///UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		
		if self.showType == HZDataPickViewType.sex.rawValue {
			let array = self.dataSource[component] as! Array<String>
			return array[row]
		} else {
			let dictItem = self.dataSource[row] as! Dictionary<String,Any>
			if component == 0 {
				return (dictItem["province"] as! String)
			} else {
				let dictItem = self.dataSource[self.selectedFirstRow] as! Dictionary<String,Any>
				let array: Array<String> = dictItem["areas"] as! Array<String>
				return array[row]
			}
		}
    }
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		if 0 == component {
			self.selectedFirstRow = row
			pickerView.reloadComponent(1)
			pickerView.selectRow(0, inComponent: 1, animated: false)
		}
	}
}
