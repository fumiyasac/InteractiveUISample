//
//  ArticleSummaryTableViewCell.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/14.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import UIKit

class ArticleSummaryTableViewCell: UITableViewCell {

    //UI部品の配置
    @IBOutlet weak private var articleSummaryTitleLabel: UILabel!
    @IBOutlet weak private var articleSummaryTextLabel: UILabel!

    //MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()

        setupArticleSummaryTableViewCell()
    }

    //MARK: - Function

    func setCell(_ article: Article) {

        //タイトルの行の高さを調節する
        let titleParagraphStyle = NSMutableParagraphStyle.init()
        titleParagraphStyle.minimumLineHeight = 18
        let titleAttributedText = NSMutableAttributedString.init(string: article.summaryTitle)
        titleAttributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: titleParagraphStyle, range: NSMakeRange(0, titleAttributedText.length))
        articleSummaryTitleLabel.attributedText = titleAttributedText

        //メインテキストの行の高さを調節する
        let mainParagraphStyle = NSMutableParagraphStyle.init()
        mainParagraphStyle.minimumLineHeight = 20
        let mainAttributedText = NSMutableAttributedString.init(string: article.summaryText)
        mainAttributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: titleParagraphStyle, range: NSMakeRange(0, mainAttributedText.length))
        articleSummaryTextLabel.attributedText = mainAttributedText
    }

    //MARK: - Private Function

    private func setupArticleSummaryTableViewCell() {

        //セルの装飾設定をする
        self.accessoryType  = .none
        self.selectionStyle = .none
    }
}
