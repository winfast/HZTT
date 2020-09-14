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
            make.right.equalTo(self.textView.snp.right).offset(-30)
			make.bottom.trailing.equalTo(self.bgView.snp.trailingMargin).offset(-11)
            make.top.equalTo(self.textView.snp.bottomMargin)
        })
        
        self.lookAnthorFeedbackBtn = UIButton.init(type: .custom)
        self.lookAnthorFeedbackBtn.setTitle("看看大伙说的啥", for: .normal)
        self.lookAnthorFeedbackBtn.setTitleColor(.white, for: .normal)
        self.lookAnthorFeedbackBtn.titleLabel?.font = HZFont(fontSize: 15)
        self.view.addSubview(self.lookAnthorFeedbackBtn)
        self.lookAnthorFeedbackBtn.rx.tap
            .subscribe(onNext: { [weak self] () in
                guard let weakself = self else {
                    return
                }
                
                let vc = HZFeedbackListViewController.init()
                weakself.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
		self.lookAnthorFeedbackBtn.snp.makeConstraints { (make) in
			make.leading.trailing.equalTo(10)
			make.height.equalTo(50)
			if #available(iOS 11.0, *) {
				make.bottom.equalTo(self.bgView.safeAreaLayoutGuide.snp.bottom).offset(0)
			} else {
				make.bottom.equalTo(self.bgView.snp.bottom).offset(0)
			}
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
