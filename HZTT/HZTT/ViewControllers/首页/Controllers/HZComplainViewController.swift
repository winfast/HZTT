//
//  HZComplainViewController.swift
//  HZTT  举报
//
//  Created by QinChuancheng on 2020/8/21.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class HZComplainViewController: HZBaseViewController {
	
	var pid :String?
	var category :String?
	
	var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.title = "请输入举报原因"
		self.navigationLayout()
		self.viewsLayout()

        // Do any additional setup after loading the view.
    }
	
	func navigationLayout() -> Void {
		let leftBtn: UIButton = UIButton.init(type: .custom)
		//leftBtn.frame = CGRect.init(x: 0, y: 0, width: 60, height: 44)
		leftBtn.setTitle("取消", for: .normal)
		leftBtn.titleLabel?.font = HZFont(fontSize: 15)
		leftBtn.setTitleColor(UIColor.darkGray, for: .normal)
		leftBtn.addTarget(self, action: #selector(clickLeftBtn), for: .touchUpInside)
		self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBtn)
		
		let rightBtn: UIButton = UIButton.init(type: .custom)
		//rightBtn.frame = CGRect.init(x: 0, y: 0, width: 60, height: 44)
		rightBtn.setTitle("提交", for: .normal)
		rightBtn.titleLabel?.font = HZFont(fontSize: 15)
		rightBtn.setTitleColor(UIColorWith24Hex(rgbValue: 0xD43D3D), for: .normal)
		rightBtn.addTarget(self, action: #selector(clickRightBtn), for: .touchUpInside)
		self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
	}
	
	func viewsLayout() -> Void {
		self.tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
		self.tableView.backgroundColor = UIColorWith24Hex(rgbValue: 0xE9E9E9)
		self.tableView.separatorStyle = .none
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.rowHeight = UITableView.automaticDimension
		self.tableView.estimatedRowHeight = 80
		self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
		self.view.addSubview(self.tableView)
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
	}
    
	
	@objc func clickLeftBtn(_sender: UIButton) -> Void {
		self.navigationController?.dismiss(animated: true, completion: nil)
	}
	
	@objc func clickRightBtn(_sender: UIButton) -> Void {
		self.navigationController?.dismiss(animated: true, completion: nil)
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

extension HZComplainViewController :UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell :UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
		cell.backgroundColor = UIColor.white
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		if 0 == section {
			return 30
		}
		return 10
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 0.00001
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return UIView.init()
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return nil
	}
}


class HZComplainTableViewCell : UITableViewCell {
	
	var textView: IQTextView!
	var textLenthLabel: UILabel?
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.viewsLayout()
	}
	
	func viewsLayout() -> Void {
		self.textView = IQTextView.init(frame: CGRect.zero)
		//self.textView.attr = "请输入举报原因"
	}
}
