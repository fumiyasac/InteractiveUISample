//
//  Article.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/18.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct Article {

    //メンバ変数（取得したJSONレスポンスのKeyに対応する値が入る）
    let id: Int
    let thumbnailUrl: String
    let title: String
    let category: String
    let mainText: String
    let viewsCounter: Int
    let likesCounter: Int
    let summaryTitle: String
    let summaryText: String
    let publishedAt: String

    //イニシャライザ（取得したJSONレスポンスに対して必要なものを抽出する）
    init(json: JSON) {
        self.id           = json["id"].int ?? 0
        self.thumbnailUrl = json["thumbnailUrl"].string ?? ""
        self.title        = json["title"].string ?? ""
        self.category     = json["category"].string ?? ""
        self.mainText     = json["mainText"].string ?? ""
        self.viewsCounter = json["viewsCounter"].int ?? 0
        self.likesCounter = json["likesCounter"].int ?? 0
        self.summaryTitle = json["summaryTitle"].string ?? ""
        self.summaryText  = json["summaryText"].string ?? ""
        self.publishedAt  = json["publishedAt"].string ?? ""
    }
}
