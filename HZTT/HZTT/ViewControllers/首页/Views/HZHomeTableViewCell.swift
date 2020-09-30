//
//  HZHomeTableViewCell.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/18.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

class HZHomeTableViewCell: UITableViewCell {
	
	open var iconImage: UIImageView!
	open var userNameLabel: UILabel!
	open var userTimeLabel: UILabel!
	open var messageTitleLabel: UILabel!
	open var readCountLbael: UILabel!
	open var messageTypeLabel: UILabel!
	open var closeBtn: UIButton!
	
	//中间三张图片 不一定有
	open var firstImageView: UIImageView!
	open var secondImageView: UIImageView!
	open var thirdImageView: UIImageView!
	
	//自定义block 外部传 是不是需要这样定义  目前还不知道
	typealias HZClickCloseBlock = (_ btn :UIButton?) -> Void
	open var clickCloseBlock :HZClickCloseBlock?
	var disposeBag = DisposeBag()
	
	@objc dynamic open var viewModel: HZHomeCellViewModel?;  //KVO监听
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		viewsLayout()
		createRAC()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func viewsLayout() -> Void {
		self.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0);
		
		iconImage = UIImageView.init()
		iconImage.backgroundColor = UIColor.clear
		iconImage.layer.cornerRadius = 15;
		iconImage.layer.masksToBounds = true
		iconImage.image = UIImage.init(named: "avatar_default")
		self.contentView.addSubview(iconImage)
		iconImage.snp.makeConstraints({ (make) in
			make.left.equalTo(self.contentView.snp.left).offset(16)
			make.top.equalTo(10)
			make.height.width.equalTo(30)
		})
		
		closeBtn = UIButton.init(type: UIButton.ButtonType.custom)
		closeBtn.backgroundColor = UIColor.clear
		closeBtn.setImage(UIImage.init(named: "dislikeicon_details"), for: UIControl.State.normal);
		self.contentView.addSubview(closeBtn)
		closeBtn.rx.controlEvent(UIControl.Event.touchUpInside).subscribe(onNext: { [weak self] () -> Void in
			if (self!.clickCloseBlock != nil) {
				self!.clickCloseBlock!(self?.closeBtn)
			}
		}, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
		closeBtn.snp.makeConstraints { (make) in
			make.top.equalTo(self.contentView.snp.top).offset(10)
			make.right.equalTo(self.contentView.snp.right).offset(-15)
			make.size.equalTo(CGSize.init(width: 30, height: 20))
		}
		
		userNameLabel = UILabel.init()
		userNameLabel.textColor = UIColorWith24Hex(rgbValue: 0x424242)
		userNameLabel.font = HZFont(fontSize: 16.0)
		userNameLabel.textAlignment = .center
		self.contentView.addSubview(userNameLabel)
		userNameLabel.snp.makeConstraints { (make) in
			make.left.equalTo(self.iconImage.snp.right).offset(10)
			make.top.equalTo(self.iconImage.snp.top).offset(2)
		}
		
		userTimeLabel = UILabel.init()
		userTimeLabel.textColor = UIColorWith24Hex(rgbValue: 0x999999)
		userTimeLabel.font = HZFont(fontSize: 14)
		self.contentView.addSubview(userTimeLabel)
		userTimeLabel.snp.makeConstraints { (make) in
			make.left.equalTo(userNameLabel.snp.left)
			make.top.equalTo(userNameLabel.snp.bottom).offset(5);
		}
		
		messageTitleLabel = UILabel.init()
		messageTitleLabel.textColor = UIColorWith24Hex(rgbValue: 0x424242)
		messageTitleLabel.font = HZFont(fontSize: 17.0)
		messageTitleLabel.textAlignment = .left
		messageTitleLabel.numberOfLines = 3;
		self.contentView.addSubview(messageTitleLabel)
		messageTitleLabel.snp.makeConstraints { (make) in
			make.left.equalTo(self.contentView.snp.left).offset(20)
			make.top.equalTo(self.userTimeLabel.snp.bottom).offset(15)
			make.right.equalTo(self.contentView.snp.right).offset(-8)
		}
		
		firstImageView = UIImageView.init()
		firstImageView.isHidden = true
		firstImageView.backgroundColor = UIColor.clear
		firstImageView.contentMode = UIView.ContentMode.scaleAspectFit;
		self.contentView.addSubview(firstImageView)
		firstImageView.snp.makeConstraints { (make) in
			make.left.equalTo(self.messageTitleLabel.snp.left)
			make.top.equalTo(self.messageTitleLabel.snp.bottom).offset(10)
			make.width.equalTo((HZSCreenWidth() - 20 - 3 * 2 - 8)/3.0)
			make.height.equalTo(firstImageView.snp.width).multipliedBy(113/118.0);
		}
		
		secondImageView = UIImageView.init()
		secondImageView.backgroundColor = UIColor.clear
		secondImageView.contentMode = UIView.ContentMode.scaleAspectFit;
		self.contentView.addSubview(secondImageView)
		secondImageView.snp.makeConstraints { (make) in
			make.left.equalTo(self.firstImageView.snp.right).offset(3)
			make.top.equalTo(self.firstImageView.snp.top)
			make.width.equalTo(firstImageView.snp.width)
			make.height.equalTo(firstImageView.snp.height)
		}
		
		thirdImageView = UIImageView.init()
		thirdImageView.backgroundColor = UIColor.clear
		thirdImageView.contentMode = UIView.ContentMode.scaleAspectFit;
		self.contentView.addSubview(thirdImageView)
		thirdImageView.snp.makeConstraints { (make) in
			make.left.equalTo(self.secondImageView.snp.right).offset(3)
			make.top.equalTo(self.firstImageView.snp.top)
			make.width.equalTo(firstImageView.snp.width)
			make.height.equalTo(firstImageView.snp.height)
		}
		
		readCountLbael = UILabel.init()
		readCountLbael.textColor = UIColorWith24Hex(rgbValue: 0x999999)
		readCountLbael.font = HZFont(fontSize: 12.0)
		readCountLbael.textAlignment = .center
		self.contentView.addSubview(readCountLbael)
		readCountLbael.snp.makeConstraints { (make) in
			make.left.equalTo(self.messageTitleLabel.snp.left)
			make.top.equalTo(self.firstImageView.snp.bottom).offset(15)
			make.bottom.lessThanOrEqualTo(-15).priority(900)
		}
		
		messageTypeLabel = UILabel.init()
		messageTypeLabel.textColor = UIColorWith24Hex(rgbValue: 0xFFFFFF)
		messageTypeLabel.font = HZFont(fontSize: 10.0)
		messageTypeLabel.textAlignment = .center
		messageTypeLabel.layer.cornerRadius = 5
		messageTypeLabel.backgroundColor = UIColorWith24Hex(rgbValue: 0xF77007)
		messageTypeLabel.layer.masksToBounds = true;
		self.contentView.addSubview(messageTypeLabel)
		messageTypeLabel.snp.makeConstraints { (make) in
			make.left.equalTo(readCountLbael.snp.right).offset(20)
			make.centerY.equalTo(self.readCountLbael.snp.centerY)
			make.height.equalTo(18)
		}
	}
	
