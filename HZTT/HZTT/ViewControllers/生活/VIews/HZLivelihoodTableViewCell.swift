//
//  HZLivelihoodTableViewCell.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/24.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZLivelihoodTableViewCell: UITableViewCell {
	
	var titleLabel: UILabel! = UILabel.init()
	var contentLabel: UILabel! = UILabel.init()
	var firstImageView: UIImageView! = UIImageView.init()
	var secondImageView: UIImageView! = UIImageView.init()
	var thirdImageView: UIImageView! = UIImageView.init()
	
	var userIconImageView: UIImageView! = UIImageView.init()
	var userNameLabel: UILabel! = UILabel.init()
	var userTimeLabel: UILabel! = UILabel.init()
	var messageTypeLabel: UILabel! = UILabel.init()
	var readCountLabel: UILabel! = UILabel.init()
	
	var closeBtn: UIButton! = UIButton.init(type: .custom)
	
	let disposeBag: DisposeBag = DisposeBag.init()
	
	//自定义block 外部传 是不是需要这样定义  目前还不知道
	typealias HZClickLivelihoodCellCloseBlock = (_ btn :UIButton?) -> Void
	open var clickCloseBlock :HZClickLivelihoodCellCloseBlock?
	
	
	@objc dynamic open var viewModel: HZHomeCellViewModel?;  //KVO监听
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.viewsLayout()
		self.createRAC()
	}
	
	func viewsLayout() -> Void {
		
		self.titleLabel.numberOfLines = 2
		self.titleLabel.textColor = UIColor.black
		self.titleLabel.font = HZFont(fontSize: 18)
		self.contentView.addSubview(self.titleLabel)
		self.titleLabel.snp.makeConstraints { (make) in
			make.left.equalTo(15 + 5)
			make.top.equalTo(self.contentView.snp.top).offset(12 + 5)
			make.right.equalTo(-15 - 5)
		}
		
		self.contentLabel.numberOfLines = 0;
		self.contentLabel.textColor = UIColor.darkGray
		self.contentLabel.numberOfLines = 3
		self.contentLabel.font = HZFont(fontSize: 16)
		self.contentView.addSubview(self.contentLabel)
		self.contentLabel.snp.makeConstraints { (make) in
			make.left.equalTo(self.titleLabel.snp.left)
			make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
			make.right.equalTo(self.titleLabel.snp.right)
		}
		
		firstImageView.isHidden = true
		firstImageView.backgroundColor = UIColor.clear
		firstImageView.contentMode = UIView.ContentMode.scaleAspectFit;
		self.contentView.addSubview(firstImageView)
		firstImageView.snp.makeConstraints { (make) in
			make.left.equalTo(self.contentLabel.snp.left)
			make.top.equalTo(self.contentLabel.snp.bottom).offset(10)
			make.width.equalTo((HZSCreenWidth() - 20 - 3 * 2 - 20)/3.0)
			make.height.equalTo(firstImageView.snp.width)
		}
		
		secondImageView.backgroundColor = UIColor.clear
		secondImageView.contentMode = UIView.ContentMode.scaleAspectFit;
		self.contentView.addSubview(secondImageView)
		secondImageView.snp.makeConstraints { (make) in
			make.left.equalTo(self.firstImageView.snp.right).offset(3)
			make.top.equalTo(self.firstImageView.snp.top)
			make.width.equalTo(firstImageView.snp.width)
			make.height.equalTo(firstImageView.snp.height)
		}
		
		thirdImageView.backgroundColor = UIColor.clear
		thirdImageView.contentMode = UIView.ContentMode.scaleAspectFit;
		self.contentView.addSubview(thirdImageView)
		thirdImageView.snp.makeConstraints { (make) in
			make.left.equalTo(self.secondImageView.snp.right).offset(3)
			make.top.equalTo(self.firstImageView.snp.top)
			make.width.equalTo(firstImageView.snp.width)
			make.height.equalTo(firstImageView.snp.height)
		}
		
		userIconImageView.backgroundColor = UIColor.clear
		userIconImageView.layer.cornerRadius = 15
		userIconImageView.image = UIImage.init(named: "avatar_default")
		userIconImageView.layer.masksToBounds = true
		self.contentView.addSubview(userIconImageView)
		userIconImageView.snp.makeConstraints { (make) in
			make.left.equalTo(self.firstImageView.snp.left).offset(3)
			make.top.equalTo(self.firstImageView.snp.bottom).offset(8)
			make.bottom.lessThanOrEqualTo(self.contentView.snp.bottom).offset(-8 - 5).priority(900)
			make.width.equalTo(30)
			make.height.equalTo(30)
		}
		
		userNameLabel.font = HZFont(fontSize: 10.0)
		userNameLabel.textColor = UIColorWith24Hex(rgbValue: 0x7A7A7A)
		self.contentView.addSubview(userNameLabel)
		userNameLabel.snp.makeConstraints { (make) in
			make.left.equalTo(self.userIconImageView.snp.right).offset(6)
			make.centerY.equalTo(self.userIconImageView.snp.centerY).offset(-8)
		}
		
		messageTypeLabel.font = HZFont(fontSize: 10.0)
		messageTypeLabel.layer.cornerRadius = 5
		messageTypeLabel.layer.masksToBounds = true
		messageTypeLabel.textColor = .white
		messageTypeLabel.backgroundColor = UIColorWith24Hex(rgbValue: 0xF77007)
		self.contentView.addSubview(messageTypeLabel)
		messageTypeLabel.snp.makeConstraints { (make) in
			make.left.equalTo(self.userNameLabel.snp.right).offset(30)
			make.centerY.equalTo(self.userNameLabel.snp.centerY)
		}
		
		userTimeLabel.font = HZFont(fontSize: 10.0)
		userTimeLabel.textColor = UIColorWith24Hex(rgbValue: 0x7A7A7A)
		self.contentView.addSubview(userTimeLabel)
		userTimeLabel.snp.makeConstraints { (make) in
			make.left.equalTo(self.userNameLabel.snp.left)
			make.top.equalTo(self.userNameLabel.snp.bottom).offset(6)
		}
		
		readCountLabel.font = HZFont(fontSize: 10.0)
		readCountLabel.layer.cornerRadius = 5
		readCountLabel.textColor = UIColorWith24Hex(rgbValue: 0x7A7A7A)
		self.contentView.addSubview(readCountLabel)
		readCountLabel.snp.makeConstraints { (make) in
			make.left.equalTo(self.userTimeLabel.snp.right).offset(20)
			make.centerY.equalTo(self.userTimeLabel.snp.centerY)
		}
		
		self.closeBtn.backgroundColor = .clear
		self.closeBtn.setImage(UIImage.init(named: "dislikeicon_details"), for: .normal)
		self.contentView.addSubview(self.closeBtn)
		self.closeBtn.rx.tap.subscribe(onNext: { [weak self] (value) in
			guard let strongself = self else {return}
			if strongself.clickCloseBlock == nil {
				return
			}
			strongself.clickCloseBlock!(strongself.closeBtn)
		}).disposed(by: disposeBag)
		self.closeBtn.snp.makeConstraints { (make) in
			make.right.equalTo(self.contentView.snp.right).offset(-20)
			make.centerY.equalTo(self.userTimeLabel.snp.centerY)
			make.size.equalTo(CGSize.init(width: 30, height: 25))
		}
	}
	
	func createRAC() -> Void {
		self.rx.observe(String.self, "viewModel.content").subscribe(onNext: { (value) in
			guard let ss = value else {return}
			let cc = ss.replacingOccurrences(of: "\n", with: "&&")
			let contentJson :JSON = JSON.init(parseJSON: cc)
			let title :String = contentJson["title"].stringValue
			let content: String = contentJson["content"].stringValue
			self.titleLabel.text = title
			self.contentLabel.text = content.replacingOccurrences(of: "&&", with: " ")
		}).disposed(by: disposeBag)
		
		self.rx.observe(Array<String>.self, "viewModel.images").distinctUntilChanged().subscribe(onNext: { [weak self] (value) in
			let x = value ?? []
			self?.firstImageView.isHidden = true
			self?.secondImageView.isHidden = true
			self?.thirdImageView.isHidden = true
			if x.count == 0 {
				self?.userIconImageView.snp.remakeConstraints { (make) in
					make.left.equalTo(self!.firstImageView.snp.left).offset(3)
					make.top.equalTo(self!.contentLabel.snp.bottom).offset(20)
					make.bottom.lessThanOrEqualTo(self!.contentView.snp.bottom).offset(-8 - 5).priority(900)
					make.width.equalTo(30)
					make.height.equalTo(30)
				}
			}else {
				self?.userIconImageView.snp.remakeConstraints { (make) in
					make.left.equalTo(self!.firstImageView.snp.left).offset(3)
					make.top.equalTo(self!.firstImageView.snp.bottom).offset(8)
					make.bottom.lessThanOrEqualTo(self!.contentView.snp.bottom).offset(-8 - 5).priority(900)
					make.width.equalTo(30)
					make.height.equalTo(30)
				}
				for index in 0..<x.count {
					let imagePath = x[index]
					if index == 0 {
						self?.firstImageView.isHidden = false;
						self?.firstImageView.kf.setImage(with: URL.init(string:imagePath))
					} else if index == 1 {
						self?.secondImageView.isHidden = false;
						self?.secondImageView.kf.setImage(with: URL.init(string:imagePath))
					} else if index == 2 {
						self?.thirdImageView.isHidden = false;
						self?.thirdImageView.kf.setImage(with: URL.init(string:imagePath))
					}
				}
			}
			self?.layoutIfNeeded()
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "viewModel.avatar_thumb").distinctUntilChanged().subscribe(onNext: { [weak self] (value :String?) in
			if value?.lengthOfBytes(using: .utf8) ?? 0 > 0 {
				self?.userIconImageView.kf.setImage(with: URL.init(string: value!))
			}
		}).disposed(by: disposeBag)
		
		let nickNameObserve = self.rx.observe(String.self, "viewModel.nickName").distinctUntilChanged()
		let nameObserve = self.rx.observe(String.self, "viewModel.name").distinctUntilChanged()
		Observable.combineLatest(nickNameObserve, nameObserve).subscribe(onNext: { [weak self] value in
			let nickName = value.0;
			let name = value.1
			if name?.lengthOfBytes(using: .utf8) == 0 {
				self?.userNameLabel.text = nickName
			} else {
				self?.userNameLabel.text = name
			}
			
		}, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "viewModel.postDate").bind(to: self.userTimeLabel.rx.text).disposed(by: disposeBag)
		self.rx.observe(Int.self, "viewModel.readCnt").map { (value) -> String in
			guard let ss = value else {return ""}
			return "阅读" + "\(ss)"
		}.bind(to: self.readCountLabel.rx.text).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "viewModel.type").map { (value) -> String in
			guard let ss = value else {return ""}
			var type = "吃喝玩乐"
			type = HZPublishTypeInfo[ss]!
			return type
		}.bind(to: self.messageTypeLabel.rx.text).disposed(by: disposeBag)
	}
}
