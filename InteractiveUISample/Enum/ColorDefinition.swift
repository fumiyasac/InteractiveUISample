//
//  ColorDefinition.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/13.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit

enum ColorDefinition {
    case navigationColor
    case pointColor

    func getColor() -> UIColor {
        switch self {
        case .navigationColor:
            return UIColor.init(code: "#76B6E2")
        case .pointColor:
            return UIColor.init(code: "#7182FF")
        }
    }
}
