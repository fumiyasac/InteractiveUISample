//
//  MainActivityNewsViewController.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/19.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import UIKit

class MainActivityNewsViewController: UIViewController {

    //UI部品の配置
    @IBOutlet weak var newsTableView: UITableView!

    //ニュースコンテンツを格納するための変数
    fileprivate var newsContents: [News] = [] {
        didSet {
            self.newsTableView.reloadData()
        }
    }

    //NewsPresenterに設定したプロトコルを適用するための変数
    fileprivate var presenter: NewsPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNewsTableView()
        setupNewsPresenter()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newsTableView.frame = CGRect(
            x: newsTableView.frame.origin.x,
            y: newsTableView.frame.origin.y,
            width: newsTableView.frame.width,
            height: newsTableView.contentSize.height
        )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if newsContents.count > 0 {
            let height = newsTableView.contentSize.height
            NotificationCenter.default.post(name: Notification.Name(rawValue: receiveNewsNotification), object: self, userInfo: ["height": height])
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Private Function

    //テーブルビューの初期化を行う
    private func setupNewsTableView() {
        newsTableView.delegate   = self
        newsTableView.dataSource = self
        newsTableView.rowHeight  = UITableViewAutomaticDimension
        newsTableView.estimatedRowHeight = 120
        newsTableView.delaysContentTouches = false
        newsTableView.registerCustomCell(MainActivityNewsTableViewCell.self)
    }

    //Presenterとの接続に関する設定を行う
    private func setupNewsPresenter() {
        presenter = NewsPresenter(presenter: self)
        presenter.getNews()
    }
}

//MARK: - NewsPresenterProtocol

extension MainActivityNewsViewController: NewsPresenterProtocol {

    //Newsを取得した場合の処理
    func showNews(_ news: [News]) {
        newsContents = news
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension MainActivityNewsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //newsContentsにデータがセットされる → TableViewのリロード → コンテンツ表示の流れ
        return (newsContents.count > 0) ? newsContents.count : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //表示するニュースデータを取得する
        let targetNews = newsContents[indexPath.row]
        let cell = tableView.dequeueReusableCustomCell(with: MainActivityNewsTableViewCell.self)
        cell.setCell(targetNews)
        return cell
    }
}
