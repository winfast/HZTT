//
//  AppDelegate.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/17.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

/*
 可以看到Driver完美的解决了上面的一系列问题，而且绑定UI必然实在主线程中，且不会因为网络请求出错而产生错误事件，而且是默认的序列共享。

 那么也就是说，如果我们的序列满足如下特征，就可以使用Driver：

 不会产生 error 事件
 一定在主线程监听（MainScheduler）
 共享状态变化（shareReplayLatestWhileConnected）

 let result  = inputTF.rx.text.orEmpty
			 .asDriver()
			 .flatMap {
				 return self.dealwithData(inputText: $0)
				   //  仅仅提供发生错误时的备选返回值
					 .asDriver(onErrorJustReturn: "检测到了错误事件")
			 }
	 //drive()方法绑定UI
	 result.map { "\($0 as! String)"}
			 .drive(self.btn.rx.title())
 */

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
//	@objc dynamic var user: HZUser?
	

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		self.initWindow()
		self.initKeyboard()
		
//
//		let dict = ["key1": 10, "key2": "22", "key3": nil] as [String : Any?]
//		let result = dict.compactMapValues { (value) -> Any? in
//			if value == nil {
//				return nil
//			} else {
//				return value
//			}
//		}.
//		print(result) //["key1": 10]

		
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

