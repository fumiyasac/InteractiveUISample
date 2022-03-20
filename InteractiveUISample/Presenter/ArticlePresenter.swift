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

protocol ArticlePresenterProtocol: AnyObject {
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
        apiRequestManager.request()
            .done { json in
                //通信成功時の処理をプロトコルを適用したViewController側で行う
                let article = Article.init(json: json)
                self.presenter.showArticle(article)
            }
            .catch { _ in
                //通信失敗時の処理をプロトコルを適用したViewController側で行う
                self.presenter.hideArticle()
            }
    }
}
