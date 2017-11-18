//
//  GradientHeaderView.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/13.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit

class GradientHeaderView: CustomViewBase {

    //UI部品の配置
    @IBOutlet weak var headerBackButton: UIButton!

    @IBOutlet weak private var headerWrappedViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak private var headerTitle: UILabel!

    private let defaultHeaderMargin: CGFloat = DeviceSize.sizeOfIphoneX() ? 44 : 20

    //MARK: - Function

    //ダミーのヘッダー内にあるタイトルをセットする
    func setTitle(_ title: String?) {
        headerTitle.text = title
    }

    //ダミーのヘッダーの上方向の制約を更新する
    //[変数] constarint = (テーブルビューのヘッダー画像の高さ) - (NavigationBarの高さを引いたもの) - (テーブルビュー側の縦方向のスクロール量)
    func setHeaderNavigationTopConstraint(_ constant: CGFloat) {
        if constant > 0 {
            headerWrappedViewTopConstraint.constant = defaultHeaderMargin + constant
        } else {
            headerWrappedViewTopConstraint.constant = defaultHeaderMargin
        }
        self.layoutIfNeeded()
    }
}
