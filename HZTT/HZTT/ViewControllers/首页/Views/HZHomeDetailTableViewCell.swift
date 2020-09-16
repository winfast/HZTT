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

/*
监听的属性需要有 dynamic 修饰符。
本样例需要使用 rx.observeWeakly，不能用 rx.observe，否则会造成循环引用，引起内存泄露。

我们对 view.frame 进行监听，当其改变时将最新值输出到控制台中。
注意：这里必须使用 rx.observe，如果使用 rx.observeWeakly 则监听不到。
*/

class HZHomeDetailTableViewCell: UITableViewCell {
	
	open var iconImage: UIImageView!
	open var userNameLabel: UILabel!
	open var userTimeLabel: UILabel!
	open var messageTitleLabel: UILabel!
	open var collectionView: UICollectionView!
	open var readCountLbael: UILabel!
	open var complainBtn: UIButton!
	open var upvoteBtn: UIButton!
	open var noticeLabel: UILabel!
	
	typealias HZClickHomeDetailCellBtnBlock = (_ btn :UIView?) -> Void
	open var clickBtnBlock :HZClickHomeDetailCellBtnBlock?
	
	var dataSource: Array<String> = Array.init()
		
	@objc dynamic open var viewModel: HZHomeCellViewModel?;  //KVO监听
	var disposeBag = DisposeBag()
	
	var disposable :Disposable!
	
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
		
