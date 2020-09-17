//
//  HZLivelihoodDetailTableViewCell.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/24.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZLivelihoodDetailTableViewCell: HZHomeDetailTableViewCell {

	//不一定显示
	open var messageTypeBtn: UIButton!
	open var messageContentLabel: UILabel!
	
	override func viewsLayout() {
		super.viewsLayout()
		messageTypeBtn = UIButton.init(type: .custom)
		messageTypeBtn.backgroundColor = UIColor.init(red: 0.92, green: 0.18, blue: 0.07, alpha: 1)
		messageTypeBtn.layer.cornerRadius = 10
		messageTypeBtn.layer.masksToBounds = true
		messageTypeBtn.setTitleColor(UIColor.white, for: .normal)
		messageTypeBtn.titleLabel?.font = HZFont(fontSize: 13)
		self.contentView.addSubview(messageTypeBtn)
		messageTypeBtn.snp.makeConstraints { (make) in
			make.left.equalTo(10)
			make.top.equalTo(self.userTimeLabel.snp.bottom).offset(13 + 11)
			make.height.equalTo(20)
			make.width.equalTo(80)
		}
		
		messageTitleLabel.numberOfLines = 2;
		messageTitleLabel.font = HZBFont(fontSize: 18)
		messageTitleLabel.snp.remakeConstraints { (make) in
			make.top.equalTo(self.messageTypeBtn.snp.bottom).offset(25)
			make.left.equalTo(self.messageTypeBtn.snp.left)
			make.right.equalTo(self.contentView.snp.right).offset(-30)
		}
		
		messageContentLabel = UILabel.init()
		messageContentLabel.textColor = UIColorWith24Hex(rgbValue: 0x666666)
		messageContentLabel.numberOfLines = 0;
		messageContentLabel.font = HZFont(fontSize: 16)
		self.contentView.addSubview(messageContentLabel)
		messageContentLabel.snp.makeConstraints { (make) in
			make.top.equalTo(self.messageTitleLabel.snp.bottom).offset(20)
			make.left.equalTo(self.messageTypeBtn.snp.left)
			make.right.equalTo(self.contentView.snp.right).offset(-10)
		}
		
        self.collectionView.snp.remakeConstraints { (make) in
            make.left.equalTo(0)
			make.top.equalTo(self.messageContentLabel.snp.bottom).offset(17)
			make.width.equalTo(self.contentView.snp.width)
			make.height.equalTo(1)
        }
		
		self.layoutIfNeeded()
		
		self.collectionView.rx.observe(CGSize.self, "contentSize").distinctUntilChanged().filter({ (value) -> Bool in
			if value?.width == 0 {
				return false
			} else {
				return true
			}
		}).subscribe(onNext: { [weak self] (value) in
			guard let weakself = self else {
				return
			}
			
			if weakself.isMember(of: HZLivelihoodDetailTableViewCell.self) == false {
				return
			}

			weakself.collectionView.snp.remakeConstraints { (make) in
				make.left.equalTo(0)
				make.top.equalTo(weakself.messageContentLabel.snp.bottom).offset(10)
				make.width.equalTo(weakself.contentView.snp.width)
				make.height.equalTo(value!.height + 1)
			}
			weakself.layoutIfNeeded()
		}).disposed(by: disposeBag)
	}
	
	override func createRAC() {
		
		let contentObserve = self.rx.observe(String.self, "viewModel.content").distinctUntilChanged()
		let typeObserve = self.rx.observe(String.self, "viewModel.type").distinctUntilChanged()
		Observable.combineLatest(contentObserve, typeObserve).subscribe(onNext: { [weak self] value in
			guard let strongSelf = self else {return}
			guard let content = value.0 else {return}
			guard let type = value.1 else {return}
			let cc = content.replacingOccurrences(of: "\n", with: "&&")
			let contentJson :JSON = JSON.init(parseJSON: cc)
			let title :String = contentJson["title"].stringValue
			let contentValue: String = contentJson["content"].stringValue
			let typeValue: String = contentJson["type"].stringValue
		
			strongSelf.messageTitleLabel.text = "\"" + title + "\""
			strongSelf.messageContentLabel.text = contentValue.replacingOccurrences(of: "&&", with: "\n")
			var subType: String?
			switch type {
			case "21":
				subType = typeValue == "0" ? "找工作" : "招聘"
			case "24":
				subType = typeValue == "0" ? "我是房主" : "我要找房"
			case "25":
				subType = typeValue == "0" ? "我是车主" : "我要打车"
			case "23":
				subType = typeValue == "0" ? "我是男生" : "我是女生"
			default:
				subType = nil
			}
			if subType == nil {
				strongSelf.messageTypeBtn.isHidden = true
				strongSelf.messageTypeBtn.setTitle(nil, for: .normal)
				strongSelf.messageTitleLabel.snp.remakeConstraints { (make) in
					make.left.equalTo(10)
					make.top.equalTo(strongSelf.userTimeLabel.snp.bottom).offset(13 + 15)
					make.right.equalTo(strongSelf.contentView.snp.right).offset(-30)
				}
			} else {
				strongSelf.messageTypeBtn.isHidden = false
				strongSelf.messageTypeBtn.setTitle(subType, for: .normal)
				strongSelf.messageTitleLabel.snp.remakeConstraints { (make) in
					make.left.equalTo(10)
					make.top.equalTo(strongSelf.messageTypeBtn.snp.bottom).offset(25)
					make.right.equalTo(strongSelf.contentView.snp.right).offset(-30)
				}
			}
			strongSelf.layoutIfNeeded()
			
		}).disposed(by: disposeBag)
		
//		self.rx.observe(String.self, "viewModel.content").subscribe(onNext: { (value) in
//
//		}).disposed(by: disposeBag)
		
		
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
		
//		self.rx.observe(String.self, "viewModel.content").distinctUntilChanged().filter({ (value) -> Bool in
//			return value != nil ? true: false
//		}).subscribe(onNext: { [weak self] (value) in
//			let paragraphStyle = NSMutableParagraphStyle.init()
//			paragraphStyle.lineSpacing = 5;
//			paragraphStyle.lineBreakMode = .byWordWrapping;
//			paragraphStyle.firstLineHeadIndent = 32
//			let dic: [NSAttributedString.Key:Any] = [NSAttributedString.Key.font: HZFont(fontSize: 17), NSAttributedString.Key.paragraphStyle:paragraphStyle, NSAttributedString.Key.kern: 1]
//			let attr = NSAttributedString.init(string: value!, attributes: dic)
//			self?.messageTitleLabel.attributedText = attr
//		}).disposed(by: disposeBag)
		
		self.rx.observe(Int.self, "viewModel.readCnt").distinctUntilChanged().subscribe(onNext: { [weak self] (value) in
			let x : Int = value ?? 0
			let stringValue = x > 0 ? "\(x)" : ""
			self?.readCountLbael.text = "阅读" + stringValue
		}).disposed(by: disposeBag)
		
		self.rx.observe(String.self, "viewModel.fanCnt").distinctUntilChanged().bind(to: self.upvoteBtn.rx.title(for: .normal)).disposed(by: disposeBag)
		
		self.rx.observe(Array<String>.self, "viewModel.images").distinctUntilChanged().subscribe(onNext: { [weak self] (value) in
			guard let weakself = self else {
				return
			}
			let x = value ?? []
			weakself.dataSource = x
			weakself.collectionView.reloadData()
			if x.count == 0 {
				weakself.collectionView.isHidden = true
				weakself.readCountLbael.snp.remakeConstraints { (make) in
					make.left.equalTo(weakself.messageTitleLabel.snp.left)
					make.top.equalTo(weakself.messageTitleLabel.snp.bottom).offset(15 + 20)
				}
			} else {
				
				weakself.collectionView.isHidden = false
				weakself.readCountLbael.snp.remakeConstraints { (make) in
					make.left.equalTo(weakself.messageTitleLabel.snp.left)
					make.top.equalTo(weakself.collectionView.snp.bottom).offset(20)
				}
			}
			weakself.layoutIfNeeded()
			self?.layoutIfNeeded()
		}).disposed(by: disposeBag)
	}
}
