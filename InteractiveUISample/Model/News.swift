//
//  News.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/19.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit

struct News {

    //メンバ変数（ダミーデータを作成する）
    let id: Int
    let thumbnailUrl: String
    let title: String
    let category: String
    let mainText: String
    let publishedAt: String

    //イニシャライザ
    init(id: Int, thumbnailUrl: String, title: String, category: String, mainText: String, publishedAt: String) {
        self.id           = id
        self.thumbnailUrl = thumbnailUrl
        self.title        = title
        self.category     = category
        self.mainText     = mainText
        self.publishedAt  = publishedAt
    }
}
