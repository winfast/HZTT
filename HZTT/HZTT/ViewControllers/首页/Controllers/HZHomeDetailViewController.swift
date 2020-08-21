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

class HZHomeDetailViewController: HZBaseViewController {
	
	var tableView: UITableView!
	var iconImageView: UIImageView!
	var pid: String!
	var category: String!
	@objc dynamic var cellViewModel: HZHomeCellViewModel?
	var commentDataArray: [HZCommentCellViewModel]! = []
	var disposeBag = DisposeBag()
	
	init(_ pid: String!, category: String! = "sy") {
		super.init(nibName: nil, bundle: nil)
		self.pid = pid
		self.category = category;
	}
	
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
		
        // Do any additional setup after loading the view.
		self.tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.backgroundColor = UIColor.white
		self.tableView.separatorStyle = .none
		self.tableView.rowHeight = UITableView.automaticDimension
		self.tableView.estimatedRowHeight = 150
		self.tableView.register(HZHomeDetailTableViewCell.self, forCellReuseIdentifier: "HZHomeDetailTableViewCell")
		self.tableView.register(HZCommentTableViewCell.self, forCellReuseIdentifier: "HZCommentTableViewCell")
		self.view.addSubview(self.tableView!)
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(0)
		}
		self.tableView.ex_prepareToShow()
		self.dataRequest()
		self.createRAC()
		
		let footer: MJRefreshAutoNormalFooter = MJRefreshAutoNormalFooter.init(refreshingBlock: { [weak self] in
			self?.commentDataRequest((self?.commentDataArray!.count)!/20 == 0 ? 1 : (self?.commentDataArray!.count)!/20)
		})
		footer.setTitle("已经是最后一条了", for: .noMoreData)
		self.tableView.mj_footer = footer
		
		self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
			self?.tableView.mj_footer.state = .idle
			self?.commentDataRequest()
		});
    }
	
	func dataRequest() -> Void {
		self.detailDataRequest()
		self.commentDataRequest()
	}

	func createRAC() -> Void {
		self.rx.observe(String.self, "cellViewModel.avatar_thumb").distinctUntilChanged().subscribe(onNext: { [weak self] (value :String?) in
			if value?.lengthOfBytes(using: .utf8) ?? 0 > 0 {
				self?.iconImageView.kf.setImage(with: URL.init(string: value!))
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
			
			self?.tableView.reloadData()
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
	
	func showComplainViewController(_commentId: String? = nil) -> Void {
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
			let cell: HZHomeDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HZHomeDetailTableViewCell") as! HZHomeDetailTableViewCell
			cell.viewModel = self.cellViewModel
			cell.clickBtnBlock = { [weak self] (button: UIButton?)->Void in
				guard let weakself = self else {
					return
				}
				if button?.tag == 0 {
					
				} else {
					weakself.showComplainViewController()
				}
			}
			return cell
		} else {
			let cell: HZCommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HZCommentTableViewCell") as! HZCommentTableViewCell
			cell.viewModel = self.commentDataArray[indexPath.row]
			cell.clickComplainBlock = { [weak self] (button: UIButton?) -> Void in
				guard let weakSelf = self else {
					return
				}
				weakSelf.showComplainViewController()
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
