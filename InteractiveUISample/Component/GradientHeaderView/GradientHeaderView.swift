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
    @IBOutlet weak private var headerWrappedViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak private var headerTitle: UILabel!
    @IBOutlet weak private var headerBackButton: UIButton!

    private let DEAFAULT_HEADER_MARGIN: CGFloat = 20

    //ヘッダーのボタンをタップした際に実行されるクロージャー
    var headerBackButtonAction: (() -> ())?

    //MARK: - Function

    //ダミーのヘッダー内にあるタイトルをセットする
    func setTitle(_ title: String?) {
        headerTitle.text = title
    }
    
    //ダミーのヘッダーの上方向の制約を更新する
    //[変数] constarint = (テーブルビューのヘッダー画像の高さ) - (NavigationBarの高さを引いたもの) - (テーブルビュー側の縦方向のスクロール量)
    func setHeaderNavigationTopConstraint(_ constant: CGFloat) {
        if constant > 0 {
            headerWrappedViewTopConstraint.constant = DEAFAULT_HEADER_MARGIN + constant
        } else {
            headerWrappedViewTopConstraint.constant = DEAFAULT_HEADER_MARGIN
        }
        self.layoutIfNeeded()
    }

    //MARK: - Private Function

    @objc private func headerBackButtonTapped(sender: UIButton) {
        headerBackButtonAction?()
    }

    private func setupHeaderBackButton() {
        headerBackButton.addTarget(self, action: #selector(self.headerBackButtonTapped(sender:)), for: [.touchUpInside, .touchUpOutside])
    }
}
