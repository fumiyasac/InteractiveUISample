//
//  APIRequestManager.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/19.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON

//APIへのアクセスを汎用的に利用するための構造体
//参考：https://qiita.com/tmf16/items/d2f13088dd089b6bb3e4

struct APIRequestManager {

    //APIのベースとなるURL情報
    private let apiBaseURL = "https://s3-ap-northeast-1.amazonaws.com/interactive-ui-sample/development/"

    //Header情報
    private static let requestHeader = HTTPHeaders(
        arrayLiteral: HTTPHeader(name: "User-Agent", value: ""),
        HTTPHeader(name: "Content-Type", value: "application/x-www-from-urlencoded")
    )

    //URLアクセス用のメンバ変数
    let apiUrl: String
    let method: HTTPMethod
    let parameters: Parameters

    init(endPoint: String, method: HTTPMethod = .get, parameters: Parameters = [:]) {

        //イニシャライザの定義
        apiUrl = apiBaseURL + endPoint
        self.method = method
        self.parameters = parameters
    }

    //該当APIのエンドポイントに向けてデータを取得する
    func request() -> Promise<JSON> {

        return Promise { seal in
            //Alamofireによる非同期通信
            AF.request(apiUrl, method: method, parameters: parameters, encoding: URLEncoding.default, headers: APIRequestManager.requestHeader).validate().responseJSON { response in

                switch response.result {

                // 成功時の処理(以降はレスポンス結果を取得して返す)
                case .success(let response):
                    let json = JSON(response)
                    seal.fulfill(json)

                // 失敗時の処理(以降はエラーの結果を返す)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}
