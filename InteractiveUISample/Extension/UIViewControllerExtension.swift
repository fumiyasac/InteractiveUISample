//
//  UIViewControllerExtension.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/26.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit

//UIViewControllerの拡張
extension UIViewController {

    //戻るボタンの「戻る」テキストを削除した状態にするメソッド
    func removeBackButtonText() {
        let backButtonItem = BackBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController!.navigationBar.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = backButtonItem
    }
}

class BackBarButtonItem: UIBarButtonItem {
    @available(iOS 14.0, *)
    override var menu: UIMenu? {
        set {
            //MEMO: 長押しメニューを消去する
            //Do Nothing.
        }
        get {
            return super.menu
        }
    }
}
