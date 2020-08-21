//
//  HZTabBarController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/17.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.tabBar.isTranslucent = false;
		self.initTabar()
        // Do any additional setup after loading the view.
    }
	
	func initTabar() -> Void {
		self.tabBar.barTintColor = UIColor.white;
		self.delegate = self;
		let itemTitlesArray: Array<String> = [
			"首页",
			"话题",
			"",
			"生活",
			"个人中心"];
		let icon_normalsArray: Array<String> =  [
			"tabbar_icon_home",
			"tabbar_icon_friend",
			"tabbar_icon_publish",
			"tabbar_icon_all",
			"tabbar_icon_me"]
		
		let icon_selectedsArray: Array<String> = [
			"tabbar_icon_home_selected",
			"tabbar_icon_friend_selected",
			"tabbar_icon_publish" ,
			"tabbar_icon_all_selected",
			"tabbar_icon_me_selected" ]
		
		let vcNamesArray :Array<String> = [
			"HZHomeViewController",
			"HZBaseViewController",
			"HZBaseViewController",
			"HZBaseViewController",
			"HZBaseViewController",
		]
		
		var viewControllers: Array<UIViewController> = Array.init()
		for index in 0..<vcNamesArray.count {
			let appName = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
			let cls = NSClassFromString(appName + "." + vcNamesArray[index]) as! HZBaseViewController.Type
			let vc:UIViewController! = cls.init();
			let barItem = UITabBarItem(title: itemTitlesArray[index], image: UIImage.init(named: icon_normalsArray[index])?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage.init(named: icon_selectedsArray[index])?.withRenderingMode(.alwaysOriginal))
			vc.tabBarItem = barItem
			vc.title = itemTitlesArray[index]
			barItem.tag = index
			barItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .selected)
			let navigation = HZNavigationController.init(rootViewController: vc);
			viewControllers.append(navigation)
			
			if index == 2 {
				barItem.imageInsets = UIEdgeInsets.init(top: 5, left: 0, bottom: -5, right: 0)
			}
		}
		self.viewControllers = viewControllers;
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

extension HZTabBarController :UITabBarControllerDelegate {
	func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
		let tag = viewController.tabBarItem.tag
		if 2 == tag {
			return false
		} else {
			return true
		}
	}
}