	func createRAC() -> Void {
		
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
		
//		Observable.combineLatest(nickNameObserve, nameObserve) { strElement, intElement in
//			//"\(strElement) \(intElement)"
//		}
//		.subscribe(onNext: { print($0 + $1) })
//		.disposed(by: disposeBag)
		
//		Observable.combineLatest(nickNameObserve, nameObserve).subscribe { [weak self] (nickName, name) in
//			let first: String = nickName ?? ""
//			let second: String =  name ?? ""
//			if second.lengthOfBytes(using: .utf8) > 0 {
//				self?.userNameLabel.text = second
//			} else {
//				self?.userNameLabel.text = first
//			}
//		}.disposed(by: disposeBag)
//
//		self.rx.observe(String.self, "viewModel.nickName").distinctUntilChanged().subscribe(onNext: { [weak self] (value) in
//			self?.userNameLabel.text = value
//		}).disposed(by: disposeBag)
		
		
		
		self.rx.observe(String.self, "viewModel.postDate").distinctUntilChanged().map { (value) -> String in
			guard let currValue = value else {
				return ""
			}
	
			let array: [Substring] = currValue.split(separator: " ")
			return String(array[0])
		}.bind(to: self.userTimeLabel.rx.text).disposed(by: disposeBag)
		
//		self.rx.observe(String.self, "viewModel.postDate").distinctUntilChanged().subscribe(onNext: { [weak self] (value) in
//			self?.userTimeLabel.text = value
//		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "viewModel.avatar_thumb").distinctUntilChanged().subscribe(onNext: { [weak self] (value :String?) in
			if value?.lengthOfBytes(using: .utf8) ?? 0 > 0 {
				self?.iconImage.kf.setImage(with: URL.init(string: value!))
			}
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "viewModel.content").distinctUntilChanged().subscribe(onNext: { [weak self] (value) in
			var ss = value ?? ""
			ss = ss.replacingOccurrences(of: "\n", with: " ")
			self?.messageTitleLabel.text = ss
		}).disposed(by: disposeBag)
		
		self.rx.observe(Int.self, "viewModel.readCnt").distinctUntilChanged().subscribe(onNext: { [weak self] (value) in
			let x : Int = value ?? 0
			let stringValue = x > 0 ? "\(x)" : ""
			self?.readCountLbael.text = "阅读" + stringValue
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "viewModel.type").distinctUntilChanged().subscribe(onNext: { [weak self] (value) in
			self?.messageTypeLabel.text = HZPublishTypeInfo[value ?? "12"]
		}).disposed(by: disposeBag)
		
		self.rx.observe(Array<String>.self, "viewModel.images").distinctUntilChanged().subscribe(onNext: { [weak self] (value) in
			let x = value ?? []
			self?.firstImageView.isHidden = true
			self?.secondImageView.isHidden = true
			self?.thirdImageView.isHidden = true
			if x.count == 0 {
				self?.readCountLbael.snp.remakeConstraints { (make) in
					make.left.equalTo(self!.messageTitleLabel.snp.left)
					make.top.equalTo(self!.messageTitleLabel.snp.bottom).offset(15)
					make.bottom.lessThanOrEqualTo(-15).priority(900)
				}
			}else {
				self?.readCountLbael.snp.remakeConstraints { (make) in
					make.left.equalTo(self!.messageTitleLabel.snp.left)
					make.top.equalTo(self!.firstImageView.snp.bottom).offset(15)
					make.bottom.lessThanOrEqualTo(-15).priority(900)
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
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
