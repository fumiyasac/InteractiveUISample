//
//  GenreDetail.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/12/01.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit

struct GenreDetail {
    
    //メンバ変数（ダミーデータを作成する）
    let id: Int
    let title: String
    let totalCount: Int
    
    //イニシャライザ
    init(id: Int, title: String, totalCount: Int) {
        self.id           = id
        self.title        = title
        self.totalCount   = totalCount
    }
}
