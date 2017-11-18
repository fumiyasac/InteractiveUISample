//
//  ArticleViewController.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/14.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    @IBOutlet var articleTableView: UITableView!

    //記事上の画像ヘッダーのViewの高さ（iPhoneX用に補正あり）
    private let articleHeaderImageViewHeight: CGFloat = DeviceSize.sizeOfIphoneX() ? 244 : 200

    //グラデーションヘッダー用のY軸方向の位置（iPhoneX用に補正あり）
    private let gradientHeaderViewPositionY: CGFloat = DeviceSize.sizeOfIphoneX() ? -44 : -20

    //ナビゲーションバーの高さ（iPhoneX用に補正あり）
    fileprivate let navigationBarHeight: CGFloat = DeviceSize.sizeOfIphoneX() ? 88.5 : 64.0

    //記事上の画像ヘッダーおよびナビゲーションバーのインスタンス作成
    fileprivate var gradientHeaderView: GradientHeaderView = GradientHeaderView()
    fileprivate var articleHeaderView: ArticleHeaderView = ArticleHeaderView()

    /*
    fileprivate var articleContents: [Article] = [] {
        didSet {
            self.articleTableView.reloadData()
            if let article = self.articleContents.first {
                self.gradientHeaderView.setTitle(article.title)
                self.articleHeaderView.setHeaderImage(article.thumbnailUrl)
            }
        }
    }
    fileprivate var presenter: ArticlePresenter!

    fileprivate enum CellType: Int {
        case articleTitle           = 0
        case articleFirstParagraph  = 1
        case articleSecondParagraph = 2
        case articleSummary         = 3

        static func getAllRow() -> [CellType] {
            let allCellType: [CellType] = [.articleTitle, .articleFirstParagraph, .articleSecondParagraph, .articleSummary]
            return allCellType
        }
    }
    */
 
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupGradientHeaderView()
        setupGradientHeaderImage()
        setupArticleTableView()

        //TODO: あとで調節
        articleHeaderView.setHeaderImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Private Function

    //ヘッダーの戻るボタンを押した際のアクション
    @objc private func headerBackButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }

    //この画面のナビゲーションバーの設定
    private func setupNavigationBar() {

        //NavigationControllerのカスタマイズを行う
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.hidesBackButton = true
    }

    //ダミーのヘッダービューに関するセッティングを行うメソッド
    private func setupGradientHeaderView() {

        //StatusBarの高さ分をマイナス＆微調整してnavigationBarの中に配置する
        gradientHeaderView.frame = CGRect(x: 0, y: gradientHeaderViewPositionY, width: self.view.bounds.width, height: navigationBarHeight)
        self.navigationController?.navigationBar.addSubview(gradientHeaderView)

        //初回配置時のアルファ値を0にする
        gradientHeaderView.alpha = 0

        //ダミーのヘッダービュー内に配置している戻るボタンとアクション対象メソッドの紐付けをする
        gradientHeaderView.headerBackButton.addTarget(self, action: #selector(self.headerBackButtonAction), for: .touchUpInside)
    }

    //テーブルビューのヘッダー画像に関するセッティングを行う
    private func setupGradientHeaderImage() {
        articleHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: articleHeaderImageViewHeight)
        articleTableView.tableHeaderView = articleHeaderView
    }

    //テーブルビューの初期化を行う
    private func setupArticleTableView() {
        articleTableView.delegate           = self
        articleTableView.dataSource         = self
        articleTableView.estimatedRowHeight = 340
        articleTableView.rowHeight = UITableViewAutomaticDimension

        //TODO: あとで調節
        articleTableView.registerCustomCell(SampleTableViewCell.self)
    }
}

//MARK - UIScrollViewDelegate

extension ArticleViewController: UIScrollViewDelegate {

    //スクロールが検知された時に実行される処理
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        //テーブルビューのヘッダー画像に付与されているAutoLayout制約を変更してパララックス効果を出す
        let articleHeaderView = articleTableView.tableHeaderView as! ArticleHeaderView
        articleHeaderView.setParallaxEffectToHeaderView(scrollView)

        //ダミーのヘッダービューのアルファ値を上方向のスクロール量に応じて変化させる
        /*
         それぞれの変数の意味と変化量と伴って変わる値に関する補足：
         [変数] navigationInvisibleHeight = (テーブルビューのヘッダー画像の高さ) - (NavigationBarの高さを引いたもの)
         gradientHeaderViewのアルファの値 = 上方向のスクロール量 ÷ navigationInvisibleHeightとする
         アルファの値域：(0 ≦ gradientHeaderView.alpha ≦ 1)
         */
        let navigationInvisibleHeight = articleHeaderView.frame.height - navigationBarHeight
        let scrollContentOffsetY = scrollView.contentOffset.y
        if scrollContentOffsetY > 0 {
            gradientHeaderView.alpha = min(scrollContentOffsetY / navigationInvisibleHeight, 1)
        } else {
            gradientHeaderView.alpha = max(scrollContentOffsetY / navigationInvisibleHeight, 0)
        }

        //ダミーのヘッダービューの中身の戻るボタンとタイトルを包んだViewの上方向の制約を更新する
        let targetTopConstraint = navigationInvisibleHeight - scrollContentOffsetY
        gradientHeaderView.setHeaderNavigationTopConstraint(targetTopConstraint)
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension ArticleViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //articleContentsにデータがセットされる → TableViewのリロード → コンテンツ表示の流れ
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCustomCell(with: SampleTableViewCell.self)
        return cell
    }
}
