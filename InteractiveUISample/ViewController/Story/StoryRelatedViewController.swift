//
//  StoryRelatedViewController.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/26.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import UIKit

class StoryRelatedViewController: UIViewController {

    //UI部品の配置
    @IBOutlet weak fileprivate var storyRelatedTableView: UITableView!

    private let storyRelatedHeaderViewHeight: CGFloat = 60.0

    //セクションごとに分けられたジャンルデータを格納する変数
    private var sectionStateLists: [(extended: Bool, genre: Genre)] = []

    //GenrePresenterに設定したプロトコルを適用するための変数
    private var presenter: GenrePresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupStoryRelatedTableView()
        setupGenrePresenter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Private Function

    //この画面のナビゲーションバーの設定
    private func setupNavigationBar() {

        // MEMO: 遷移元となるArticleViewControllerでUINavigationBarで変更を加えてしまっているので、この部分で元の設定を再度適用する
        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Bold", size: 14.0)!,
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]
            navigationBarAppearance.backgroundColor = UIColor(code: "#76b6e2")
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        } else {
            self.navigationController?.navigationBar.barTintColor = ColorDefinition.navigationColor.getColor()
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        }

        //タイトルを入れる
        self.navigationItem.title = "関連ジャンル一覧"
    }

    //テーブルビューの初期化を行う
    private func setupStoryRelatedTableView() {
        storyRelatedTableView.delegate           = self
        storyRelatedTableView.dataSource         = self
        storyRelatedTableView.estimatedRowHeight = 60
        storyRelatedTableView.rowHeight = UITableView.automaticDimension
        storyRelatedTableView.delaysContentTouches = false

        storyRelatedTableView.registerCustomCell(StoryRelatedTableViewCell.self)
    }

    //Presenterとの接続に関する設定を行う
    private func setupGenrePresenter() {
        presenter = GenrePresenter(presenter: self)
        presenter.getGenreList()
    }
}

//MARK: - GenrePresenterProtocol

extension StoryRelatedViewController: GenrePresenterProtocol {

    //表示するデータを取得した場合の処理
    func showGenreList(_ genre: [Genre]) {
        var genreList: [(extended: Bool, genre: Genre)] = []
        for genreData in genre {
            let genreDataSet: (extended: Bool, genre: Genre) = (extended: false, genre: genreData)
            genreList.append(genreDataSet)
        }
        sectionStateLists = genreList
        storyRelatedTableView.reloadData()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension StoryRelatedViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionStateLists.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionStateLists.count > 0 {
            return sectionStateLists[section].extended ? sectionStateLists[section].genre.genreDetail.count : 0
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCustomCell(with: StoryRelatedTableViewCell.self)
        cell.setCell(sectionStateLists[indexPath.section].genre.genreDetail[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = StoryRelatedHeaderView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: storyRelatedHeaderViewHeight))

        //ヘッダーに表示するデータ等の設定を行う
        headerView.tag = section
        headerView.initIconImageView(sectionStateLists[section].extended)
        headerView.setHeader(sectionStateLists[section].genre)

        //タップジェスチャーの付与を行う
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.storyRelatedHeaderWrappedViewTapped(sender:)))
        headerView.addGestureRecognizer(tapGestureRecognizer)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return storyRelatedHeaderViewHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    //TapGestureRecognizerが発動した際に実行されるアクション
    @objc private func storyRelatedHeaderWrappedViewTapped(sender: UITapGestureRecognizer) {
        guard let headerView = sender.view as? StoryRelatedHeaderView else {
            return
        }

        //該当セクションの値をタグから取得する
        let section = Int(headerView.tag)

        //該当セクションの開閉状態を更新する
        let changedExtended = !sectionStateLists[section].extended
        sectionStateLists[section].extended = changedExtended
        headerView.rotateIconImageView(changedExtended)

        //該当セクション番号のUITableViewを更新する
        storyRelatedTableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
}
