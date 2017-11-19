//
//  MainListPresenter.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/18.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit

protocol MainListPresenterProtocol: class {
    func showMainList(_ mainList: [MainList])
}

class MainListPresenter {
    var presenter: MainListPresenterProtocol!

    //MARK: - Initializer

    init(presenter: MainListPresenterProtocol) {
        self.presenter = presenter
    }

    //MARK: - Functions

    //サンプルメインリスト用データを取得する
    func getMainList() {
        let mainLists = getDummyMainList()
        self.presenter.showMainList(mainLists)
    }

    //MARK: - Private Functions

    //サンプルデータを作成する
    private func getDummyMainList() -> [MainList] {
        return [
            MainList(
                id: 6,
                thumbnailUrl: "https://s3-ap-northeast-1.amazonaws.com/interactive-ui-sample/development/image/mainlist/sample6.jpg",
                title: "沖縄本島 北谷町 アラハビーチ",
                category: "国内",
                author: "編集部一同",
                mainText: "異国情緒が溢れる美しいビーチ。マリンスポーツも盛んに行われています。海水浴はもちろん近隣の施設やホテルといった周辺環境も充実しています。",
                publishedAt: "2017.11.20"
            ),
            MainList(
                id: 5,
                thumbnailUrl: "https://s3-ap-northeast-1.amazonaws.com/interactive-ui-sample/development/image/mainlist/sample5.jpg",
                title: "沖縄本島東南端 久高島",
                category: "国内",
                author: "編集部一同",
                mainText: "「神の島」とも呼ばれる琉球の神秘が魅力の島です。沖縄本島からフェリーで20分で行けるので、長期滞在の際は是非とも行って見るとよいでしょう。",
                publishedAt: "2017.11.20"
            ),
            MainList(
                id: 4,
                thumbnailUrl: "https://s3-ap-northeast-1.amazonaws.com/interactive-ui-sample/development/image/mainlist/sample4.jpg",
                title: "島遊びの人気スポット 石垣島",
                category: "国内",
                author: "編集部一同",
                mainText: "羽田空港、関西国際空港からもアクセスがある沖縄の中でも根強い人気スポット。おおらかにゆっくりと時間が流れる中で琉球の自然を堪能あれ。",
                publishedAt: "2017.11.20"
            ),
            MainList(
                id: 3,
                thumbnailUrl: "https://s3-ap-northeast-1.amazonaws.com/interactive-ui-sample/development/image/mainlist/sample3.jpg",
                title: "島遊びの人気スポット バリ島",
                category: "海外",
                author: "編集部一同",
                mainText: "自然もビーチもリゾートも思う存分に楽しむことができる、常夏の楽園。街並みやショッピング・ナイトクラブも思う存分に遊び尽くしたいスポット多数。",
                publishedAt: "2017.11.20"
            ),
            MainList(
                id: 2,
                thumbnailUrl: "https://s3-ap-northeast-1.amazonaws.com/interactive-ui-sample/development/image/mainlist/sample2.jpg",
                title: "1島1リゾートが魅力 モルディブ",
                category: "海外",
                author: "編集部一同",
                mainText: "新婚旅行やハネムーンでも人気の高いスポット。サンゴ礁の美しさは必見。綺麗な海とリゾートを独り占めできてしまうプライベートアイランドもできるかも。",
                publishedAt: "2017.11.20"
            ),
            MainList(
                id: 1,
                thumbnailUrl: "https://s3-ap-northeast-1.amazonaws.com/interactive-ui-sample/development/image/mainlist/sample1.jpg",
                title: "青と白の世界 サントリーニ島",
                category: "海外",
                author: "編集部一同",
                mainText: "ヨーロッパでも人気の絶景溢れる「奇跡の島」。温暖な気候と長い歴史を感じるような風景は奇跡と呼ぶにふさわしい、穴場スポットです。",
                publishedAt: "2017.11.20"
            ),
        ]
    }
}
