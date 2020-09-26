//
//  MBProgressHudToast.swift
//  HZTT
//
//  Created by Sam on 2020/8/24.
//  Copyright © 2020 Galanz. All rights reserved.
//

import Foundation
import UIKit

extension MBProgressHUD {
    class func showToast(_ text : String, inView : UIView?) {
        if text == "" {
            return
        }
        var view = inView
        if view == nil {
            view = UIApplication.shared.windows.last!
        }
        let hud = MBProgressHUD.showAdded(to: view!, animated: true)
        hud.mode = .text
        hud.label.text = text
        hud.removeFromSuperViewOnHide = true
		hud.bezelView.backgroundColor = UIColor.black
        hud.contentColor = UIColor.white
		hud.offset = CGPoint.init(x: 0, y: -30)
		hud.hide(animated: true, afterDelay: 1.5)
    }
	
	class func showHub(_ text: String, inView: UIView? = UIApplication.shared.keyWindow) -> Void {
		MBProgressHUD.dismissHudView(inView!)
		let hub = MBProgressHUD.showAdded(to: inView!, animated: true)
		hub.label.text = text
		hub.contentColor = .white
		hub.isUserInteractionEnabled = false
		hub.bezelView.style = MBProgressHUDBackgroundStyle.solidColor
		hub.bezelView.color = UIColor.init(white: 0, alpha: 0.8)
		hub.removeFromSuperViewOnHide = true
		//let image = UIImage.init(named: @"")
		hub.mode = MBProgressHUDMode.indeterminate
	}
	
	class func dismissHudView(_ view: UIView) {
		MBProgressHUD.hide(for: view, animated: true)
	}
    
}
