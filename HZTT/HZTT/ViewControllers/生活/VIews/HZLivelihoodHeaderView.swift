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
        flowerLayout.itemSize = CGSize.init(width:(HZSCreenWidth() - 10 * 3.0)/4.0, height: 60.0)
        flowerLayout.minimumLineSpacing = 10
        flowerLayout.minimumInteritemSpacing = 20
        let collectionView: UICollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowerLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
    }
}

extension HZLivelihoodHeaderView :UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


class HZLivelihoodCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView!
    var contentLabel: UILabel!
    
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
    }
}
