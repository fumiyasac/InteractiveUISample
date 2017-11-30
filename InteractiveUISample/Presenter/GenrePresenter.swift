//
//  GenrePresenter.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/12/01.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit

protocol GenrePresenterProtocol: class {
    func showGenreList(_ genre: [Genre])
}

class GenrePresenter {
    var presenter: GenrePresenterProtocol!

    //MARK: - Initializer

    init(presenter: GenrePresenterProtocol) {
        self.presenter = presenter
    }

    //MARK: - Functions

    //サンプルメインリスト用データを取得する
    func getGenreList() {
        let genreLists = getDummyGenreList()
        self.presenter.showGenreList(genreLists)
    }

    //MARK: - Private Functions

    //サンプルデータを作成する
    private func getDummyGenreList() -> [Genre] {
        return [
            Genre(
                id: 1,
                title: "旅行・観光",
                introText: "思い出の1ページの中に眠るストーリー",
                genreDetail: [
                    GenreDetail(id: 1, title: "新婚旅行の思い出", totalCount: 38),
                    GenreDetail(id: 2, title: "出張の思い出", totalCount: 111),
                    GenreDetail(id: 3, title: "新生活", totalCount: 56),
                    GenreDetail(id: 4, title: "卒業旅行", totalCount: 76),
                ]
            ),
            Genre(
                id: 2,
                title: "グルメ・食べ物",
                introText: "出会った土地の味の記録したストーリー",
                genreDetail: [
                    GenreDetail(id: 5, title: "旅先で出会った珍味", totalCount: 34),
                    GenreDetail(id: 6, title: "旅のおすすめレストラン", totalCount: 22),
                    GenreDetail(id: 7, title: "ご当地のお土産", totalCount: 536),
                    GenreDetail(id: 8, title: "ご当地食材料理", totalCount: 706),
                    GenreDetail(id: 9, title: "おすすめのお取り寄せ", totalCount: 22),
                    GenreDetail(id: 10, title: "セレクトショップ・道の駅", totalCount: 90),
                ]
            ),
            Genre(
                id: 3,
                title: "レジャー",
                introText: "プランの中のものや収まりきらないものまで",
                genreDetail: [
                    GenreDetail(id: 11, title: "釣り・磯遊び", totalCount: 198),
                    GenreDetail(id: 12, title: "キャンプ", totalCount: 35),
                    GenreDetail(id: 13, title: "マリンスポーツ", totalCount: 891),
                    GenreDetail(id: 14, title: "ご当地お祭り", totalCount: 35),
                    GenreDetail(id: 15, title: "クラブ・DJイベント", totalCount: 180),
                    GenreDetail(id: 16, title: "バーベキュー", totalCount: 91),
                ]
            ),
            Genre(
                id: 4,
                title: "地域伝承",
                introText: "気になる噂話から土地に伝わる風習など",
                genreDetail: [
                    GenreDetail(id: 17, title: "笑い話", totalCount: 176),
                    GenreDetail(id: 18, title: "怖い話", totalCount: 190),
                    GenreDetail(id: 19, title: "泣ける話", totalCount: 155),
                    GenreDetail(id: 20, title: "昔からの言い伝え", totalCount: 76),
                ]
            ),
            Genre(
                id: 5,
                title: "気になるトピックス",
                introText: "海の見える風景でのおすすめ記事",
                genreDetail: [
                    GenreDetail(id: 21, title: "2017年のおすすめ記事セレクション", totalCount: 23),
                    GenreDetail(id: 22, title: "2016年のおすすめ記事セレクション", totalCount: 678),
                    GenreDetail(id: 23, title: "2015年のおすすめ記事セレクション", totalCount: 1123),
                    GenreDetail(id: 24, title: "2014年のおすすめ記事セレクション", totalCount: 918),
                    GenreDetail(id: 25, title: "2013年のおすすめ記事セレクション", totalCount: 717),
                    GenreDetail(id: 26, title: "2012年のおすすめ記事セレクション", totalCount: 523),
                ]
            ),
            Genre(
                id: 6,
                title: "その他のコンテンツ",
                introText: "その他気になったことを紹介しています",
                genreDetail: [
                    GenreDetail(id: 27, title: "昔に描いたポエム", totalCount: 76),
                    GenreDetail(id: 28, title: "ご挨拶", totalCount: 19),
                    GenreDetail(id: 29, title: "プレスリリース", totalCount: 11),
                ]
            ),
        ]
    }
}
