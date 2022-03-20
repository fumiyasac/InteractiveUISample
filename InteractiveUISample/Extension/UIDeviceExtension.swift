//
//  UIDeviceExtension.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2022/03/21.
//  Copyright © 2022 酒井文也. All rights reserved.
//

import Foundation

extension UIDevice {
    func hasNotch() -> Bool {
        if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }), keyWindow.safeAreaInsets.bottom > 0 {
            return true
        }
        return false
    }
}
