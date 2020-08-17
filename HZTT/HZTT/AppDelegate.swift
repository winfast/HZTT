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
	

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		self.initWindow()
		self.initTabar()
		return true
	}
	
	func initWindow() -> Void {
		self.window = UIWindow.init(frame: UIScreen.main.bounds)
		self.window?.backgroundColor = UIColor.white;
	}
	
	func initTabar() -> Void {
		let tabBarController = HZTabBarController.init()
		self.window?.rootViewController = tabBarController
		self.window?.makeKeyAndVisible()
	}
}

