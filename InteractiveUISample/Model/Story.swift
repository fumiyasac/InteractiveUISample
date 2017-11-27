//
//  Story.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/27.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit

struct Story {

    //メンバ変数（ダミーデータを作成する）
    let id: Int
    let photo: UIImage
    let chapter: String
    let title: String
    let summary: String
    let mainText: String
    let evaluation: String
    let ranking: String
    let comment: String
    let publishedAt: String

    //イニシャライザ
    init(id: Int, photo: UIImage, chapter: String, title: String, summary: String, mainText: String, evaluation: String, ranking: String, comment: String, publishedAt: String) {
        self.id          = id
        self.photo       = photo
        self.chapter     = chapter
        self.title       = title
        self.summary     = summary
        self.mainText    = mainText
        self.evaluation  = evaluation
        self.ranking     = ranking
        self.comment     = comment
        self.publishedAt = publishedAt
    }
}
