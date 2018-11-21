//
//  MainActivityNewsTableViewCell.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/19.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import UIKit
import SDWebImage

class MainActivityNewsTableViewCell: UITableViewCell {

    //UI部品の配置
    @IBOutlet weak private var newsTitleLabel: UILabel!
    @IBOutlet weak private var newsImageView: UIImageView!
    @IBOutlet weak private var newsPublishedAtLabel: UILabel!
    @IBOutlet weak private var newsCategoryLabel: UILabel!
    @IBOutlet weak private var newsDetailLabel: UILabel!

    //MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()

        setupMainActivityNewsTableViewCell()
    }

    //MARK: - Function

    func setCell(_ news: News) {

        //タイトルの行の高さを調節する
        let titleParagraphStyle = NSMutableParagraphStyle.init()
        titleParagraphStyle.minimumLineHeight = 18
        let titleAttributedText = NSMutableAttributedString.init(string: news.title)
        titleAttributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: titleParagraphStyle, range: NSMakeRange(0, titleAttributedText.length))
        newsTitleLabel.attributedText = titleAttributedText

        //メインテキストの行の高さを調節する
        let mainParagraphStyle = NSMutableParagraphStyle.init()
        mainParagraphStyle.minimumLineHeight = 20
        let mainAttributedText = NSMutableAttributedString.init(string: news.mainText)
        mainAttributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: titleParagraphStyle, range: NSMakeRange(0, mainAttributedText.length))
        newsDetailLabel.attributedText = mainAttributedText

        newsImageView.sd_setImage(with: URL(string: news.thumbnailUrl))
        newsCategoryLabel.text = news.category
        newsPublishedAtLabel.text = news.publishedAt
    }

    //MARK: - Private Function

    private func setupMainActivityNewsTableViewCell() {

        //セルの装飾設定をする
        self.accessoryType  = .none
        self.selectionStyle = .none

        //サムネイル画像の罫線の設定をする
        newsImageView.layer.borderColor = UIColor(code: "#DDDDDD").cgColor
        newsImageView.layer.borderWidth = 0.75
    }
}
