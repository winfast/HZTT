//
//  HZReleaseNewsViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/29.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZReleaseNewsViewController: HZBaseViewController {
	
	var collectionView: UICollectionView!
	var dataSource: Array<[[String:String]]> = []
	var cancelBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
		viewsLayout()
    }
	
	func viewsLayout() -> Void {
		self.navigationItem.title = "发布动态"
		
		let path = Bundle.main.path(forResource: "all_category_item", ofType: "plist")
		let array: Array? = (NSArray.init(contentsOfFile: path!) as? [[[String:String]]])
		if let arr = array {
			dataSource = dataSource + arr
		}
		
		cancelBtn = UIButton.init(type: .custom)
		cancelBtn.backgroundColor = UIColorWith24Hex(rgbValue: 0xF58D00)
		cancelBtn.setTitleColor(UIColor.white, for: .normal)
		cancelBtn.setTitle("取消", for: .normal)
		cancelBtn.titleLabel?.font = HZFont(fontSize: 17)
		cancelBtn.addTarget(self, action: #selector(clickCancelBtn(_ :)), for: .touchUpInside)
		self.view.addSubview(cancelBtn)
		cancelBtn.snp.makeConstraints { (make) in
			make.left.right.equalTo(0)
			make.height.equalTo(45)
			if #available(iOS 11.0, *) {
				make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
			} else {
				make.bottom.equalTo(0);
			}
        }
		
		let flowerLayout = UICollectionViewFlowLayout.init()
        //let width: Double = (Double(HZSCreenWidth) - Double(3 * 20.0))/4.0
		flowerLayout.itemSize = CGSize.init(width:(HZSCreenWidth() - 15 - 30*2.0)/2.0, height: (HZSCreenWidth() - 15 - 30*2.0)/4.0)
        flowerLayout.minimumLineSpacing = 10
        flowerLayout.minimumInteritemSpacing = 15
        self.collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowerLayout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.clear
		self.collectionView.alwaysBounceVertical = true
		self.collectionView.contentInset = UIEdgeInsets.init(top: 5, left: 30, bottom: 15, right: 30)
        self.collectionView.register(HZReleaseNewCollectionViewCell.classForCoder(), forCellWithReuseIdentifier:"HZReleaseNewCollectionViewCell")
		self.collectionView.register(UICollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "UICollectionHeaderView")
		self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String (describing: UICollectionReusableView.self))
		self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
			make.left.right.top.equalTo(0)
			make.bottom.equalTo(self.cancelBtn.snp.top).offset(-5)
        }
	}
	
	@objc func clickCancelBtn(_ sender: UIButton) {
		self.navigationController?.dismiss(animated: true, completion: {
			
		})
	}
}

extension HZReleaseNewsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		//选择类型,发布动态
		let knowAciton = UIAlertAction.init(title: "知道了", style: .default) { (aciton) in
			self.dismiss(animated: false, completion: nil)
			
			let tabBarVC = UIApplication.shared.keyWindow?.rootViewController as! HZTabBarController
			let itemInfo = self.dataSource[indexPath.section][indexPath.item];
			let vc = HZWebViewController.init()
			let nav = HZNavigationController.init(rootViewController: vc)
			tabBarVC.present(nav, animated: true) {
			}
		}
		
		let notiAction = UIAlertAction.init(title: "发布须知", style: .default) { (aciton) in
			let webView = HZWebViewController.init()
			webView.url = "p/publishNotes.html"
			self.navigationController?.pushViewController(webView, animated: true)
		}
		
		let alertViewController = UIAlertController.init(title: "提示", message: "请发布真实有效信息,否则审核无法通过", preferredStyle: .alert)
		alertViewController.addAction(knowAciton)
		alertViewController.addAction(notiAction)
		self.navigationController?.present(alertViewController, animated: true, completion: nil)
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return self.dataSource.count
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.dataSource[section].count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: HZReleaseNewCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HZReleaseNewCollectionViewCell", for: indexPath) as! HZReleaseNewCollectionViewCell
		cell.textLabel.text = self.dataSource[indexPath.section][indexPath.item]["item_title"]
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		if kind == UICollectionView.elementKindSectionHeader {
			let headerView: UICollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "UICollectionHeaderView", for: indexPath) as! UICollectionHeaderView
			if indexPath.section == 0 {
				headerView.textLabel.text = "新动态"
			} else {
				headerView.textLabel.text = "生活服务"
			}
			return headerView
		}
		let v = UICollectionReusableView()
        v.backgroundColor = UIColor.white
        return v
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		
		return CGSize.init(width: HZSCreenWidth(), height: 50)
	}
}

class HZReleaseNewCollectionViewCell: UICollectionViewCell {
	
	var textLabel: UILabel!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.viewsLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func viewsLayout() -> Void {
		self.contentView.backgroundColor = UIColor.clear
		self.contentView.layer.cornerRadius = 5;
		self.contentView.layer.borderWidth = 1.0;
		self.contentView.layer.borderColor = UIColorWith24Hex(rgbValue: 0xE7E7E7).cgColor
		
		textLabel = UILabel.init()
		textLabel.textAlignment = .center
		textLabel.font = HZFont(fontSize: 16)
		self.contentView.addSubview(textLabel)
		textLabel.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
	}
}

class UICollectionHeaderView: UICollectionReusableView {
	var textLabel: UILabel!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.viewsLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func viewsLayout() -> Void {
		textLabel = UILabel.init()
		textLabel.textAlignment = .left
		textLabel.textColor = UIColor.init(red: 0.41, green: 0.41, blue: 0.41, alpha: 1)
		textLabel.text = "1234455"
		textLabel.font = HZFont(fontSize: 14)
		self.addSubview(textLabel)
		textLabel.snp.makeConstraints { (make) in
			make.top.bottom.right.equalTo(0)
			make.left.equalTo(15)
		}
	}
}


