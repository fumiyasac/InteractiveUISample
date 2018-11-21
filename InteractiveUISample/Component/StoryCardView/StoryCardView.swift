//
//  StoryCardView.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/25.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit

//@IBDesignable
class StoryCardView: CustomViewBase {

    //UI部品の配置
    @IBOutlet weak var storyCardWrappedView: UIView!

    @IBOutlet private weak var storyThumbnailImageView: UIImageView!
    @IBOutlet private weak var storyChapterLabel: UILabel!
    @IBOutlet private weak var storyUpdateDateLabel: UILabel!
    @IBOutlet private weak var storyTitleLabel: UILabel!
    
    @IBOutlet private weak var storyEvaluationLabel: UILabel!
    @IBOutlet private weak var storyEvaluationImageView: UIImageView!
    @IBOutlet private weak var storyRankingLabel: UILabel!
    @IBOutlet private weak var storyRankingImageView: UIImageView!
    @IBOutlet private weak var storyCommentLabel: UILabel!
    @IBOutlet private weak var storyCommentImageView: UIImageView!

    @IBOutlet private weak var storyDescriptionLabel: UILabel!
    @IBOutlet private weak var storyDescriptionTextLabel: UILabel!

    //アイコンイメージのサイズ設定
    private let iconImageViewSize: CGSize = CGSize(width: 24, height: 24)

    //ViewControllerへ処理内容を引き渡すためのクロージャー
    var showStoryDetailAction: (() -> ())?

    //MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()

        setupStoryCardView()
    }

    //MARK: - Function

    func setStory(_ story: Story) {
        storyThumbnailImageView.image = story.photo
        storyChapterLabel.text        = story.chapter
        storyUpdateDateLabel.text     = story.publishedAt
        storyTitleLabel.text          = story.title
        storyEvaluationLabel.text     = story.evaluation
        storyRankingLabel.text        = story.ranking
        storyCommentLabel.text        = story.comment

        //概要の行の高さを調節する
        let summaryParagraphStyle = NSMutableParagraphStyle.init()
        summaryParagraphStyle.minimumLineHeight = 20
        let summaryAttributedText = NSMutableAttributedString.init(string: story.summary)
        summaryAttributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: summaryParagraphStyle, range: NSMakeRange(0, summaryAttributedText.length))
        storyDescriptionTextLabel.attributedText = summaryAttributedText
    }

    //MARK: - Private Function

    private func setupStoryCardView() {

        //サムネイル画像のclipsToBoundsをtrueにする
        storyThumbnailImageView.clipsToBounds = true

        //背景に影をつける
        storyCardWrappedView.layer.shadowRadius = 5
        storyCardWrappedView.layer.shadowOpacity = 0.2
        storyCardWrappedView.layer.shadowOffset = CGSize(width: 0, height: 1)
        storyCardWrappedView.layer.shadowColor = UIColor.black.cgColor
        storyCardWrappedView.layer.masksToBounds = false

        //Chapterの表示用ラベルに角丸と色をつける
        storyChapterLabel.textColor = UIColor.white
        storyChapterLabel.backgroundColor = ColorDefinition.pointColor.getColor()
        storyChapterLabel.layer.cornerRadius = 2.5
        storyChapterLabel.layer.masksToBounds = true

        //概要の表示用ラベルに角丸と色をつける
        storyDescriptionLabel.textColor = UIColor.white
        storyDescriptionLabel.backgroundColor = ColorDefinition.pointColor.getColor()
        storyDescriptionLabel.layer.cornerRadius = 2.5
        storyDescriptionLabel.layer.masksToBounds = true

        //アイコンに関する設定
        let heartFontImage = UIImage.fontAwesomeIcon(name: .heart, style: .solid, textColor: UIColor.init(code: "#FF6222"), size: iconImageViewSize)
        storyEvaluationImageView.backgroundColor = UIColor.clear
        storyEvaluationImageView.image = heartFontImage

        let trophyFontImage = UIImage.fontAwesomeIcon(name: .trophy, style: .solid, textColor: UIColor.init(code: "#FD9D01"), size: iconImageViewSize)
        storyRankingImageView.backgroundColor = UIColor.clear
        storyRankingImageView.image = trophyFontImage

        let commentFontImage = UIImage.fontAwesomeIcon(name: .comment, style: .solid, textColor: UIColor.init(code: "#73C34D"), size: iconImageViewSize)
        storyCommentImageView.backgroundColor = UIColor.clear
        storyCommentImageView.image = commentFontImage
    }
}