		let flowerLayout = UICollectionViewFlowLayout.init()
		let width = (HZSCreenWidth() - 2*2.0 - 10*2.0)/3.0
		flowerLayout.itemSize = CGSize.init(width:width, height: width * 153.0/130.0)
        flowerLayout.minimumLineSpacing = 2
        flowerLayout.minimumInteritemSpacing = 2
        self.collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowerLayout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
		self.collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.register(HZImageViewCollectionView.classForCoder(), forCellWithReuseIdentifier:"HZImageViewCollectionView")
		self.contentView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
			make.top.equalTo(self.messageTitleLabel.snp.bottom).offset(10)
			make.width.equalTo(self.contentView.snp.width)
			make.height.equalTo(1)
        }
	
		readCountLbael = UILabel.init()
		readCountLbael.textColor = UIColorWith24Hex(rgbValue: 0x999999)
		readCountLbael.font = HZFont(fontSize: 12.0)
		readCountLbael.textAlignment = .center
		readCountLbael.backgroundColor = .red
		self.contentView.addSubview(readCountLbael)
		readCountLbael.snp.makeConstraints { (make) in
			make.left.equalTo(self.messageTitleLabel.snp.left)
			make.top.equalTo(self.collectionView.snp.bottom).offset(15 + 20)
		}
		
		upvoteBtn = UIButton.init(type: .custom)
		upvoteBtn.layer.cornerRadius = 10
		upvoteBtn.setImage(UIImage.init(named: "comment_like_icon_night"), for: .normal)
		upvoteBtn.layer.borderColor = UIColor.lightGray.cgColor
		upvoteBtn.layer.borderWidth = 1
		upvoteBtn.titleLabel?.font = HZFont(fontSize: 11)
		upvoteBtn.tag = 0
		upvoteBtn.setTitleColor(UIColorWith24Hex(rgbValue: 0x696969), for: .normal)
		upvoteBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -5, bottom: 0, right: 0)
		upvoteBtn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
		upvoteBtn.backgroundColor = UIColor.clear
		self.upvoteBtn.rx.tap.subscribe { [weak self] (value) in
			if self?.clickBtnBlock == nil {
				return
			}
			self?.clickBtnBlock!(self?.upvoteBtn)
		}.disposed(by: disposeBag)
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
		complainBtn.tag = 1
		complainBtn.setTitleColor(UIColorWith24Hex(rgbValue: 0x696969), for: .normal)
		complainBtn.layer.borderColor = UIColor.lightGray.cgColor
		complainBtn.layer.borderWidth = 0.5
		complainBtn.backgroundColor = UIColor.clear
		self.complainBtn.rx.tap.subscribe { [weak self] (value) in
			if self?.clickBtnBlock == nil {
				return
			}
			self?.clickBtnBlock!(self?.complainBtn)
		}.disposed(by: disposeBag)
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
		self.disposable = self.collectionView.rx.observe(CGSize.self, "contentSize").distinctUntilChanged().filter({ (value) -> Bool in
			if value?.width == 0 {
				return false
			} else {
				return true
			}
		}).subscribe(onNext: { [weak self] (value) in
			guard let weakself = self else {
				return
			}
			
			weakself.collectionView.snp.remakeConstraints { (make) in
				make.left.equalTo(0)
				make.top.equalTo(weakself.messageTitleLabel.snp.bottom).offset(10)
				make.width.equalTo(weakself.contentView.snp.width)
				make.height.equalTo(value!.height + 1)
			}
			weakself.layoutIfNeeded()
		})
	}
	
	deinit {
		self.disposable.disposed(by: disposeBag)
	}
	
	func createRAC() -> Void {
		let nickNameObserve = self.rx.observeWeakly(String.self, "viewModel.nickName").distinctUntilChanged()
		let nameObserve = self.rx.observeWeakly(String.self, "viewModel.name").distinctUntilChanged()
		Observable.combineLatest(nickNameObserve, nameObserve).subscribe(onNext: { [weak self] value in
			let nickName = value.0;
			let name = value.1
			if name?.lengthOfBytes(using: .utf8) == 0 {
				self?.userNameLabel.text = nickName
			} else {
				self?.userNameLabel.text = name
			}
			
		}, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
		
		self.rx.observeWeakly(String.self, "viewModel.postDate").distinctUntilChanged().subscribe(onNext: { [weak self] (value) in
			self?.userTimeLabel.text = value
		}).disposed(by: disposeBag)
		
		self.rx.observeWeakly(String.self, "viewModel.avatar_thumb").distinctUntilChanged().subscribe(onNext: { [weak self] (value :String?) in
			if value?.lengthOfBytes(using: .utf8) ?? 0 > 0 {
				self?.iconImage.kf.setImage(with: URL.init(string: value!))
			}
		}).disposed(by: disposeBag)
		
		self.rx.observeWeakly(String.self, "viewModel.content").distinctUntilChanged().filter({ (value) -> Bool in
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
		
		self.rx.observeWeakly(Int.self, "viewModel.readCnt").distinctUntilChanged().subscribe(onNext: { [weak self] (value) in
			let x : Int = value ?? 0
			let stringValue = x > 0 ? "\(x)" : ""
			self?.readCountLbael.text = "阅读" + stringValue
		}).disposed(by: disposeBag)
		
		self.rx.observeWeakly(String.self, "viewModel.fanCnt").distinctUntilChanged().bind(to: self.upvoteBtn.rx.title(for: .normal)).disposed(by: disposeBag)
		
		self.rx.observeWeakly(Array<String>.self, "viewModel.images").distinctUntilChanged().subscribe(onNext: { [weak self] (value) in
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
		}).disposed(by: disposeBag)
	}
	
	@objc func clickImageView(_ sender: UITapGestureRecognizer) -> Void {
		if self.clickBtnBlock == nil {
			return
		}
		self.clickBtnBlock!(sender.view)
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension HZHomeDetailTableViewCell :UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HZImageViewCollectionView", for: indexPath) as! HZImageViewCollectionView
		cell.imageView.kf.setImage(with: URL.init(string: self.dataSource[indexPath.item]))
		cell.imageView.tag = 100 + indexPath.item
		return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if self.clickBtnBlock == nil {
			return
		}
		let cell = collectionView.cellForItem(at: indexPath) as! HZImageViewCollectionView
		self.clickBtnBlock!(cell.imageView)
    }
}

class HZImageViewCollectionView: UICollectionViewCell {
	var imageView: UIImageView!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.viewsLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func viewsLayout() -> Void {
		imageView = UIImageView.init()
		imageView.backgroundColor = UIColor.clear
		imageView.contentMode = UIView.ContentMode.scaleToFill;
		imageView.isUserInteractionEnabled = true
		self.contentView.addSubview(imageView)
		imageView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
	}
}
