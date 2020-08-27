//
//  HZCreateTopicTableViewCell.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/26.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZTopicTitleTableViewCell: UITableViewCell {

	var titleTextField: UITextField!
	
	var disposeBag :DisposeBag = DisposeBag.init()
	 
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.viewsLayout()
	}
	
	func viewsLayout() -> Void {
		self.backgroundColor = .white
		self.selectionStyle = .none
		titleTextField = UITextField.init()
		titleTextField.font = HZFont(fontSize: 15)
		titleTextField.placeholder = "请输入标题"
		titleTextField.textColor = .black
		self.contentView.addSubview(titleTextField)
		titleTextField.snp.makeConstraints { (make) in
			make.left.equalTo(15)
			make.right.equalTo(10)
			make.top.equalTo(16)
			make.bottom.lessThanOrEqualTo(self.contentView.snp.bottom).offset(-16).priority(900)
		}
	}
}

class HZTopciContentTableViewCell: UITableViewCell {
	
	var textView: IQTextView!
	var disposeBag :DisposeBag = DisposeBag.init()
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.viewsLayout()
	}
	
	func viewsLayout() -> Void {
		self.backgroundColor = .white
		self.selectionStyle = .none
		textView = IQTextView.init()
		textView.font = HZFont(fontSize: 14)
		textView.placeholder = "请输入内容"
		textView.textColor = .black
		textView.placeholderTextColor = UIColor.init(red: 0.72, green: 0.72, blue: 0.72, alpha: 1)
		self.contentView.addSubview(textView)
		textView.snp.makeConstraints { (make) in
			make.left.equalTo(10)
			make.right.equalTo(-10)
			make.top.equalTo(0)
			make.height.equalTo(80)
			make.bottom.lessThanOrEqualTo(self.contentView.snp.bottom).offset(0).priority(900)
		}
	}
}

class HZTopicImageTableViewCell: UITableViewCell {
	var collectionView: UICollectionView!
	
	typealias HZAddTopicImageBlock = () -> UIImage?
    var addTopicImageBlock: HZAddTopicImageBlock?
	
	typealias HZDeleteTopicImageBlock = (_ deleteIndex: Int) -> Void
    var deleteTopicImageBlock: HZDeleteTopicImageBlock?
	
	var dataSource: [UIImage] = [] {
		didSet {
			self.collectionView.reloadData()
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.viewsLayout()
	}
	
	func viewsLayout() -> Void {
		
		self.backgroundColor = UIColor.init(red:244/255.0, green: 245/255.0, blue: 247/255.0, alpha: 1);
		
		let flowerLayout = UICollectionViewFlowLayout.init()
        //let width: Double = (Double(HZSCreenWidth) - Double(3 * 20.0))/4.0
		flowerLayout.itemSize = CGSize.init(width:(320.0 - 5*2.0 - 10*2.0)/3.0, height: 90.0)
        flowerLayout.minimumLineSpacing = 5
        flowerLayout.minimumInteritemSpacing = 5
        self.collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowerLayout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.clear
		self.collectionView.contentInset = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10)
        self.collectionView.register(HZTopicImageViewCollectionCell.classForCoder(), forCellWithReuseIdentifier:"HZTopicImageViewCollectionCell")
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.top.equalTo(0)
			make.size.equalTo(CGSize.init(width: 320, height: 300))
			make.bottom.lessThanOrEqualTo(0).priority(900)
        }
	}
}

extension HZTopicImageTableViewCell :UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dataSource.count >= 9 ? 9 : dataSource.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"HZTopicImageViewCollectionCell", for: indexPath) as! HZTopicImageViewCollectionCell
		cell.deleteBtn?.isHidden = true
		cell.deleteBtn?.tag = indexPath.item
		cell.deleteTopicImageBlock = { [weak self] (selectedIndex: Int) in
			guard let strongSelf = self else {
				return
			}
			strongSelf.dataSource.remove(at: selectedIndex)
			strongSelf.collectionView.reloadData()
			if strongSelf.deleteTopicImageBlock != nil {
				strongSelf.deleteTopicImageBlock!(selectedIndex)
			}
		}
		if self.dataSource.count == 0 {
			cell.imageView.contentMode = .center
			cell.imageView.image = UIImage.init(named: "addicon_repost")
		} else {
			if dataSource.count == 9 {
				cell.deleteBtn?.isHidden = false
				cell.imageView.contentMode = .scaleToFill
				cell.imageView.image = self.dataSource[indexPath.row]
			} else {
				if self.dataSource.count == indexPath.row {
					cell.imageView.contentMode = .center
					cell.imageView.image = UIImage.init(named: "addicon_repost")
				} else {
					cell.deleteBtn?.isHidden = false
					cell.imageView.contentMode = .scaleToFill
					cell.imageView.image = self.dataSource[indexPath.row]
				}
			}
		}
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let cell = collectionView.cellForItem(at: indexPath) as! HZTopicImageViewCollectionCell
		if cell.deleteBtn?.isHidden == false {
			return
		}
		
		if self.addTopicImageBlock != nil {
			let image :UIImage? = self.addTopicImageBlock!()
			guard let ii = image else { return }
			self.dataSource.append(ii)
			self.collectionView.reloadData()
		}
    }
}

class HZTopicImageViewCollectionCell: UICollectionViewCell {
	open var imageView: UIImageView!
	open var deleteBtn: UIButton?
	
	typealias HZDeleteTopicImageBlock = (_ deleteIndex: Int) -> Void
    var deleteTopicImageBlock: HZDeleteTopicImageBlock?
	
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
		self.contentView.addSubview(imageView!)
		imageView.snp.makeConstraints({ (make) in
			make.edges.equalTo(0)
		})
		
		deleteBtn = UIButton.init()
		deleteBtn?.backgroundColor = .clear
		deleteBtn?.contentHorizontalAlignment = .right
		deleteBtn?.contentVerticalAlignment = .top
		deleteBtn?.setImage(UIImage.init(named: "deleteicon_channel"), for: .normal)
		deleteBtn?.addTarget(self, action: #selector(clickDeleteBtn), for: .touchUpInside)
		self.contentView.addSubview(deleteBtn!)
		deleteBtn?.snp.makeConstraints({ (make) in
			make.right.top.equalTo(0);
			make.size.equalTo(CGSize.init(width: 35, height: 35))
		})
	}
	
	@objc func clickDeleteBtn(_ sender: UIButton) -> Void {
		if self.deleteTopicImageBlock != nil {
			self.deleteTopicImageBlock!(sender.tag)
		}
	}
}


