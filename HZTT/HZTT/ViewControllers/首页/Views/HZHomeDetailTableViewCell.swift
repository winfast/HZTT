//
//  HZHomeDetailTableViewCell.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/20.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

class HZHomeDetailTableViewCell: UITableViewCell {
	
	open var iconImage: UIImageView!
	open var userNameLabel: UILabel!
	open var userTimeLabel: UILabel!
	open var messageTitleLabel: UILabel!

	//中间三张图片 不一定有
	open var firstImgaeView: UIImageView!
	open var secondImageView: UIImageView!
	open var thirdImgaeView: UIImageView!
	
	open var readCountLbael: UILabel!
	open var complainBtn: UIButton!
	open var upvoteBtn: UIButton!
	open var noticeLabel: UILabel!
	
	@objc dynamic open var viewModel: HZHomeCellViewModel?;  //KVO监听
	var disposeBag = DisposeBag()
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		viewsLayout()
		createRAC()
	}


	func viewsLayout() -> Void {
		self.selectionStyle = .none
		
		iconImage = UIImageView.init()
		iconImage.backgroundColor = UIColor.clear
		iconImage.layer.cornerRadius = 20;
		iconImage.layer.masksToBounds = true
		iconImage.image = UIImage.init(named: "avatar_default")
		self.contentView.addSubview(iconImage)
		iconImage.snp.makeConstraints({ (make) in
			make.left.equalTo(self.contentView.snp.left).offset(16)
			make.top.equalTo(10)
			make.height.width.equalTo(40)
		})
		
		userNameLabel = UILabel.init()
		userNameLabel.textColor = UIColorWith24Hex(rgbValue: 0x555555)
		userNameLabel.font = HZFont(fontSize: 16.0)
		userNameLabel.textAlignment = .center
		self.contentView.addSubview(userNameLabel)
		userNameLabel.snp.makeConstraints { (make) in
			make.left.equalTo(self.iconImage.snp.right).offset(10)
			make.top.equalTo(self.iconImage.snp.top).offset(2)
		}
		
		userTimeLabel = UILabel.init()
		userTimeLabel.textColor = UIColorWith24Hex(rgbValue: 0x686868)
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
		messageTitleLabel.numberOfLines = 0;
		self.contentView.addSubview(messageTitleLabel)
		messageTitleLabel.snp.makeConstraints { (make) in
			make.left.equalTo(self.contentView.snp.left).offset(20)
			make.top.equalTo(self.userTimeLabel.snp.bottom).offset(15)
			make.right.equalTo(self.contentView.snp.right).offset(-8)
		}
		
		firstImgaeView = UIImageView.init()
		firstImgaeView.isHidden = true
		firstImgaeView.backgroundColor = UIColor.clear
		firstImgaeView.contentMode = UIView.ContentMode.scaleToFill;
		self.contentView.addSubview(firstImgaeView)
		firstImgaeView.snp.makeConstraints { (make) in
			make.left.equalTo(self.contentView.snp.left).offset(10)
			make.top.equalTo(self.messageTitleLabel.snp.bottom).offset(10)
			make.width.equalTo((HZSCreenWidth() - 20 - 2 * 2)/3.0)
			make.height.equalTo(firstImgaeView.snp.width).multipliedBy(113/118.0);
		}
		
		secondImageView = UIImageView.init()
		secondImageView.backgroundColor = UIColor.clear
		secondImageView.contentMode = UIView.ContentMode.scaleToFill;
		self.contentView.addSubview(secondImageView)
		secondImageView.snp.makeConstraints { (make) in
			make.left.equalTo(self.firstImgaeView.snp.right).offset(2)
			make.top.equalTo(self.firstImgaeView.snp.top)
			make.width.equalTo(firstImgaeView.snp.width)
			make.height.equalTo(firstImgaeView.snp.height)
		}
		
		thirdImgaeView = UIImageView.init()
		thirdImgaeView.backgroundColor = UIColor.clear
		thirdImgaeView.contentMode = UIView.ContentMode.scaleToFill;
		self.contentView.addSubview(thirdImgaeView)
		thirdImgaeView.snp.makeConstraints { (make) in
			make.left.equalTo(self.secondImageView.snp.right).offset(2)
			make.top.equalTo(self.firstImgaeView.snp.top)
			make.width.equalTo(firstImgaeView.snp.width)
			make.height.equalTo(firstImgaeView.snp.height)
		}
		
		readCountLbael = UILabel.init()
		readCountLbael.textColor = UIColorWith24Hex(rgbValue: 0x999999)
		readCountLbael.font = HZFont(fontSize: 12.0)
		readCountLbael.textAlignment = .center
		self.contentView.addSubview(readCountLbael)
		readCountLbael.snp.makeConstraints { (make) in
			make.left.equalTo(self.messageTitleLabel.snp.left)
			make.top.equalTo(self.firstImgaeView.snp.bottom).offset(15)
		}
		
		upvoteBtn = UIButton.init(type: .custom)
		upvoteBtn.layer.cornerRadius = 10
		upvoteBtn.setImage(UIImage.init(named: "comment_like_icon_night"), for: .normal)
		upvoteBtn.layer.borderColor = UIColor.lightGray.cgColor
		upvoteBtn.layer.borderWidth = 0.5
		upvoteBtn.titleLabel?.font = HZFont(fontSize: 11)
		upvoteBtn.setTitleColor(UIColorWith24Hex(rgbValue: 0x696969), for: .normal)
		upvoteBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -5, bottom: 0, right: 0)
		upvoteBtn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
		upvoteBtn.backgroundColor = UIColor.clear
		self.contentView.addSubview(upvoteBtn)
		upvoteBtn.snp.makeConstraints { (make) in
			make.right.equalTo(-30);
			make.centerY.equalTo(self.readCountLbael)
			make.size.equalTo(CGSize.init(width: 60, height: 25))
		}
		
		complainBtn = UIButton.init(type: .custom)
		complainBtn.layer.cornerRadius = 10
		complainBtn.titleLabel?.font = HZFont(fontSize: 11)
		complainBtn.setTitle("举报", for: .normal)
		complainBtn.setTitleColor(UIColorWith24Hex(rgbValue: 0x696969), for: .normal)
		complainBtn.layer.borderColor = UIColor.lightGray.cgColor
		complainBtn.layer.borderWidth = 1

		complainBtn.backgroundColor = UIColor.clear
		self.contentView.addSubview(complainBtn)
		complainBtn.snp.makeConstraints { (make) in
			make.right.equalTo(upvoteBtn.snp.left).offset(-30);
			make.centerY.equalTo(self.readCountLbael)
			make.size.equalTo(upvoteBtn.snp.size)
		}
		
		noticeLabel = UILabel.init()
		noticeLabel.textColor = UIColor.lightGray
		noticeLabel.font = HZFont(fontSize: 12.0)
		noticeLabel.textAlignment = .left
		noticeLabel.numberOfLines = 2
		noticeLabel.text = "提示: 平台不对该信息承担任何责任，请自己谨慎看待。若发现虚假信息等违法行为请迅速举报。";
		self.contentView.addSubview(noticeLabel)
		noticeLabel.snp.makeConstraints { (make) in
			make.left.equalTo(self.contentView.snp.left).offset(10)
			make.right.equalTo(self.contentView.snp.right).offset(-10)
			make.top.equalTo(self.readCountLbael.snp.bottom).offset(20)
			make.bottom.lessThanOrEqualTo(-20).priority(900)
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
		
		self.rx.observe(String.self, "viewModel.postDate").distinctUntilChanged().subscribe(onNext: { [weak self] (value) in
			self?.userTimeLabel.text = value
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "viewModel.avatar_thumb").distinctUntilChanged().subscribe(onNext: { [weak self] (value :String?) in
			if value?.lengthOfBytes(using: .utf8) ?? 0 > 0 {
				self?.iconImage.kf.setImage(with: URL.init(string: value!))
			}
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "viewModel.content").distinctUntilChanged().filter({ (value) -> Bool in
			return value != nil ? true: false
		}).subscribe(onNext: { [weak self] (value) in
			let paragraphStyle = NSMutableParagraphStyle.init()
			paragraphStyle.lineSpacing = 5;
			paragraphStyle.lineBreakMode = .byWordWrapping;
			paragraphStyle.firstLineHeadIndent = 32
			let dic: [NSAttributedString.Key:Any] = [NSAttributedString.Key.font: HZFont(fontSize: 17), NSAttributedString.Key.paragraphStyle:paragraphStyle, NSAttributedString.Key.kern: 1]
			let attr = NSAttributedString.init(string: value!, attributes: dic)
			self?.messageTitleLabel.attributedText = attr
		}).disposed(by: disposeBag)
		
		self.rx.observe(Int.self, "viewModel.readCnt").distinctUntilChanged().subscribe(onNext: { [weak self] (value) in
			let x : Int = value ?? 0
			let stringValue = x > 0 ? "\(x)" : ""
			self?.readCountLbael.text = "阅读" + stringValue
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "viewModel.fanCnt").distinctUntilChanged().bind(to: self.upvoteBtn.rx.title(for: .normal)).disposed(by: disposeBag)
		
		self.rx.observe(Array<String>.self, "viewModel.images").distinctUntilChanged().subscribe(onNext: { [weak self] (value) in
			let x = value ?? []
			self?.firstImgaeView.isHidden = true
			self?.secondImageView.isHidden = true
			self?.thirdImgaeView.isHidden = true
			if x.count == 0 {
				self?.readCountLbael.snp.remakeConstraints { (make) in
					make.left.equalTo(self!.messageTitleLabel.snp.left)
					make.top.equalTo(self!.messageTitleLabel.snp.bottom).offset(15)
					make.bottom.lessThanOrEqualTo(-15).priority(900)
				}
			}else {
				self?.readCountLbael.snp.remakeConstraints { (make) in
					make.left.equalTo(self!.messageTitleLabel.snp.left)
					make.top.equalTo(self!.firstImgaeView.snp.bottom).offset(15)
					make.bottom.lessThanOrEqualTo(-15).priority(900)
				}
				for index in 0..<x.count {
					let imagePath = x[index]
					if index == 0 {
						self?.firstImgaeView.isHidden = false;
						self?.firstImgaeView.kf.setImage(with: URL.init(string:imagePath))
					} else if index == 1 {
						self?.secondImageView.isHidden = false;
						self?.secondImageView.kf.setImage(with: URL.init(string:imagePath))
					} else if index == 2 {
						self?.thirdImgaeView.isHidden = false;
						self?.thirdImgaeView.kf.setImage(with: URL.init(string:imagePath))
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
