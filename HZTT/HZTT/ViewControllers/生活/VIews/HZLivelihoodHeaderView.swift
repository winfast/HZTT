//
//  HZLivelihoodHeaderView.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/22.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZLivelihoodHeaderView: UIView {
    
    var collectionView: UICollectionView!
    var dataSource: Array<[String:String]> = []
//    {
//        didSet {
//            self.collectionView.reloadData()
//        }
//    }
    
    typealias HZSelectedLivelihoodTyoeBlock = (_ selectedIndex: Int) -> Void
    var selectedLivelihoodIndex: HZSelectedLivelihoodTyoeBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.viewsLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewsLayout() -> Void {
        let flowerLayout = UICollectionViewFlowLayout.init()
        //let width: Double = (Double(HZSCreenWidth) - Double(3 * 20.0))/4.0
        flowerLayout.itemSize = CGSize.init(width:(HZSCreenWidth() - 10 * 3.0 - 10*2)/4.0, height: 80)
        flowerLayout.minimumLineSpacing = 10
        flowerLayout.minimumInteritemSpacing = 10
        self.collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowerLayout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.layer.borderWidth = 0.5
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.layer.borderColor = UIColorWith24Hex(rgbValue: 0x999999).cgColor
        self.collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 10, right: 10)
        self.collectionView.register(HZLivelihoodCollectionViewCell.classForCoder(), forCellWithReuseIdentifier:"HZLivelihoodCollectionViewCell")
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
    }
}

extension HZLivelihoodHeaderView :UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"HZLivelihoodCollectionViewCell", for: indexPath) as! HZLivelihoodCollectionViewCell
        let item = self.dataSource[indexPath.item]
        cell.imageView.image = UIImage.init(named: item["imageName"] ?? "")
        cell.contentLabel.text = item["title"] ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.selectedLivelihoodIndex != nil {
            self.selectedLivelihoodIndex!(indexPath.row)
        }
    }
}


class HZLivelihoodCollectionViewCell: UICollectionViewCell {
    open var imageView: UIImageView!
    open var contentLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewsLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewsLayout() -> Void {
        imageView = UIImageView.init()
        imageView.backgroundColor = .clear
        self.contentView.addSubview(self.imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.top.equalTo(20)
            make.size.equalTo(CGSize.init(width: 30, height: 30))
        }
        
        self.contentLabel = UILabel.init()
        self.contentLabel.textColor = UIColor.black
        self.contentLabel.text = "吃喝玩乐"
        self.contentLabel.font = HZFont(fontSize: 12)
        self.contentView.addSubview(self.contentLabel)
        self.contentLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
        }
    }
}
