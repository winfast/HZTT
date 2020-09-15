//
//  HZFansAndConcernViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/14.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import JXSegmentedView

class HZFansAndConcernViewController: HZBaseViewController {
	
	let segmentedView = JXSegmentedView()
	   let titlesId = [
		   "关注":"0",
		   "粉丝":"1"
	   ]
	   var segmentedDataSource: JXSegmentedTitleDataSource?
	   lazy var listContainerView: JXSegmentedListContainerView! = {
		   return JXSegmentedListContainerView(dataSource: self)
	   }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.viewsLayout()
    }
	
	func viewsLayout() -> Void {
        self.navigationItem.title = ""
        
        let titles = ["关注","粉丝"]
        
        self.segmentedDataSource = JXSegmentedTitleDataSource()
        self.segmentedDataSource?.isItemTransitionEnabled = true;
        self.segmentedDataSource?.titles = titles
        self.segmentedDataSource?.itemWidth = 50
        self.segmentedDataSource?.itemSpacing = 10
        self.segmentedDataSource?.isItemSpacingAverageEnabled = false
        self.segmentedDataSource?.titleNormalFont = HZFont(fontSize: 16)
        self.segmentedDataSource?.titleSelectedFont = HZFont(fontSize: 16)
        self.segmentedDataSource?.titleSelectedColor = UIColorWith24Hex(rgbValue: 0xff4500)
        self.segmentedView.dataSource = self.segmentedDataSource;
        self.segmentedView.delegate = self;
        self.segmentedView.contentEdgeInsetLeft = 0
		self.segmentedView.contentEdgeInsetRight = 0
        let indicator: JXSegmentedIndicatorLineView = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 30
        indicator.verticalOffset = 5
        indicator.indicatorHeight = 2;
        indicator.indicatorCornerRadius = 1;
        indicator.indicatorColor = UIColorWith24Hex(rgbValue: 0xff4500)
        self.segmentedView.indicators = [indicator]
        
        let bgView: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0.0, width: 50 * 2 + 10 * 1, height: 44.0))
        self.segmentedView.frame = bgView.bounds
        bgView.addSubview(self.segmentedView)
        self.navigationItem.titleView = bgView
        self.segmentedView.listContainer = self.listContainerView
        self.view.addSubview(self.listContainerView)
		self.listContainerView.scrollView.panGestureRecognizer.require(toFail: (self.navigationController?.interactivePopGestureRecognizer)!)
		self.segmentedView.collectionView.panGestureRecognizer.require(toFail: (self.navigationController?.interactivePopGestureRecognizer)!)
		self.listContainerView.backgroundColor = UIColor.white
        self.listContainerView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
	}
}


extension HZFansAndConcernViewController: JXSegmentedViewDelegate, JXSegmentedListContainerViewDataSource {

    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
//      navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
//		self.listContainerView.scrollView.panGestureRecognizer.isEnabled = (segmentedView.selectedIndex == 0)
//		self.navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
		if index == 0 {
			let vc = HZConcernListViewController.init()
			return vc
		} else {
			let vc  = HZFansListViewController.init()
			return vc
		}
		
    }
}
