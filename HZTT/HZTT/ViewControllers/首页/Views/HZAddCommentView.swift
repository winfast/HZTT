//
//  HZAddCommentView.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/28.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZAddCommentView: UIView {
	var maskBgView: UIView! = UIView.init()
	var bgView :UIView! = UIView.init()
	var textView: IQTextView! = IQTextView.init()
	var sendBtn: UIButton! = UIButton.init(type: .custom)
	var sendComment: Bool! = false
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.viewsLayout()
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	@objc func keyboardWillShow(_ noti:Notification) {
		guard let info = noti.userInfo else { return }//UIKeyboardAnimationDurationUserInfoKey
		guard let rect = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else{
			return
		}
		
		self.bgView.snp.remakeConstraints { (make) in
			make.left.right.equalTo(0)
			make.height.equalTo(80)
			make.bottom.equalTo(self.maskBgView.snp.bottom).offset(-rect.size.height)
		}
		
		if self.maskBgView.backgroundColor == UIColor.black.withAlphaComponent(0.2) {
			UIView.animate(withDuration: 0.25, animations: {
				self.layoutIfNeeded()
			}) { (finish) in
				
			}
		} else {
			
			UIView.animate(withDuration: 0.25, animations: {
				self.maskBgView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
				self.layoutIfNeeded()
			}) { (finish) in
				
			}
		}
		
	}
	
	@objc func keyboardWillHide(_ noti:Notification)  {
		if self.sendComment == true {
			return
		}
		self.bgView.snp.remakeConstraints { (make) in
			make.left.right.equalTo(0)
			make.height.equalTo(80)
			make.bottom.equalTo(self.maskBgView.snp.bottom).offset(0)
		}
		UIView.animate(withDuration: 0.25, animations: {
			self.layoutIfNeeded()
		}) { (finish) in
			
		}
	}
	
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	open func show(view: UIView? = nil) -> Void {
		let showView: UIView = view ?? UIApplication.shared.keyWindow!;
		showView.addSubview(self)
		
		self.snp.remakeConstraints { (make) in
			make.edges.equalTo(0)
		}
		self.layoutIfNeeded()
		self.textView.becomeFirstResponder()
	}
	
	@objc func clickSendBtn() -> Void {
		self.sendComment = true
		self.endEditing(true)
		
		self.bgView.snp.remakeConstraints { (make) in
			make.left.right.equalTo(0)
			make.height.equalTo(80)
			make.top.equalTo(self.maskBgView.snp.bottom).offset(0)
		}
		
		UIView.animate(withDuration: 0.25, animations: {
			self.maskBgView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
			self.layoutIfNeeded()
		}) { (finish) in
			self.removeFromSuperview()
		}
	}
	
	func viewsLayout() -> Void {
		self.maskBgView = UIView.init()
		self.maskBgView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
		self.addSubview(self.maskBgView)
		self.maskBgView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
		
		self.bgView.backgroundColor = .white
		self.maskBgView.addSubview(self.bgView)
		self.bgView.snp.makeConstraints { (make) in
			make.left.right.equalTo(0)
			make.height.equalTo(80)
			make.bottom.equalTo(self.maskBgView.snp.bottom).offset(0)
		}
		
		self.sendBtn.backgroundColor = UIColor.clear
		self.sendBtn.setTitle("发布", for: .normal)
		self.sendBtn.setTitleColor(UIColor.init(red: 0.93, green: 0.32, blue: 0.32, alpha: 1), for: .normal)
		self.sendBtn.titleLabel?.font = HZFont(fontSize: 15)
		self.sendBtn.contentVerticalAlignment = .bottom
		self.sendBtn.addTarget(self, action: #selector(clickSendBtn), for: .touchUpInside)
		self.bgView.addSubview(self.sendBtn)
		self.sendBtn.snp.makeConstraints { (make) in
			make.right.top.bottom.equalTo(0)
			make.width.equalTo(80)
		}
		
		textView.placeholder = "认真评论是一种生活带胎..."
		textView.placeholderTextColor = .lightGray
		textView.layer.borderWidth = 1;
		textView.layer.borderColor = UIColor.init(red: 231/255.0, green: 231/255.0, blue: 231/255.0, alpha: 1).cgColor
		textView.font = HZFont(fontSize: 16)
		self.bgView.addSubview(textView)
		self.textView.snp.makeConstraints { (make) in
			make.left.equalTo(15)
			make.top.equalTo(5)
			make.bottom.equalTo(self.bgView.snp.bottom).offset(-5)
			make.right.equalTo(self.sendBtn.snp.left)
		}
	}
}
