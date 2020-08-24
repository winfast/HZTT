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
    class func showToast(_ text : String, inView : UIView) {
        if text == "" {
            return
        }
        var view = inView
        if view == nil {
            view = UIApplication.shared.windows.last!
        }
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = text
        hud.removeFromSuperViewOnHide = true
        
        hud.hide(animated: true, afterDelay: 2.0)

    }
    
}
