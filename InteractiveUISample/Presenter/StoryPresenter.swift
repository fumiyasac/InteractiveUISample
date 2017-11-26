//
//  StoryPresenter.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/27.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit

protocol StoryPresenterProtocol: class {
    func showStory(_ story: [Story])
}

class StoryPresenter {
    var presenter: StoryPresenterProtocol!

    //MARK: - Initializer

    init(presenter: StoryPresenterProtocol) {
        self.presenter = presenter
    }

    //MARK: - Functions

    //サンプルニュースデータを取得する
    func getStory() {
        let storyLists = getDummyStoryData()
        self.presenter.showStory(storyLists)
    }

    //MARK: - Private Functions

    //サンプルデータを作成する
    private func getDummyStoryData() -> [Story] {
        return [
            Story(
                id: 1,
                photo: UIImage(named: "story1")!,
                chapter: "Chapter1",
                title: "僕と沖縄と釣り日記(1)",
                summary: "沖縄へ釣りに行った際の記録をつれづれなるままにまとめてみました。旅路の途中で出会ったものを紹介します。",
                mainText: "こちらのストーリーはiOSアプリのサンプル用に書き起こしをした、ダミーのストーリー記事になります。ちょっとわかりにくくって申し訳ありませんでした。きちんとしたアプリを今回の実装などを生かした上で開発していきたいと思いますので、そのために今後とも精進をしていきたいと思う所存です。UI作成はやっぱり楽しいものですね。フルスクラッチで作るUIは時間も手間もかかるものですが、しっかりとUIKitと向き合うとたくさんの良いことがあると思いますし、時間を取って試行錯誤をする時間って自分のゾーンに入って夢中になることができるからなかなかやめられないですね。",
                evaluation: "3.6",
                ranking: "34",
                comment: "67",
                publishedAt: "2017.11.25"
            ),
            Story(
                id: 2,
                photo: UIImage(named: "story2")!,
                chapter: "Chapter2",
                title: "僕と沖縄と釣り日記(2)",
                summary: "ビーチで遊ぶのも大好きなんだけど、まずは開口一番に「釣りがしたい」と。というわけで浜から釣りをしました。",
                mainText: "こちらのストーリーはiOSアプリのサンプル用に書き起こしをした、ダミーのストーリー記事になります。ちょっとわかりにくくって申し訳ありませんでした。きちんとしたアプリを今回の実装などを生かした上で開発していきたいと思いますので、そのために今後とも精進をしていきたいと思う所存です。UI作成はやっぱり楽しいものですね。フルスクラッチで作るUIは時間も手間もかかるものですが、しっかりとUIKitと向き合うとたくさんの良いことがあると思いますし、時間を取って試行錯誤をする時間って自分のゾーンに入って夢中になることができるからなかなかやめられないですね。",
                evaluation: "4.1",
                ranking: "23",
                comment: "189",
                publishedAt: "2017.11.25"
            ),
            Story(
                id: 3,
                photo: UIImage(named: "story3")!,
                chapter: "Chapter3",
                title: "僕と沖縄と釣り日記(3)",
                summary: "お昼はリゾート地まで思い切って移動したので、海と空が見える綺麗なカフェへ。タコライスにまつわるお話を。",
                mainText: "こちらのストーリーはiOSアプリのサンプル用に書き起こしをした、ダミーのストーリー記事になります。ちょっとわかりにくくって申し訳ありませんでした。きちんとしたアプリを今回の実装などを生かした上で開発していきたいと思いますので、そのために今後とも精進をしていきたいと思う所存です。UI作成はやっぱり楽しいものですね。フルスクラッチで作るUIは時間も手間もかかるものですが、しっかりとUIKitと向き合うとたくさんの良いことがあると思いますし、時間を取って試行錯誤をする時間って自分のゾーンに入って夢中になることができるからなかなかやめられないですね。",
                evaluation: "4.0",
                ranking: "27",
                comment: "100",
                publishedAt: "2017.11.25"
            ),
        ]
    }
}

