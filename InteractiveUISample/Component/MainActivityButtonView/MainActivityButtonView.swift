//
//  MainActivityButtonView.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/19.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit
//TODO: アクション等は後ほど余力があれば実装

//@IBDesignable
class MainActivityButtonView: CustomViewBase {

    //UI部品の配置
    @IBOutlet weak var plainButtonWrappedView: UIView!
    @IBOutlet weak var plainButtonImage: UIImageView!
    @IBOutlet weak var travelButtonWrappedView: UIView!
    @IBOutlet weak var travelButtonImage: UIImageView!
    @IBOutlet weak var gourmentButtonWrappedView: UIView!
    @IBOutlet weak var gourmentButtonImage: UIImageView!

    //角丸のサイズ設定
    private let buttonCornerRadius: CGFloat = 45.0

    //アイコンイメージのサイズ設定
    private let iconImageViewSize: CGSize = CGSize(width: 50, height: 50)

    //MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupMainActivityButtonView()
    }

    //MARK: - Private Function

    private func setupMainActivityButtonView() {

        //ボタンに関する設定
        plainButtonWrappedView.layer.cornerRadius = buttonCornerRadius
        plainButtonWrappedView.layer.masksToBounds = true

        travelButtonWrappedView.layer.cornerRadius = buttonCornerRadius
        travelButtonWrappedView.layer.masksToBounds = true

        gourmentButtonWrappedView.layer.cornerRadius = buttonCornerRadius
        gourmentButtonWrappedView.layer.masksToBounds = true

        //アイコンイメージの作成
        let plainFontImage = UIImage.fontAwesomeIcon(name: .plane, style: .solid, textColor: UIColor.white, size: iconImageViewSize)
        plainButtonImage.backgroundColor = UIColor.clear
        plainButtonImage.image = plainFontImage

        let travelFontImage = UIImage.fontAwesomeIcon(name: .briefcase, style: .solid, textColor: UIColor.white, size: iconImageViewSize)
        travelButtonImage.backgroundColor = UIColor.clear
        travelButtonImage.image = travelFontImage

        let gourmentFontImage = UIImage.fontAwesomeIcon(name: .utensilSpoon, style: .solid, textColor: UIColor.white, size: iconImageViewSize)
        gourmentButtonImage.backgroundColor = UIColor.clear
        gourmentButtonImage.image = gourmentFontImage
    }
}
