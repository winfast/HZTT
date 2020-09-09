//
//  AppDelegate.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/17.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
//	@objc dynamic var user: HZUser?
	

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		self.initWindow()
		self.initKeyboard()
		
		
//		self.user = HZUser.init()
//		self.user?.name = "1234455"
//
//		self.createRACSignal()
//
//		self.user?.name = "asdfasdfas"
//
//
//		self.user?.name = "xzcvxzvxzcvzcv"
//
//		self.user?.name = "uiouyoyuouoy"
//
//
//		self.user = HZUser.init()
//		self.user?.name = "456464564645"
		
		return true
	}
	
	func initWindow() -> Void {
		self.window = UIWindow.init(frame: UIScreen.main.bounds)
		self.window?.backgroundColor = UIColor.white;
		let tabBarController = HZTabBarController.init()
		self.window?.rootViewController = tabBarController
		self.window?.makeKeyAndVisible()
	}
	
	
	func initKeyboard() -> Void {
		IQKeyboardManager.shared.enable = true
		IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "完成"
		//控制点击背景是否收起键盘
		IQKeyboardManager.shared.shouldResignOnTouchOutside = true
		//IQKeyboardManager.shared.disabledToolbarClasses = [HZHomeDetailViewController.Type]()
	}
	
//	func createRACSignal() -> Void {
//
//		self.rx.observe(String.self, "user.name").filter { (value) -> Bool in
//			guard let currValue = value else {
//				return false
//			}
//			return true
//		}.subscribe(onNext: { (value) in
//			print(value)
//		})
//	}
}

