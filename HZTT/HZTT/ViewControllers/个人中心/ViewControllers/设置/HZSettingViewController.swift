//
//  HZSettingViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/8.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import Kingfisher

class HZSettingViewController: HZBaseViewController {
	
	var tableView: UITableView!
	var dataSource: Array<[[String:Any]]>?
	
	var cacheValue: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.navigationItem.title = "设置"
		self.viewsLayout()
    }
	
	func viewsLayout() -> Void {
		
		self.dataSource = [
		[["title":"修改资料","className":"HZModifyInfoViewController","param":""],
		 ["title":"黑名单","className":"HZBaseViewController","param":""],
		 ["title":"通知","className":"","param":""]],
		[["title":"清空缓存","className":"","param":""],
		 ["title":"意见反馈","className":"HZBaseViewController","param":""],
		 ["title":"前往评分","className":"HZBaseViewController","param":""],
		 ["title":"关于我们","className":"HZAboutViewController","param":""]]]
		
		if HZUserInfo.isLogin() {
			self.dataSource!.append([["title":"关于我们","className":"HZAboutViewController","param":""]] as [[String:Any]])
		}
		
		self.tableView = UITableView.init(frame: .zero, style: .grouped)
		self.tableView.estimatedRowHeight = 50
		self.tableView.rowHeight = 50
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.separatorStyle = .singleLine
		self.tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 0)
		//self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
		self.view.addSubview(self.tableView)
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
		
		ImageCache.default.calculateDiskStorageSize { (handle) in
			do {
				let size: Double = try Double(handle.get())
				self.cacheValue = String.init(format: "%.2f", size/1024.0/1024.0) + "MB"
				self.tableView.reloadData()
			} catch {
				
			}
		}
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

extension HZSettingViewController :UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return self.dataSource?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.dataSource?[section].count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.section == 2 {
			var cell = tableView.dequeueReusableCell(withIdentifier: "HZLoginoutTableViewCell")
			if cell == nil {
				cell = HZLoginoutTableViewCell.init(style: .value1, reuseIdentifier: "HZLoginoutTableViewCell")
				cell?.detailTextLabel?.font = HZFont(fontSize: 14)
				cell?.selectionStyle = .none
			}
			return cell!
		}
		
		var cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
		if cell == nil {
			cell = UITableViewCell.init(style: .value1, reuseIdentifier: "UITableViewCell")
			cell?.detailTextLabel?.font = HZFont(fontSize: 14)
			cell?.selectionStyle = .none
		}
		let cellInfo: [String:Any] = (self.dataSource?[indexPath.section][indexPath.row])!
		cell?.textLabel?.text = (cellInfo["title"] as! String)
		cell?.textLabel?.font = HZFont(fontSize: 16)
		if (indexPath.section == 0 && indexPath.row == 2) || (indexPath.section == 1 && indexPath.row == 0) {
			cell?.accessoryType = .none
			cell?.accessoryView = UIView.init(frame: CGRect.init(x: 0, y: 0, width:20 , height: 44))
		} else {
			cell?.accessoryType = .disclosureIndicator
			cell?.accessoryView = nil
		}
		
		if indexPath.section == 1 && indexPath.row == 0 {
			if nil != self.cacheValue {
				cell?.detailTextLabel?.text = self.cacheValue
				
			}
		} else {
			cell?.detailTextLabel?.text = nil
		}
		return cell!
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 0.000001
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		if section == 2 {
			return 15
		}
		return 40
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		if section == 0 || section == 2 {
			return UIView.init()
		}
		let view = UIView.init()
		let label = UILabel.init(frame: CGRect.init(x: 16, y: 0, width: 300, height: 20))
		label.text = "请在iphone系统\"设置-通知\"中修改";
		label.font = HZFont(fontSize: 12)
		label.textColor = UIColorWith24Hex(rgbValue: 0x999999)
		view.addSubview(label)
		return view
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return nil
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cellInfo: [String:Any] = (self.dataSource?[indexPath.section][indexPath.row])!
		let className = (cellInfo["className"] as! String)
		
		if indexPath.section == 2 {
			//退出登录
			HZUserInfo.share().clearUserInfo { [weak self] in
				guard let weakself = self else {
					return
				}
				weakself.navigationController?.popViewController(animated: true)
			}
		} else {
			if className.lengthOfBytes(using: .utf8) > 0 {
				guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
					return;
				}
				
				guard let currClassName = NSClassFromString(nameSpace + "." + className) as? HZBaseViewController.Type else {
					return
				}
				
				let letvc = currClassName.init()
				self.navigationController?.pushViewController(letvc, animated: true)
			} else {
				
			}
		}
		
		/*
        // 准备工作: 命名空间: 必须指定那个bundle(包)
        // 从Info.plist中获取bundle的名字
        let namespace = Bundle.main.infoDictionary!["CFBundleName"] as! String
        // 0.将控制器的字符串转成控制器类型
        let classFromStr: AnyClass? = NSClassFromString(namespace + "." + className)
        let viewControllerClass = classFromStr as! UIViewController.Type
        // 1.创建控制器对象
        let viewController = viewControllerClass.init()
        
        return viewController;
		*/
	}
}
