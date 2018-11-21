//
//  StoryRelatedTableViewCell.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/28.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import UIKit
import FontAwesome_swift

class StoryRelatedTableViewCell: UITableViewCell {

    //UI部品の配置
    @IBOutlet weak private var storyRelatedGenreLabel: UILabel!
    @IBOutlet weak private var storyRelatedTotalLabel: UILabel!
    @IBOutlet weak private var storyRelatedIconImageView: UIImageView!

    //アイコンイメージのサイズ設定
    private let iconImageViewSize: CGSize = CGSize(width: 12, height: 12)

    //MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()

        setupStoryRelatedTableViewCell()
    }

    //MARK: - Function

    func setCell(_ genreDetail: GenreDetail) {
        storyRelatedGenreLabel.text = genreDetail.title
        storyRelatedTotalLabel.text = "総勢\(genreDetail.totalCount)件のストーリー"
    }

    //MARK: - Private Function

    //このクラスの初期設定を行う
    private func setupStoryRelatedTableViewCell() {

        //セルの装飾設定をする
        self.accessoryType = .none
        self.selectionStyle = .none

        //アイコンに関する設定
        let bookFontImage = UIImage.fontAwesomeIcon(name: .book, style: .solid, textColor: UIColor.init(code: "#BBBBBB"), size: iconImageViewSize)
        storyRelatedIconImageView.backgroundColor = UIColor.clear
        storyRelatedIconImageView.image = bookFontImage
    }
}
