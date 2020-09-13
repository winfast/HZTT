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
            .subscribe(onNext: { () in
                //保存
            })
            .disposed(by: disposeBag)
        let rightitem = UIBarButtonItem.init(customView: rightbtn)
        self.navigationItem.rightBarButtonItem = rightitem
        
        self.bgView = UIView.init()
        self.bgView.backgroundColor = .white
        self.view.addSubview(self.bgView)
        self.bgView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(0);
            make.height.equalTo(200)
            make.top.equalTo(20)
        }
        
        self.textView.backgroundColor = UIColor.white
        self.textView.font = HZFont(fontSize: 15)
        self.view.addSubview(self.textView)
        self.textView.snp.makeConstraints { (make) in
            make.leading.equalTo(15)
            make.trailing.equalTo(15)
            make.top.equalTo(0)
            make.bottom.equalTo(self.bgView.snp.bottom).offset(20)
        }
        
        self.maxLenthLabel = UILabel.init()
        self.maxLenthLabel.textColor = UIColor.lightGray
        self.maxLenthLabel.text = "200个字以内"
        self.maxLenthLabel.font = HZFont(fontSize: 15)
        self.view.addSubview(self.maxLenthLabel!)
        self.maxLenthLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.textView.snp.right).offset(-30)
            make.bottom.lessThanOrEqualTo(-5).priority(900)
            make.top.equalTo(self.textView.snp.bottom)
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
