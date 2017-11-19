//
//  ArticleCounterTableViewCell.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/19.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import UIKit

class ArticleCounterTableViewCell: UITableViewCell {

    //UI部品の配置
    @IBOutlet weak private var viewsCounterLabel: CounterAnimationLabel!
    @IBOutlet weak private var likesCounterLabel: CounterAnimationLabel!

    //カウンターアニメーションの時間設定
    private let counterAnimationLabelDuration: TimeInterval = 2.0

    //MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()

        setupArticleCounterTableViewCell()
    }

    //MARK: - Function

    func setCell(_ article: Article) {
        viewsCounterLabel.changeCountValueWithAnimation(Float(article.viewsCounter), withDuration: counterAnimationLabelDuration, andAnimationType: .EaseOut, andCounterType: .Int)
        likesCounterLabel.changeCountValueWithAnimation(Float(article.likesCounter), withDuration: counterAnimationLabelDuration, andAnimationType: .EaseOut, andCounterType: .Int)
    }

    //MARK: - Private Function

    private func setupArticleCounterTableViewCell() {

        //セルの装飾設定をする
        self.accessoryType  = .none
        self.selectionStyle = .none

        //viewsおよびcounterの初期値を設定する
        viewsCounterLabel.text = "0"
        viewsCounterLabel.textColor = ColorDefinition.pointColor.getColor()
        likesCounterLabel.text = "0"
        likesCounterLabel.textColor = ColorDefinition.pointColor.getColor()
    }
}
