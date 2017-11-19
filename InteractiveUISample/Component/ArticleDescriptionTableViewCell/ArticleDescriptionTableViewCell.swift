//
//  ArticleDescriptionTableViewCell.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/14.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift

class ArticleDescriptionTableViewCell: UITableViewCell {

    //UI部品の配置
    @IBOutlet weak private var articleTitleLabel: UILabel!
    @IBOutlet weak private var articlePublishedImageView: UIImageView!
    @IBOutlet weak private var articlePublishedLabel: UILabel!
    @IBOutlet weak private var articleCategoryImageView: UIImageView!
    @IBOutlet weak private var articleCategoryLabel: UILabel!
    @IBOutlet weak private var articleMainTextLabel: UILabel!

    //アイコンイメージのサイズ設定
    private let iconImageViewSize: CGSize = CGSize(width: 16, height: 16)

    //MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()

        setupArticleDescriptionTableViewCell()
    }

    //MARK: - Function
    
    func setCell(_ article: Article) {

        //タイトルの行の高さを調節する
        let titleParagraphStyle = NSMutableParagraphStyle.init()
        titleParagraphStyle.minimumLineHeight = 16
        let titleAttributedText = NSMutableAttributedString.init(string: article.title)
        titleAttributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: titleParagraphStyle, range: NSMakeRange(0, titleAttributedText.length))
        articleTitleLabel.attributedText = titleAttributedText

        //メインテキストの行の高さを調節する
        let mainParagraphStyle = NSMutableParagraphStyle.init()
        mainParagraphStyle.minimumLineHeight = 18
        let mainAttributedText = NSMutableAttributedString.init(string: article.mainText)
        mainAttributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: titleParagraphStyle, range: NSMakeRange(0, mainAttributedText.length))
        articleMainTextLabel.attributedText = mainAttributedText

        articlePublishedLabel.text = article.publishedAt
        articleCategoryLabel.text = article.category
    }

    //MARK: - Private Function

    private func setupArticleDescriptionTableViewCell() {

        //セルの装飾設定をする
        self.accessoryType  = .none
        self.selectionStyle = .none

        //作成日時のアイコン設定
        let clockFontImage = UIImage.fontAwesomeIcon(name: .clockO, textColor: UIColor.gray, size: iconImageViewSize)
        articlePublishedImageView.backgroundColor = UIColor.clear
        articlePublishedImageView.image = clockFontImage

        //カテゴリーのアイコン設定
        let tagFontImage = UIImage.fontAwesomeIcon(name: .tag, textColor: UIColor.gray, size: iconImageViewSize)
        articleCategoryImageView.backgroundColor  = UIColor.clear
        articleCategoryImageView.image  = tagFontImage
    }
}
