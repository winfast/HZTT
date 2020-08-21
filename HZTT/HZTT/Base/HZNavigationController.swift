//
//  HZNavigationController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/17.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZNavigationController: HBDNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		let apperance = UINavigationBar.appearance()
		apperance.barTintColor = UIColor.white
		apperance.tintColor = UIColorWith24Hex(rgbValue: 0x000000)
		self.navigationBar.isTranslucent = true;

        // Do any additional setup after loading the view.
    }
	
	override func pushViewController(_ viewController: UIViewController, animated: Bool) {
		if self.viewControllers.count >= 1 {
			viewController.navigationItem.leftBarButtonItem = self.leftBarButtomitem()
			viewController.hidesBottomBarWhenPushed = true;
		}
		super.pushViewController(viewController, animated: animated)
	}
	
	func leftBarButtomitem() ->UIBarButtonItem {
		let backBtn :UIButton = UIButton.init(type: .custom)
		backBtn.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
		backBtn.setImage(UIImage (named: "leftbackicon_sdk_login"), for: .normal)
		backBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -10, bottom: 0, right: 0)
		backBtn.addTarget(self, action: #selector(clickBackBtn), for: .touchUpInside)
		let leftItem :UIBarButtonItem = UIBarButtonItem.init(customView: backBtn)
		return leftItem
	}
	
	@objc func clickBackBtn(_ sender: Any) ->Void {
		self.popViewController(animated: true)
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
