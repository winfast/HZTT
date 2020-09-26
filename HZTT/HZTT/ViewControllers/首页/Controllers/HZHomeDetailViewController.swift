//
//  HZHomeDetailViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/8/20.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import MJRefresh
import SKPhotoBrowser

class HZHomeDetailViewController: HZBaseViewController {
	
	var tableView: UITableView!
	var iconImageView: UIImageView!
	var pid: String!
	var category: String!
	var commentDataArray: [HZCommentCellViewModel]! = []
	var disposeBag = DisposeBag()
	
	//底部
	var addCommentBtn: UIButton?
	var showCommentLabel: UIButton?
	var commentBadgeLabel: UILabel?
	var likeBtn: UIButton?
	
	@objc dynamic var cellViewModel: HZHomeCellViewModel?
	
	init(_ pid: String!, category: String! = "sy") {
		super.init(nibName: nil, bundle: nil)
		self.pid = pid
		self.category = category;
	}
	
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	deinit {
		print("deinit " + NSStringFromClass(self.classForCoder))
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.white
		
		let bgView = UIView.init()
		bgView.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44);
		iconImageView = UIImageView.init(image: UIImage.init(named: "avatar_default"))
		iconImageView.frame = CGRect.init(x: 7, y: 7, width: 30, height: 30);
		iconImageView.layer.cornerRadius = 15;
		iconImageView.layer.masksToBounds = true
		iconImageView.isHidden = true
		bgView.addSubview(iconImageView)
		self.navigationItem.titleView = bgView;
		
