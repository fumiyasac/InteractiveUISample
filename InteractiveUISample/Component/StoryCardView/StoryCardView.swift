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

    @IBOutlet private weak var storyDetailButtonWrappedView: UIView!
    @IBOutlet private weak var storyDetailButton: UIButton!

    //アイコンイメージのサイズ設定
    private let iconImageViewSize: CGSize = CGSize(width: 24, height: 24)

    //ViewControllerへ処理内容を引き渡すためのクロージャー
    var showStoryDetailAction: (() -> ())?

    //MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()

        setupStoryCardView()
    }

    //MARK: - Private Function

    //入力ボタンのTouchDownのタイミングで実行される処理
    @objc private func onTouchDownStoryDetailButton(sender: UIButton) {
        UIView.animate(withDuration: 0.16, animations: {
            self.storyDetailButtonWrappedView.transform = CGAffineTransform(scaleX: 0.94, y: 0.94)
        }, completion: nil)
    }

    //入力ボタンのTouchUpInsideのタイミングで実行される処理
    @objc private func onTouchUpInsideStoryDetailButton(sender: UIButton) {
        UIView.animate(withDuration: 0.16, animations: {
            self.storyDetailButtonWrappedView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { finished in
            
            //ViewController側でクロージャー内に設定した処理を実行する
            self.showStoryDetailAction?()
        })
    }

    //入力ボタンのTouchUpOutsideのタイミングで実行される処理
    @objc private func onTouchUpOutsideStoryDetailButton(sender: UIButton) {
        UIView.animate(withDuration: 0.16, animations: {
            self.storyDetailButtonWrappedView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }

    private func setupStoryCardView() {

        //サムネイル画像のclipsToBoundsをtrueにする
        storyThumbnailImageView.clipsToBounds = true

        //背景に影をつける
        storyCardWrappedView.layer.cornerRadius = 10.0
        storyCardWrappedView.layer.shadowRadius = 5
        storyCardWrappedView.layer.shadowOpacity = 0.2
        storyCardWrappedView.layer.shadowOffset = CGSize(width: 0, height: 1)
        storyCardWrappedView.layer.shadowColor = UIColor.black.cgColor
 
        //ボタンの背景に色と丸みをつける
        storyDetailButtonWrappedView.backgroundColor = ColorDefinition.navigationColor.getColor()
        storyDetailButtonWrappedView.layer.cornerRadius = 5.0
        storyDetailButtonWrappedView.layer.masksToBounds = true

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
        let heartFontImage = UIImage.fontAwesomeIcon(name: .heart, textColor: UIColor.init(code: "#FF6222"), size: iconImageViewSize)
        storyEvaluationImageView.backgroundColor = UIColor.clear
        storyEvaluationImageView.image = heartFontImage

        let trophyFontImage = UIImage.fontAwesomeIcon(name: .trophy, textColor: UIColor.init(code: "#FD9D01"), size: iconImageViewSize)
        storyRankingImageView.backgroundColor = UIColor.clear
        storyRankingImageView.image = trophyFontImage

        let commentFontImage = UIImage.fontAwesomeIcon(name: .comment, textColor: UIColor.init(code: "#73C34D"), size: iconImageViewSize)
        storyCommentImageView.backgroundColor = UIColor.clear
        storyCommentImageView.image = commentFontImage

        //ボタンアクションに関する設定
        //TouchDown・TouchUpInside・TouchUpOutsideの時のイベントを設定する（完了時の具体的な処理はTouchUpInside側で設定すること）
        storyDetailButton.addTarget(self, action: #selector(self.onTouchDownStoryDetailButton(sender:)), for: .touchDown)
        storyDetailButton.addTarget(self, action: #selector(self.onTouchUpInsideStoryDetailButton(sender:)), for: .touchUpInside)
        storyDetailButton.addTarget(self, action: #selector(self.onTouchUpOutsideStoryDetailButton(sender:)), for: .touchUpOutside)
    }
}
