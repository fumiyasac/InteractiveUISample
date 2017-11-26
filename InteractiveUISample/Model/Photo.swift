//
//  Photo.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/26.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit

struct Photo {

    //メンバ変数（ダミーデータを作成する）
    let id: Int
    let imageData: UIImage?

    //イニシャライザ
    init(id: Int, imageName: String) {
        self.id        = id
        self.imageData = UIImage(named: imageName) ?? nil
    }
}
