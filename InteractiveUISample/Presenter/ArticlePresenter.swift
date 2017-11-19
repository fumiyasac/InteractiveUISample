//
//  ArticlePresenter.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/19.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

protocol ArticlePresenterProtocol: class {
    func showArticle(_ article: Article)
    func hideArticle()
}

class ArticlePresenter {

    var presenter: ArticlePresenterProtocol!

    //MARK: - Initializer

    init(presenter: ArticlePresenterProtocol) {
        self.presenter = presenter
    }

    //MARK: - Functions

    //サンプル記事データを取得する
    func getArticle() {
        let apiRequestManager = APIRequestManager(endPoint: "article.json", method: .get)
        apiRequestManager.request(
            success: { (data: Dictionary) in
                let article = Article.init(json: JSON(data))

                //通信成功時の処理をプロトコルを適用したViewController側で行う
                self.presenter.showArticle(article)
            },
            fail: { (error: Error?) in

                //通信失敗時の処理をプロトコルを適用したViewController側で行う
                self.presenter.hideArticle()
            }
        )
    }
}
