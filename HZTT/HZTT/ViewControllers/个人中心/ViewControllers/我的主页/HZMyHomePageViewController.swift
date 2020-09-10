//
//  HZMyHomePageViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/10.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZMyHomePageViewController: HZBaseViewController {
	
	var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.viewsLayout()
    }
	
	func viewsLayout() -> Void {
		self.tableView = UITableView.init(frame: .zero, style: .plain)
		
	}
}
