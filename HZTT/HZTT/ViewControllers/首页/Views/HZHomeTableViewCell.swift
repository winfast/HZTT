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

class HZHomeTableViewCell: UITableViewCell {
	
	open var iconImage: UIImageView!
	open var userNameLabel: UILabel!
	open var userTimeLabel: UILabel!
	open var messageTitleLabel: UILabel!
	open var readCountLbael: UILabel!
	open var messageTypeLabel: UILabel!
	open var closeBtn: UIButton!
	
	//中间三张图片 不一定有
	open var firstImgaeView: UIImageView!
	open var secondImageView: UIImageView!
	open var thirdImgaeView: UIImageView!
	
	open var viewModel: HZHomeCellViewModel?;
	
	//自定义block 外部传   是不是需要这样定义  目前还不知道
	typealias HZClickCloseBlock = (_ btn :UIButton?) -> Void
	open var clickCloseBlock :HZClickCloseBlock?
	
	var disposeBag = DisposeBag()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		viewsLayout()
		createRAC()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func viewsLayout() -> Void {
		iconImage = UIImageView.init()
		iconImage.backgroundColor = UIColor.clear
		iconImage.layer.cornerRadius = 15;
		iconImage.layer.masksToBounds = true
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
			make.left.equalTo(self.contentView.snp.right).offset(10)
			make.top.equalTo(self.iconImage.snp.top).offset(2)
		}
		
		userTimeLabel = UILabel.init()
		userTimeLabel.textColor = UIColorWith24Hex(rgbValue: 0x999999)
		userTimeLabel.font = HZFont(fontSize: 0x999999)
		self.contentView.addSubview(userTimeLabel)
		userTimeLabel.snp.makeConstraints { (make) in
			make.left.equalTo(userNameLabel.snp.left)
			make.top.equalTo(userNameLabel.snp.bottom).offset(5);
		}
		
		messageTitleLabel = UILabel.init()
		messageTitleLabel.textColor = UIColorWith24Hex(rgbValue: 0x424242)
		messageTitleLabel.font = HZFont(fontSize: 17.0)
		messageTitleLabel.textAlignment = .center
		messageTitleLabel.numberOfLines = 3;
		self.contentView.addSubview(messageTitleLabel)
		messageTitleLabel.snp.makeConstraints { (make) in
			make.left.equalTo(self.contentView.snp.right).offset(20)
			make.top.equalTo(self.userTimeLabel.snp.top).offset(15)
			make.right.equalTo(self.contentView.snp.right).offset(-8)
		}
		
		firstImgaeView = UIImageView.init()
		firstImgaeView.backgroundColor = UIColor.clear
		firstImgaeView.contentMode = UIView.ContentMode.scaleAspectFit;
		self.contentView.addSubview(firstImgaeView)
		firstImgaeView.snp.makeConstraints { (make) in
			make.left.equalTo(self.messageTitleLabel.snp.left)
			make.top.equalTo(self.messageTitleLabel.snp.bottom).offset(10)
			make.width.equalTo((HZSCreenWidth() - 20 - 3 * 2 - 8)/3.0)
			make.height.equalTo(firstImgaeView.snp.width).multipliedBy(113/118.0);
		}
		
		secondImageView = UIImageView.init()
		secondImageView.backgroundColor = UIColor.clear
		secondImageView.contentMode = UIView.ContentMode.scaleAspectFit;
		self.contentView.addSubview(firstImgaeView)
		secondImageView.snp.makeConstraints { (make) in
			make.left.equalTo(self.firstImgaeView.snp.right).offset(3)
			make.top.equalTo(self.firstImgaeView.snp.top)
			make.width.height.equalTo(firstImgaeView)
		}
		
		thirdImgaeView = UIImageView.init()
		thirdImgaeView.backgroundColor = UIColor.clear
		thirdImgaeView.contentMode = UIView.ContentMode.scaleAspectFit;
		self.contentView.addSubview(thirdImgaeView)
		thirdImgaeView.snp.makeConstraints { (make) in
			make.left.equalTo(self.secondImageView.snp.right).offset(3)
			make.top.equalTo(self.firstImgaeView.snp.top)
			make.width.equalTo((HZSCreenWidth() - 20 - 3 * 2 - 8)/3.0)
		}
		
		readCountLbael = UILabel.init()
		readCountLbael.textColor = UIColorWith24Hex(rgbValue: 0x999999)
		readCountLbael.font = HZFont(fontSize: 12.0)
		readCountLbael.textAlignment = .center
		self.contentView.addSubview(readCountLbael)
		readCountLbael.snp.makeConstraints { (make) in
			make.left.equalTo(self.contentView.snp.right).offset(20)
			make.top.equalTo(self.firstImgaeView.snp.bottom).offset(15)
		}
		
		messageTypeLabel = UILabel.init()
		messageTypeLabel.textColor = UIColorWith24Hex(rgbValue: 0xFFFFFF)
		messageTypeLabel.font = HZFont(fontSize: 10.0)
		messageTypeLabel.textAlignment = .center
		messageTypeLabel.layer.cornerRadius = 9
		messageTypeLabel.backgroundColor = UIColorWith24Hex(rgbValue: 0xF77007)
		messageTypeLabel.layer.masksToBounds = true;
		self.contentView.addSubview(messageTypeLabel)
		messageTypeLabel.snp.makeConstraints { (make) in
			make.left.equalTo(readCountLbael.snp.right).offset(20)
			make.centerY.equalTo(self.readCountLbael.snp.centerY)
			make.height.equalTo(18)
			make.bottom.lessThanOrEqualTo(-15).priority(900)
		}
	}
	
	func createRAC() -> Void {
		self.rx.observe(String.self, "viewModel?.content").distinctUntilChanged().subscribe(onNext: { [weak self] (value) in
			self?.messageTitleLabel.text = value
		}).disposed(by: disposeBag)
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
