//
//  HZFeedbackViewController.swift
//  HZTT
//
//  Created by QinChuancheng on 2020/9/13.
//  Copyright © 2020 Galanz. All rights reserved.
//

import UIKit


class HZFeedbackViewController: HZBaseViewController {
    var bgView: UIView!
    var textView: IQTextView!
    var maxLenthLabel: UILabel!
    var lookAnthorFeedbackBtn: UIButton!
    
    let disposeBag: DisposeBag = DisposeBag.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewsLayout()
    }
    
    func viewsLayout() -> Void {
		self.navigationItem.title = "意见反馈"
        self.view.backgroundColor = UIColor.init(red:244/255.0, green: 245/255.0, blue: 247/255.0, alpha: 1)
        
        let rightbtn = UIButton (frame: CGRect (x: 0, y: 0, width: 40, height: 30))
        rightbtn.setTitle("提交", for: .normal)
        rightbtn.setTitleColor(UIColor.darkGray , for: .normal)
        rightbtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        rightbtn.rx.tap
            .subscribe(onNext: { [weak self] () in
                //提交意见反馈
				guard let weakself = self else {
					return
				}
				weakself.view.endEditing(true)
				//提交反馈
				
				let content = weakself.textView.text
				if content?.lengthOfBytes(using: .utf8) == 0 {
					MBProgressHUD.showHub("输入内容不能为空")
				}
				
				guard let userId = HZUserInfo.share().user_id else {
					return
				}
				
				let d = ["content" : content , "type":"add", "uid": userId]
				weakself.feedback(d as [String : Any])
            })
            .disposed(by: disposeBag)
        let rightitem = UIBarButtonItem.init(customView: rightbtn)
        self.navigationItem.rightBarButtonItem = rightitem
        
        self.bgView = UIView.init()
        self.bgView.backgroundColor = .white
        self.view.addSubview(self.bgView)
        self.bgView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(0);
            make.height.equalTo(160)
            make.top.equalTo(35)
        }
        
		self.textView = IQTextView.init()
        self.textView.backgroundColor = UIColor.white
        self.textView.font = HZFont(fontSize: 15)
		self.textView.delegate = self
		self.textView.placeholder = "请输入内容"
        self.bgView.addSubview(self.textView)
        self.textView.snp.makeConstraints { (make) in
            make.leading.equalTo(15)
            make.trailing.equalTo(15)
            make.top.equalTo(0)
            make.bottom.equalTo(self.bgView.snp.bottom).offset(-40)
        }
        
        self.maxLenthLabel = UILabel.init()
        self.maxLenthLabel.textColor = UIColor.lightGray
        self.maxLenthLabel.text = "200个字以内"
        self.maxLenthLabel.font = HZFont(fontSize: 15)
        self.bgView.addSubview(self.maxLenthLabel!)
        self.maxLenthLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.bgView.snp.right).offset(-30)
			make.bottom.equalTo(self.bgView.snp.bottom).offset(-11)
        })
        
        self.lookAnthorFeedbackBtn = UIButton.init(type: .custom)
        self.lookAnthorFeedbackBtn.setTitle("看看大伙说的啥", for: .normal)
        self.lookAnthorFeedbackBtn.setTitleColor(.white, for: .normal)
        self.lookAnthorFeedbackBtn.titleLabel?.font = HZFont(fontSize: 15)
		self.lookAnthorFeedbackBtn.backgroundColor = .red
        self.view.addSubview(self.lookAnthorFeedbackBtn)
        self.lookAnthorFeedbackBtn.rx.tap
            .subscribe(onNext: { [weak self] () in
                guard let weakself = self else {
                    return
                }
                
                let vc = HZWebViewController.init()
				vc.url = "p/feedbackList.html"
				vc.navigationItem.title = "最新留言"
                weakself.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
		self.lookAnthorFeedbackBtn.snp.makeConstraints { (make) in
			make.leading.trailing.equalTo(0)
			make.height.equalTo(50)
			if #available(iOS 11.0, *) {
				make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(0)
			} else {
				make.bottom.equalTo(self.view.snp.bottom).offset(0)
			}
		}
    }
	
	func feedback(_ param: [String:Any]) -> Void {
		func dataRequest(_ pageNumber: Int? = 1) -> Void {
			HZMeProfileNetwordManager.shared.feedback(param).subscribe(onNext: { [weak self] (value) in
				guard let weakself = self else {
					return
				}
				
				MBProgressHUD.showHub("提交成功,再次感谢您的支持和关注")
				weakself.navigationController?.popViewController(animated: true)
			}).disposed(by: disposeBag)
		}
	}
}

extension HZFeedbackViewController : UITextViewDelegate {
	func textViewDidChange(_ textView: UITextView) {
		let text = textView.text
		if (text?.lengthOfBytes(using: .utf8))! > 200 {
			textView.text = String(text!.suffix(200))
		}
	}
}
