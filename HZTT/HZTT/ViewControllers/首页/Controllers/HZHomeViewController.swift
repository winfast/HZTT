//
//  HZHomeViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/17.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

import JXSegmentedView

class HZHomeViewController: HZBaseViewController {
	
	let segmentedView = JXSegmentedView()
	let titlesId = [
				"最新":"0",
				"热门":"1",
	//          "新鲜事":"10",∂∂∂
				"打听":"11",
				"吐槽":"12",
				"公告":"13",
			]
	var segmentedDataSource: JXSegmentedTitleDataSource?
	lazy var listContainerView: JXSegmentedListContainerView! = {
		return JXSegmentedListContainerView(dataSource: self)
	}()
	
	

    override func viewDidLoad() {
        super.viewDidLoad()
		self.viewLayout()
		
    }
	
	func viewLayout() -> Void {
		self.navigationController?.navigationBar.shadowImage = imageWithColor(color: UIColorWith24Hex(rgbValue: 0xFF0000))
		self.navigationItem.title = ""

		let titles = ["最新","热门",
					  //"新鲜事",
					  "打听","吐槽","公告"]
		
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
		self.segmentedView.contentEdgeInsetLeft = 0;
		let indicator: JXSegmentedIndicatorLineView = JXSegmentedIndicatorLineView()
		indicator.indicatorWidth = 30
		indicator.verticalOffset = 5
		indicator.indicatorHeight = 2;
		indicator.indicatorCornerRadius = 1;
		indicator.indicatorColor = UIColorWith24Hex(rgbValue: 0xff4500)
		self.segmentedView.indicators = [indicator]
		
		let bgView: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0.0, width: Double(HZSCreenWidth()), height: 44.0))
		self.segmentedView.frame = bgView.bounds
		bgView.addSubview(self.segmentedView)
//		self.segmentedView.snp.makeConstraints { (make) in
//			make.edges.equalTo(0)
//		}
		self.navigationItem.titleView = bgView

		self.segmentedView.listContainer = self.listContainerView
		self.view.addSubview(self.listContainerView)
		self.listContainerView.backgroundColor = UIColor.white
		self.listContainerView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
	}
}

extension HZHomeViewController: JXSegmentedViewDelegate, JXSegmentedListContainerViewDataSource {
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
       // navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let title: String! = self.segmentedDataSource?.titles[index] ?? "最新"
        let vc: HZHomeListViewController = HZHomeListViewController.init(self.titlesId[title]!)
        return vc
    }
}

