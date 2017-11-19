//
//  NewsPresenter.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/19.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

protocol NewsPresenterProtocol: class {
    func showNews(_ news: [News])
}

class NewsPresenter {
    var presenter: NewsPresenterProtocol!

    //MARK: - Initializer

    init(presenter: NewsPresenterProtocol) {
        self.presenter = presenter
    }

    //MARK: - Functions

    //サンプルニュースデータを取得する
    func getNews() {
        let newsLists = getDummyNewsData()
        self.presenter.showNews(newsLists)
    }

    //MARK: - Private Functions

    //サンプルデータを作成する
    private func getDummyNewsData() -> [News] {
        return [
            News(
                id: 6,
                thumbnailUrl: "https://s3-ap-northeast-1.amazonaws.com/interactive-ui-sample/development/image/news/sample6.jpg",
                title: "そろそろ卒業旅行の計画は立てましたか？",
                category: "記事紹介",
                mainText: "卒業旅行シーズンに間に合うように今から準備と計画をしておきましょう。",
                publishedAt: "2017.11.20"
            ),
            News(
                id: 5,
                thumbnailUrl: "https://s3-ap-northeast-1.amazonaws.com/interactive-ui-sample/development/image/news/sample5.jpg",
                title: "釣り好き必見の記事を公開しました。",
                category: "記事紹介",
                mainText: "沖縄の釣りの醍醐味と魅力をたくさん語ってもらいました。",
                publishedAt: "2017.11.20"
            ),
            News(
                id: 4,
                thumbnailUrl: "https://s3-ap-northeast-1.amazonaws.com/interactive-ui-sample/development/image/news/sample4.jpg",
                title: "「旅先の一枚」フォトコンテスト開催します！",
                category: "フォトコンテスト",
                mainText: "みなさまふるってご参加くださいませ^^。受付期間は12/1〜1/31までになりますので年末年始の思い出を是非！",
                publishedAt: "2017.11.20"
            ),
            News(
                id: 3,
                thumbnailUrl: "https://s3-ap-northeast-1.amazonaws.com/interactive-ui-sample/development/image/news/sample3.jpg",
                title: "航空券の予約とオススメアプリ",
                category: "交通手段の予約について",
                mainText: "航空券の予約〜受け取りもスマートフォンを活用すると便利です。",
                publishedAt: "2017.11.20"
            ),
            News(
                id: 2,
                thumbnailUrl: "https://s3-ap-northeast-1.amazonaws.com/interactive-ui-sample/development/image/news/sample2.jpg",
                title: "初めてのパスポート",
                category: "旅行へ行く前のチェック事項",
                mainText: "初めての海外旅行を計画・準備にあたっての確認事項をまとめてみました。",
                publishedAt: "2017.11.20"
            ),
            News(
                id: 1,
                thumbnailUrl: "https://s3-ap-northeast-1.amazonaws.com/interactive-ui-sample/development/image/news/sample1.jpg",
                title: "美味しいレストランの耳寄り情報があれば是非！",
                category: "アンケートのお願い",
                mainText: "国内・国外問わずに旅先で出会った美味しいレストランや食べ物があれば是非とも教えてくださいね^^",
                publishedAt: "2017.11.20"
            ),
        ]
    }
}
