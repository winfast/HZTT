//
//  HZTopicViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/22.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import JXSegmentedView

class HZTopicViewController: HZBaseViewController {
    
    let segmentedView = JXSegmentedView()
    let titlesId = [
        "最新":"0",
        "热门":"1"
    ]
    var segmentedDataSource: JXSegmentedTitleDataSource?
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view.
		self.initNavigationRightItem()
		self.viewsLayout()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		//navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
	}
    
    func initNavigationRightItem() -> Void {
        let rightBtn: UIButton = UIButton.init(type: .custom)
        rightBtn.setTitle("创建", for: .normal)
        rightBtn.titleLabel?.font = HZFont(fontSize: 15)
        rightBtn.setTitleColor(UIColor.lightGray, for: .normal)
        rightBtn.addTarget(self, action: #selector(clickRightBtn), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
    }
    
    @objc func clickRightBtn(_ sender: UIButton) -> Void {
		let vc: HZCreateTopicViewController = HZCreateTopicViewController.init()
		let nav: HZNavigationController = HZNavigationController.init(rootViewController: vc)
		nav.modalPresentationStyle = .fullScreen
		self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    func viewsLayout() -> Void {
        self.navigationController?.navigationBar.shadowImage = HZImageWithColor(color: UIColorWith24Hex(rgbValue: 0xFF0000))
        self.navigationItem.title = ""
        
        let titles = ["最新","热门"]
        
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
        self.listContainerView.backgroundColor = UIColor.white
        self.listContainerView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
}

extension HZTopicViewController: JXSegmentedViewDelegate, JXSegmentedListContainerViewDataSource {

    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        // navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
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
        let vc: HZTopicListViewController = HZTopicListViewController.init()
		vc.type = self.titlesId[title]
		vc.category = "friend"
        return vc
    }
}


