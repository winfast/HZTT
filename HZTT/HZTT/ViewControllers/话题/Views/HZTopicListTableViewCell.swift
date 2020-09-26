//
//  HZTopicListTableViewCell.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/25.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZTopicListTableViewCell: UITableViewCell {
	
	var bgView: UIView!
	var messageTitleLabel: UILabel!
	var messageConentLabel: UILabel!
	
	//中间三张图片 不一定有
	var firstImageView: UIImageView!
	var secondImageView: UIImageView!
	var thirdImageView: UIImageView!
	
	var userIconImageView: UIImageView!
	var userNameLabel: UILabel!
	var userTimeLabel: UILabel!
	var readCountLabel: UILabel!
	var closeBtn: UIButton!
	
	@objc dynamic var viewModel: HZHomeCellViewModel!
	
	var disposeBag: DisposeBag! = DisposeBag()
	
	typealias HZClickCloseBlock = (_ btn :UIButton?) -> Void
	open var clickCloseBlock :HZClickCloseBlock?
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.viewsLayout()
		self.createRAC()
	}
	
	func viewsLayout() -> Void {
		self.selectionStyle = .none
		
		bgView = UIView.init()
		bgView.layer.borderColor = UIColorWith24Hex(rgbValue: 0xE7E7E7).cgColor
        bgView.layer.borderWidth = 1
        bgView.layer.cornerRadius = 5
        bgView.layer.masksToBounds = true
		self.contentView.addSubview(self.bgView)
		bgView.snp.makeConstraints { (make) in
			make.top.equalTo(5)
			make.left.equalTo(10)
			make.right.equalTo(-10)
			make.bottom.lessThanOrEqualTo(-5).priority(900)
		}
		
		messageTitleLabel = UILabel.init()
		messageTitleLabel.numberOfLines = 2;
		messageTitleLabel.font = HZFont(fontSize: 18)
		messageTitleLabel.textColor = UIColor.black
		bgView.addSubview(messageTitleLabel)
		messageTitleLabel.snp.makeConstraints { (make) in
			make.left.equalTo(15)
			make.right.equalTo(-15)
			make.top.equalTo(12)
		}
		
		messageConentLabel = UILabel.init()
		messageConentLabel.numberOfLines = 3;
		messageConentLabel.font = HZFont(fontSize: 16)
		messageConentLabel.textColor = UIColor.darkGray
		bgView.addSubview(messageConentLabel)
		messageConentLabel.snp.makeConstraints { (make) in
			make.left.right.equalTo(self.messageTitleLabel)
			make.top.equalTo(self.messageTitleLabel.snp.bottom).offset(12)
		}
		
		firstImageView = UIImageView.init()
		firstImageView.isHidden = true
		firstImageView.backgroundColor = UIColor.clear
		firstImageView.contentMode = UIView.ContentMode.scaleToFill;
		bgView.addSubview(firstImageView)
		firstImageView.snp.makeConstraints { (make) in
			make.left.equalTo(self.messageTitleLabel.snp.left)
			make.top.equalTo(self.messageConentLabel.snp.bottom).offset(10)
			make.width.equalTo((HZSCreenWidth() - 2 * 2 - 15 * 2)/3.0)
			make.height.equalTo(firstImageView.snp.width);
		}
		
		secondImageView = UIImageView.init()
		secondImageView.backgroundColor = UIColor.clear
		secondImageView.contentMode = UIView.ContentMode.scaleToFill;
		bgView.addSubview(secondImageView)
		secondImageView.snp.makeConstraints { (make) in
			make.left.equalTo(self.firstImageView.snp.right).offset(2)
			make.top.equalTo(self.firstImageView.snp.top)
			make.width.equalTo(firstImageView.snp.width)
			make.height.equalTo(firstImageView.snp.height)
		}
		
		thirdImageView = UIImageView.init()
		thirdImageView.backgroundColor = UIColor.clear
		thirdImageView.contentMode = UIView.ContentMode.scaleToFill;
		bgView.addSubview(thirdImageView)
		thirdImageView.snp.makeConstraints { (make) in
			make.left.equalTo(self.secondImageView.snp.right).offset(2)
			make.top.equalTo(self.firstImageView.snp.top)
			make.width.equalTo(firstImageView.snp.width)
			make.height.equalTo(firstImageView.snp.height)
		}
		
		self.userIconImageView = UIImageView.init()
		userIconImageView.backgroundColor = UIColor.clear
		userIconImageView.contentMode = UIView.ContentMode.scaleToFill;
		userIconImageView.layer.cornerRadius = 15
		userIconImageView.layer.masksToBounds = true
		bgView.addSubview(userIconImageView)
		userIconImageView.snp.makeConstraints { (make) in
			make.left.equalTo(self.messageTitleLabel.snp.left)
			make.top.equalTo(self.firstImageView.snp.bottom).offset(8.5)
			make.width.equalTo(30)
			make.height.equalTo(30)
			make.bottom.equalTo(bgView.snp.bottom).offset(-8)
		}
		
		userNameLabel = UILabel.init()
		userNameLabel.font = HZFont(fontSize: 13)
		userNameLabel.textColor = UIColor.init(red: 0.48, green: 0.48, blue: 0.48, alpha: 1)
		bgView.addSubview(userNameLabel)
		userNameLabel.snp.makeConstraints { (make) in
			make.left.equalTo(self.userIconImageView.snp.right).offset(5)
			make.centerY.equalTo(self.userIconImageView.snp.centerY)
		}
		
		userTimeLabel = UILabel.init()
		userTimeLabel.font = HZFont(fontSize: 13)
		userTimeLabel.textColor = UIColor.init(red: 0.48, green: 0.48, blue: 0.48, alpha: 1)
		bgView.addSubview(userTimeLabel)
		userTimeLabel.snp.makeConstraints { (make) in
			make.left.equalTo(self.userNameLabel.snp.right).offset(5)
			make.centerY.equalTo(self.userIconImageView.snp.centerY)
		}
		
		readCountLabel = UILabel.init()
		readCountLabel.font = HZFont(fontSize: 13)
		readCountLabel.textColor = UIColor.init(red: 0.48, green: 0.48, blue: 0.48, alpha: 1)
		bgView.addSubview(readCountLabel)
		readCountLabel.snp.makeConstraints { (make) in
			make.left.equalTo(self.userTimeLabel.snp.right).offset(5)
			make.centerY.equalTo(self.userIconImageView.snp.centerY)
		}
		
		closeBtn = UIButton.init(type: UIButton.ButtonType.custom)
		closeBtn.backgroundColor = UIColor.clear
		closeBtn.setImage(UIImage.init(named: "dislikeicon_details"), for: UIControl.State.normal);
		bgView.addSubview(closeBtn)
		closeBtn.rx.controlEvent(UIControl.Event.touchUpInside).subscribe(onNext: { [weak self] () -> Void in
			if (self!.clickCloseBlock != nil) {
				self!.clickCloseBlock!(self?.closeBtn)
			}
		}, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
		closeBtn.snp.makeConstraints { (make) in
			make.centerY.equalTo(self.userIconImageView.snp.centerY)
			make.right.equalTo(self.bgView.snp.right).offset(-15)
			make.size.equalTo(CGSize.init(width: 30, height: 20))
		}
	}
	
	func createRAC() -> Void {
		self.rx.observeWeakly(String.self, "viewModel.content").filter { (value) -> Bool in
			if value == nil || value?.lengthOfBytes(using: .utf8) == 0 {
				return false
			}
			return true
		}.subscribe(onNext: { [weak self] (contentValue) in
			guard let strongSelf = self else {return}
			guard let ss = contentValue else {return}
			
			let cc = ss.replacingOccurrences(of: "\n", with: "&&")
			let contentJson :JSON = JSON.init(parseJSON: cc)
			let title :String = contentJson["title"].stringValue
			let content: String = contentJson["content"].stringValue
			
			strongSelf.messageTitleLabel.text = title
			strongSelf.messageConentLabel.text = content.replacingOccurrences(of: "&&", with: " ")
		}).disposed(by: disposeBag)
		
		self.rx.observeWeakly(Array<String>.self, "viewModel.images").distinctUntilChanged().subscribe(onNext: { [weak self] (value) in
			guard let strongSelf = self else {return}
			let x = value ?? []
			self?.firstImageView.isHidden = true
			self?.secondImageView.isHidden = true
			self?.thirdImageView.isHidden = true
			if x.count == 0 {
				strongSelf.userIconImageView.snp.remakeConstraints { (make) in
					make.left.equalTo(strongSelf.messageTitleLabel.snp.left)
					make.top.equalTo(strongSelf.messageConentLabel.snp.bottom).offset(13.5 + 8.5)
					make.width.equalTo(30)
					make.height.equalTo(30)
					make.bottom.equalTo(strongSelf.bgView.snp.bottom).offset(-8)
				}
			}else {
				strongSelf.userIconImageView.snp.remakeConstraints { (make) in
					make.left.equalTo(strongSelf.messageTitleLabel.snp.left)
					make.top.equalTo(strongSelf.firstImageView.snp.bottom).offset(8.5)
					make.width.equalTo(30)
					make.height.equalTo(30)
					make.bottom.equalTo(strongSelf.bgView.snp.bottom).offset(-8)
				}
				for index in 0..<x.count {
					let imagePath = x[index]
					if index == 0 {
						strongSelf.firstImageView.isHidden = false;
						strongSelf.firstImageView.kf.setImage(with: URL.init(string:imagePath))
					} else if index == 1 {
						strongSelf.secondImageView.isHidden = true;
						strongSelf.secondImageView.kf.setImage(with: URL.init(string:imagePath))
					} else if index == 2 {
						strongSelf.thirdImageView.isHidden = true;
						strongSelf.thirdImageView.kf.setImage(with: URL.init(string:imagePath))
					}
				}
			}
			strongSelf.layoutIfNeeded()
		}).disposed(by: disposeBag)
		
		self.rx.observeWeakly(String.self, "viewModel.postDate").distinctUntilChanged().map { (value) -> String in
			guard let valueItem = value else {
				return ""
			}
			
			let timeArray = valueItem.split(separator: " ")
			let firstStr = String(timeArray[0])
			return firstStr
			
			
		}.bind(to: self.userTimeLabel.rx.text).disposed(by: disposeBag)
		
		self.rx.observeWeakly(String.self, "viewModel.avatar_thumb").distinctUntilChanged().subscribe(onNext: { [weak self] (value :String?) in
			if value?.lengthOfBytes(using: .utf8) ?? 0 > 0 {
				self?.userIconImageView.kf.setImage(with: URL.init(string: value!))
			}
		}).disposed(by: disposeBag)
		
		self.rx.observeWeakly(Int.self, "viewModel.readCnt").distinctUntilChanged().map({ (value) -> String in
			if value == nil {
				return ""
			}
			
			if value == 0 {
				return ""
			}
			
			return "阅读" + "\(value!)"
		}).bind(to: self.readCountLabel.rx.text).disposed(by: disposeBag)
		
		let nickNameObserve = self.rx.observe(String.self, "viewModel.nickName").distinctUntilChanged()
		let nameObserve = self.rx.observe(String.self, "viewModel.name").distinctUntilChanged()
		Observable.combineLatest(nickNameObserve, nameObserve).subscribe(onNext: { [weak self] value in
			guard let strongSelf = self else {return}
			let nickName = value.0;
			let name = value.1
			if name?.lengthOfBytes(using: .utf8) == 0 {
				strongSelf.userNameLabel.text = nickName
			} else {
				strongSelf.userNameLabel.text = name
			}
			
		}).disposed(by: disposeBag)
		
	}
}