		let rightBtn: UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "more_toolbar_press"), style: UIBarButtonItem.Style.done, target: self, action: #selector(clickRightBtn))
		self.navigationItem.rightBarButtonItem = rightBtn
		
		let toolBar: UIToolbar = UIToolbar.init()
		toolBar.barTintColor = UIColor (red: 250/255.0, green: 251/255.0, blue: 253/255.0, alpha: 1)
		self.view.addSubview(toolBar)
		toolBar.snp.makeConstraints { (make) in
			make.bottom.left.right.equalTo(0)
			if HZStatusBarHeight() > 20.0 {
				make.height.equalTo(49 + 34)
				
			} else {
				make.height.equalTo(49)
			}
		}
		self.toolBarLayout(toolBar)
		
        // Do any additional setup after loading the view.
		self.tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.backgroundColor = UIColor.white
		self.tableView.separatorStyle = .none
		self.tableView.rowHeight = UITableView.automaticDimension
		self.tableView.estimatedRowHeight = 150
		self.tableView.register(HZHomeDetailTableViewCell.self, forCellReuseIdentifier: "HZHomeDetailTableViewCell")
		self.tableView.register(HZLivelihoodDetailTableViewCell.self, forCellReuseIdentifier: "HZLivelihoodDetailTableViewCell")
		self.tableView.register(HZCommentTableViewCell.self, forCellReuseIdentifier: "HZCommentTableViewCell")
		self.view.addSubview(self.tableView!)
		self.tableView.snp.makeConstraints { (make) in
			make.top.left.right.equalTo(0)
			make.bottom.equalTo(toolBar.snp.top).offset(-1)
		}
		
		let footer: MJRefreshAutoNormalFooter = MJRefreshAutoNormalFooter.init(refreshingBlock: { [weak self] in
			self?.commentDataRequest((self?.commentDataArray!.count)!/20 == 0 ? 1 : (self?.commentDataArray!.count)!/20)
		})
		footer.setTitle("已经是最后一条了", for: .noMoreData)
		self.tableView.mj_footer = footer
		
		self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
			self?.tableView.mj_footer.state = .idle
			self?.commentDataRequest()
		});
		

		self.tableView.ex_prepareToShow()
		self.dataRequest()
		self.createRAC()
    }

	func toolBarLayout(_ toolBar: UIToolbar) -> Void {
		
		var height = 49;
		if HZStatusBarHeight() > 20.0 {
			height = 49 + 34
		}
		
		self.addCommentBtn = UIButton.init(type: .custom)
		self.addCommentBtn?.frame = CGRect.init(x: 0, y: 10, width: 120, height: height - 10 * 2)
		self.addCommentBtn?.setTitle("我要评论...", for: .normal)
		self.addCommentBtn?.setTitleColor(UIColor.darkGray, for: .normal)
		self.addCommentBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		self.addCommentBtn?.layer.cornerRadius = 5
		self.addCommentBtn?.layer.masksToBounds = true
		self.addCommentBtn?.backgroundColor = UIColor.white
		self.addCommentBtn?.setImage(UIImage (named: "writeicon_review_dynamic"), for: .normal);
		self.addCommentBtn?.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 50)
		self.addCommentBtn?.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -10, bottom: 0, right: 0)
		self.addCommentBtn?.tag = 100
		self.addCommentBtn?.addTarget(self, action: #selector(clickAddCommentBtn), for: .touchUpInside)
		let addCommentItem = UIBarButtonItem.init(customView: self.addCommentBtn!)
		
		self.showCommentLabel = UIButton (frame: CGRect (x: 0, y: 0, width: 60, height: height))
		showCommentLabel?.setTitleColor(UIColor.darkGray, for: .normal)
		showCommentLabel?.layer.cornerRadius = 5
		showCommentLabel?.layer.masksToBounds = true
		showCommentLabel?.clipsToBounds = false
		showCommentLabel?.setImage(UIImage (named: "tab_comment"), for: .normal);
		showCommentLabel?.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
		showCommentLabel?.tag = 101
		
		self.commentBadgeLabel = UILabel.init()
		self.commentBadgeLabel?.backgroundColor = UIColor (red: 236/255.0, green: 82/255.0, blue: 82/255.0, alpha: 1)
		self.commentBadgeLabel?.text = ""
		self.commentBadgeLabel?.textColor = .white
		self.commentBadgeLabel?.font = HZFont(fontSize: 8)
		self.commentBadgeLabel?.textAlignment = .center
		self.commentBadgeLabel?.layer.cornerRadius = 5;
		self.commentBadgeLabel?.isHidden = true
		self.commentBadgeLabel?.layer.masksToBounds = true
		showCommentLabel?.addSubview(self.commentBadgeLabel!)

		
		let showCommentItem = UIBarButtonItem.init(customView: self.showCommentLabel!)
		
		let spaceItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
		//收藏
		self.likeBtn = UIButton (frame: CGRect (x: 0, y: 0, width: 80, height: height))
        likeBtn?.setImage(UIImage (named: "likeicon_actionbar_details"), for: .normal)
        likeBtn?.setImage(UIImage (named: "likeicon_actionbar_details_press"), for: .selected)
        likeBtn?.imageEdgeInsets = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 45)
        likeBtn?.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 2, bottom: 0, right: 0)
        likeBtn?.setTitle("收藏", for: .normal)
        likeBtn?.setTitle("已收藏", for: .selected)
        likeBtn?.setTitleColor(UIColor.darkGray, for: .normal)
        likeBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        likeBtn?.tag = 102
		likeBtn?.addTarget(self, action:#selector(clickLikeBtn) , for: .touchUpInside)
		let likeItem = UIBarButtonItem (customView: likeBtn!)
		
		toolBar.items = [addCommentItem, showCommentItem, spaceItem, likeItem]
	}
	
	func dataRequest() -> Void {
		self.detailDataRequest()
		self.commentDataRequest()
	}

	func createRAC() -> Void {
		self.rx.observeWeakly(String.self, "cellViewModel.avatar_thumb").distinctUntilChanged().subscribe(onNext: { [weak self] (value :String?) in
			guard let weakself = self else {
				return
			}
			if value?.lengthOfBytes(using: .utf8) ?? 0 > 0 {
				weakself.iconImageView.kf.setImage(with: URL.init(string: value!))
			}
		}).disposed(by: disposeBag)
		
		self.rx.observeWeakly(String.self, "cellViewModel.sc").distinctUntilChanged().subscribe(onNext: { [weak self] (value :String?) in
			guard let weakself = self else {
				return
			}
			if value?.lengthOfBytes(using: .utf8) ?? 0 > 0 {
				weakself.likeBtn?.isSelected = value == "1"
			}
		}).disposed(by: disposeBag)
	}
	
	func commentDataRequest(_ pageNumber: Int = 1) -> Void {
		if 1 == pageNumber {
			self.commentDataArray.removeAll()
		}
		let param = ["pid":self.pid!,
					 "category":self.category!,
					 "type":"get",
					 "pageNumber":pageNumber
			] as [String : Any]
		
		HZHomeDetailNetworkManager.shared.comment(param).subscribe(onNext: { [weak self] (value :[HZCommentCellViewModel]) in
			if self?.tableView.mj_header?.isRefreshing() == true {
				self?.tableView.mj_header?.endRefreshing()
			}
			
			if self?.tableView.mj_footer?.isRefreshing() == true {
				self?.tableView.mj_footer?.endRefreshing()
			}

			self?.commentDataArray = (self?.commentDataArray)! + value;
			if self?.commentDataArray.count == 0 {
				self?.tableView.mj_footer.state = .noMoreData
			} else {
				if value.count < 20 {
					self?.tableView.mj_footer.state = .noMoreData
				} else {
					self?.tableView.mj_footer.state = .idle
				}
			}
			self?.tableView.reloadData()
			
			if self?.commentDataArray.count == 0 {
				self?.commentBadgeLabel?.isHidden = true
			} else {
				self?.commentBadgeLabel?.isHidden = false
				let count = (self?.commentDataArray!.count)!;
				var badgeValue :String!
				if count > 99 {
					badgeValue = "99+"
				} else {
					badgeValue = String.init(format: "%d", count)
				}
				let attrDict = [NSAttributedString.Key.font: self?.commentBadgeLabel?.font]
				let attrValue = NSAttributedString.init(string: badgeValue, attributes: attrDict as [NSAttributedString.Key : Any])
				let fontSize = attrValue.size()
				self?.commentBadgeLabel!.text = badgeValue
				self?.commentBadgeLabel!.frame = CGRect.init(x: 35.0, y: 13.0, width: fontSize.width + 5.0, height: 10.0)
			}
			
			}, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
	}
	
	func detailDataRequest() -> Void {
		let param = ["pid":self.pid!,
					 "category":self.category!,
					 "type":"0",
			] as [String : Any]
		
		HZHomeDetailNetworkManager.shared.detail(param).subscribe(onNext: { [weak self] (value :HZHomeCellViewModel) in
			self?.tableView.ex_makeViewVisible()
			self?.cellViewModel = value
			self?.tableView.reloadData()
			}, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
	}
	
	func showComplainViewController(_ commentId: String? = nil) -> Void {
		let vc = HZComplainViewController.init()
		let navigation = HZNavigationController.init(rootViewController: vc)
		self.navigationController?.present(navigation, animated: true, completion: nil)
	}
	
	@objc func clickRightBtn(_ sender: UIBarButtonItem) -> Void {
		let alertController: UIAlertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
		let aciton: UIAlertAction = UIAlertAction.init(title: "举报", style: .default) { [weak self] (action) in
			guard let weakself = self else {return}
			weakself.showComplainViewController()
		}
		
		let cancelAciont: UIAlertAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
		alertController.addAction(aciton)
		alertController.addAction(cancelAciont)
		self.navigationController?.present(alertController, animated: true, completion: nil)
	}
	
	@objc func clickAddCommentBtn() -> Void {
		//添加评论
		let addCommentView = HZAddCommentView.init()
		addCommentView.show(view: UIApplication.shared.keyWindow!)
	}
	
	@objc func clickLikeBtn() -> Void {
		
	}
}

extension HZHomeDetailViewController :UITableViewDelegate, UITableViewDataSource {
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let contentOffset: CGPoint = scrollView.contentOffset
		self.iconImageView.isHidden = contentOffset.y > 30 ? false : true
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return 1
		}
		return self.commentDataArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			if self.category == "sy" {
				let cell: HZHomeDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HZHomeDetailTableViewCell") as! HZHomeDetailTableViewCell
				
				cell.viewModel = self.cellViewModel
				cell.clickBtnBlock = { [weak self] (button: UIView?)->Void in
					guard let weakself = self else {
						return
					}
					if (button?.tag)! >= 100 {
						//进入Brower
						var images :[SKPhoto] = []
						for imagePathItem in weakself.cellViewModel!.images! {
							let photo = SKPhoto.photoWithImageURL(imagePathItem)
							images.append(photo)
						}

						SKPhotoBrowserOptions.enableZoomBlackArea = false
						SKPhotoBrowserOptions.displayAction = false   //隐藏ToolBar
						SKPhotoBrowserOptions.displayBackAndForwardButton = false
						//SKPhotoBrowserOptions.displayToolbar = false
						let imageView = button as! UIImageView
						let browser = SKPhotoBrowser.init(originImage: imageView.image!, photos: images, animatedFromView: imageView)
						browser.currentPageIndex = (button?.tag)! - 100
						weakself.present(browser, animated: true, completion: nil)
					} else {
						if button?.tag == 0 {

						} else {
							weakself.showComplainViewController()
						}
					}
				}
				
				return cell
			} else  {
				let cell: HZLivelihoodDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HZLivelihoodDetailTableViewCell") as! HZLivelihoodDetailTableViewCell
				cell.viewModel = self.cellViewModel
				cell.clickBtnBlock = { [weak self] (button: UIView?) -> Void in
					guard let weakself = self else {
						return
					}
					if (button?.tag)! >= 100 {
						//进入Brower
						var images :[SKPhoto] = []
						for imagePathItem in weakself.cellViewModel!.images! {
							let photo = SKPhoto.photoWithImageURL(imagePathItem)
							images.append(photo)
						}
						
						SKPhotoBrowserOptions.enableZoomBlackArea = false
						SKPhotoBrowserOptions.displayAction = false   //隐藏ToolBar
						SKPhotoBrowserOptions.displayBackAndForwardButton = false
						//SKPhotoBrowserOptions.displayToolbar = false
						let imageView = button as! UIImageView
						let browser = SKPhotoBrowser.init(originImage: imageView.image!, photos: images, animatedFromView: imageView)
						browser.currentPageIndex = (button?.tag)! - 100
						weakself.present(browser, animated: true, completion: nil)
					} else {
						if button?.tag == 0 {
							
						} else {
							weakself.showComplainViewController()
						}
					}
					
				}
				return cell
			}
		} else {
			let cell: HZCommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HZCommentTableViewCell") as! HZCommentTableViewCell
			cell.viewModel = self.commentDataArray[indexPath.row]
			cell.clickComplainBlock = { [weak self] (button: UIButton?) -> Void in
				guard let weakSelf = self else {
					return
				}
				weakSelf.showComplainViewController(cell.viewModel!.ID)
			}
			return cell
		}
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		if 0 == section {
			return nil;
		} else {
			let headerView = UIView.init()
			headerView.backgroundColor = UIColor.white
			let titleLabel = UILabel.init()
			titleLabel.text = "全部评论"
			titleLabel.font = HZFont(fontSize: 12)
			titleLabel.textColor = UIColorWith24Hex(rgbValue: 0xB7B7B7)
			headerView.addSubview(titleLabel);
			titleLabel.snp.makeConstraints { (make) in
				make.left.equalTo(10)
				make.centerY.equalTo(headerView.snp.centerY);
			}
			return headerView
		}
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		if 0 == section {
			return 0.00001
		} else {
			return 44
		}
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let footerView = UIView.init()
		footerView.backgroundColor = UIColorWith24Hex(rgbValue: 0 == section ? 0xF0F0F5 : 0xFFFFFF)
		return footerView
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		if 0 == section {
			return 3.0
		} else {
			return 20
		}
	}
}
