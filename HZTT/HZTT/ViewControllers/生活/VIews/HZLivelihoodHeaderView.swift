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
    
    func viewsLayout() -> Void {
        let flowerLayout = UICollectionViewFlowLayout.init()
        flowerLayout.itemSize = CGSize.init(width: (HZSCreenWidth - 3 * 20.0)/4.0, height: 60.0)
        flowerLayout.minimumLineSpacing = 10
        flowerLayout.minimumInteritemSpacing = 20
        let collectionView: UICollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowerLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
   

}

extension HZLivelihoodViewController :UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
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
