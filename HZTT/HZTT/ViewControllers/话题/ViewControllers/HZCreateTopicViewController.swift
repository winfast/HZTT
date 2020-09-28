//
//  HZCreateTopicViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/26.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit

class HZCreateTopicViewController: HZBaseViewController {
	var category: String?
	var tableView: UITableView!
	var topicTitle: String?
	var topicContent: String?
	var imagePickerController: TZImagePickerController?
	
	var sourceAssets: Array<Any> = []

    override func viewDidLoad() {
        super.viewDidLoad()
	
        // Do any additional setup after loading the view.
		self.view.backgroundColor = UIColor.init(red:244/255.0, green: 245/255.0, blue: 247/255.0, alpha: 1)
		self.navigationLayout()
		self.viewsLayout()
    }
	
	func navigationLayout() -> Void {
		self.navigationItem.title = "创建话题"
		let leftBtn: UIButton = UIButton.init(type: .custom)
		leftBtn.setTitle("取消", for: .normal)
		leftBtn.titleLabel?.font = HZFont(fontSize: 15)
		leftBtn.setTitleColor(UIColor.darkGray, for: .normal)
		leftBtn.addTarget(self, action: #selector(clickLeftBtn), for: .touchUpInside)
		self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBtn)
		
		let rightBtn: UIButton = UIButton.init(type: .custom)
		rightBtn.setTitle("提交", for: .normal)
		rightBtn.titleLabel?.font = HZFont(fontSize: 15)
		rightBtn.setTitleColor(UIColor.lightGray, for: .normal)
		rightBtn.addTarget(self, action: #selector(clickRightBtn), for: .touchUpInside)
		self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
	}
	
	func viewsLayout() -> Void {
		tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
		tableView.backgroundColor = UIColor.clear
		tableView.separatorStyle = .none
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(HZTopicTitleTableViewCell.classForCoder(), forCellReuseIdentifier: "HZTopicTitleTableViewCell")
		tableView.register(HZTopciContentTableViewCell.classForCoder(), forCellReuseIdentifier: "HZTopciContentTableViewCell")
		tableView.register(HZTopicImageTableViewCell.classForCoder(), forCellReuseIdentifier: "HZTopicImageTableViewCell")
		self.view.addSubview(tableView)
		tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
	}
    
    @objc func clickLeftBtn(_ sender: UIButton) -> Void {
		self.navigationController?.dismiss(animated: true, completion: nil)
	}
	
	@objc func clickRightBtn(_ sender: UIButton) -> Void {
		guard let currTopicTitle = self.topicTitle else {
			return
		}
		
		guard let currTopicContent = self.topicContent else {
			return
		}
		
		if currTopicTitle.lengthOfBytes(using: .utf8) == 0 {
			return
		}
		
		if currTopicContent.lengthOfBytes(using: .utf8) == 0 {
			return
		}
		
		//上传相关数据
	}
	
	@objc func clickImagePickViewLeftBtn(_ sender: UIButton) -> Void {
		self.imagePickerController?.dismiss(animated: true, completion: nil)
	}
}

extension HZCreateTopicViewController :UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if 0 == indexPath.section {
			let cell = tableView.dequeueReusableCell(withIdentifier: "HZTopicTitleTableViewCell") as! HZTopicTitleTableViewCell
			cell.selectionStyle = .none
			cell.titleTextField.rx.text.asObservable().subscribe(onNext: { (value) in
				self.topicTitle = value
			}).disposed(by: cell.disposeBag)
			return cell
		} else if 1 == indexPath.section {
			let cell = tableView.dequeueReusableCell(withIdentifier: "HZTopciContentTableViewCell") as! HZTopciContentTableViewCell
			cell.selectionStyle = .none
			cell.textView.rx.text.asObservable().subscribe(onNext: { (value) in
				self.topicTitle = value
			}).disposed(by: cell.disposeBag)
			return cell
		} else  {
			let cell = tableView.dequeueReusableCell(withIdentifier: "HZTopicImageTableViewCell") as! HZTopicImageTableViewCell
			cell.selectionStyle = .none
			cell.deleteTopicImageBlock = { [weak self] (selectedIndex: Int) in
				guard let strongSelf = self else {
					return
				}
				
				strongSelf.sourceAssets.remove(at: selectedIndex)
			}
			cell.addTopicImageBlock = { [weak self] () in
				//准备图片相关代码
				guard let strongSelf = self else {return nil}
				strongSelf.imagePickerController = TZImagePickerController.init(maxImagesCount: 9, columnNumber: 4, delegate: self, pushPhotoPickerVc: true)
				strongSelf.imagePickerController?.allowPickingGif = false
				strongSelf.imagePickerController?.allowPickingVideo = false
				strongSelf.imagePickerController?.allowTakePicture = false
				strongSelf.imagePickerController?.imagePickerControllerDidCancelHandle = { [weak self] in
					guard let strongSelf = self else {return}
					strongSelf.imagePickerController?.dismiss(animated: true, completion: nil)
				}
				strongSelf.imagePickerController?.naviBgColor = UIColor.white
				strongSelf.imagePickerController?.naviTitleColor = UIColor.black
				strongSelf.imagePickerController?.title = "选择图片"
				strongSelf.imagePickerController?.barItemTextColor = UIColor.black
				strongSelf.imagePickerController?.statusBarStyle = .default
				strongSelf.imagePickerController?.navLeftBarButtonSettingBlock = { (button) in
					button!.setImage(UIImage.init(named: "leftbackicon_sdk_login"), for: .normal)
					button!.contentHorizontalAlignment = .left
					button!.removeTarget(nil, action: nil, for: .touchUpInside)
					button!.addTarget(self, action: #selector(self!.clickImagePickViewLeftBtn), for: .touchUpInside)
				}
				let mutableArray = NSMutableArray.init()
				for item in strongSelf.sourceAssets {
					mutableArray.add(item)
				}
				strongSelf.imagePickerController?.selectedAssets = mutableArray
				strongSelf.navigationController?.present(strongSelf.imagePickerController!, animated: true, completion: nil)
				return nil
			}
			return cell
		}
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return UIView.init()
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		if 2 == section {
			let view: UIView = UIView.init()
			view.backgroundColor = .clear
			
			let label: UILabel = UILabel.init()
			label.backgroundColor = .clear
			label.textColor = UIColor.init(red: 0.43, green: 0.43, blue: 0.45, alpha: 1.0)
			label.font = HZFont(fontSize: 13)
			label.text = "添加图片(可选)"
			view.addSubview(label)
			label.snp.makeConstraints { (make) in
				make.top.equalTo(23)
				make.left.equalTo(20)
			}
			return view
		} else {
			return UIView.init()
		}
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 0.00001
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		if 1 == section {
			return 10
		} else if 2 == section {
			return 45
		}
		return 20
	}
}

extension HZCreateTopicViewController : TZImagePickerControllerDelegate {
	func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool) -> Void {
		let cell :HZTopicImageTableViewCell = self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 2)) as! HZTopicImageTableViewCell
		cell.dataSource = photos
		sourceAssets = assets
	}
}



