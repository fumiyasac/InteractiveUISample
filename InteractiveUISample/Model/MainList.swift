//
//  MainList.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/20.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit

struct MainList {

    //メンバ変数（ダミーデータを作成する）
    let id: Int
    let thumbnailUrl: String
    let title: String
    let category: String
    let author: String
    let mainText: String
    let publishedAt: String

    //イニシャライザ
    init(id: Int, thumbnailUrl: String, title: String, category: String, author: String, mainText: String, publishedAt: String) {
        self.id           = id
        self.thumbnailUrl = thumbnailUrl
        self.title        = title
        self.category     = category
        self.author       = author
        self.mainText     = mainText
        self.publishedAt  = publishedAt
    }
}
