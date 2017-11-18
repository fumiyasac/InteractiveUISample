//
//  DeviceSize.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/18.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation

struct DeviceSize {

    //CGRectを取得
    static func bounds() -> CGRect {
        return UIScreen.main.bounds
    }

    //画面の横サイズを取得
    static func screenWidth() -> Int {
        return Int(self.bounds().width)
    }

    //画面の縦サイズを取得
    static func screenHeight() -> Int {
        return Int(self.bounds().height)
    }

    //iPhoneXのサイズとマッチしているかを返す
    static func sizeOfIphoneX() -> Bool {
        return (self.screenWidth() == 375 && self.screenHeight() == 812)
    }
}
