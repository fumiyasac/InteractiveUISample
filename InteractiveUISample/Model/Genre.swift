//
//  Genre.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/12/01.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit

struct Genre {
    
    //メンバ変数（ダミーデータを作成する）
    let id: Int
    let title: String
    let introText: String
    let genreDetail: [GenreDetail]
    
    //イニシャライザ
    init(id: Int, title: String, introText: String, genreDetail: [GenreDetail]) {
        self.id          = id
        self.title       = title
        self.introText   = introText
        self.genreDetail = genreDetail
    }
}
