//
//  StoryRelatedHeaderView.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/30.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit

//@IBDesignable
class StoryRelatedHeaderView: CustomViewBase {
    
    //UI部品の配置
    @IBOutlet weak private var storyRelatedHeaderWrappedView: UIView!
    @IBOutlet weak private var storyRelatedHeaderImageView: UIImageView!
    @IBOutlet weak private var storyRelatedHeaderTitleLabel: UILabel!
    @IBOutlet weak private var storyRelatedHeaderDescriptionLabel: UILabel!
    @IBOutlet weak private var storyRelatedHeaderIconImageView: UIImageView!
    
    //アイコンイメージのサイズ設定
    private let iconImageViewSize: CGSize = CGSize(width: 34, height: 34)

    //MARK: - Initializer
    
    //MEMO: ここではXibはあるけれど、コードでも初期化して使いたいのでこのように記載する

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupStoryRelatedHeaderView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupStoryRelatedHeaderView()
    }

    //MARK: - Function

    func setHeader(_ genre: Genre) {
        storyRelatedHeaderTitleLabel.text = genre.title
        storyRelatedHeaderDescriptionLabel.text = genre.introText
    }

    //アイコンの配置を行う
    func initIconImageView(_ isOpen: Bool = false) {
            if isOpen {
                self.storyRelatedHeaderIconImageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
            } else {
                self.storyRelatedHeaderIconImageView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
            }

    }

    //アイコンの回転を行う
    func rotateIconImageView(_ isOpen: Bool = false) {
        UIView.animate(withDuration: 0.16, animations: {
            if isOpen {
                self.storyRelatedHeaderIconImageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
            } else {
                self.storyRelatedHeaderIconImageView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
            }
        })
    }

    //このクラスの初期設定を行う
    private func setupStoryRelatedHeaderView() {

        //アイコンに関する設定
        let angleDownFontImage = UIImage.fontAwesomeIcon(name: .angleDown, style: .solid, textColor: ColorDefinition.pointColor.getColor(), size: iconImageViewSize)
        storyRelatedHeaderIconImageView.backgroundColor = UIColor.clear
        storyRelatedHeaderIconImageView.image = angleDownFontImage
    }
}
