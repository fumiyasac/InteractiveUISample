//
//  ArticleViewController.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/14.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    //UI部品の配置
    @IBOutlet var articleTableView: UITableView!

    //記事上の画像ヘッダーのViewの高さ（iPhoneX用に補正あり）
    private let articleHeaderImageViewHeight: CGFloat = {
        if UIApplication.shared.statusBarFrame.height > 20 {
            return 244.0
        } else {
            return 200.0
        }
    }()

    //グラデーションヘッダー用のY軸方向の位置（iPhoneX用に補正あり）
    private let gradientHeaderViewPositionY: CGFloat = -UIApplication.shared.statusBarFrame.height

    //ナビゲーションバーの高さ（iPhoneX用に補正あり）
    fileprivate let navigationBarHeight: CGFloat = {
        if UIApplication.shared.statusBarFrame.height > 20 {
            return 88.5
        } else {
            return 64.0
        }
    }()

    //適用するカスタムトランジションのクラス
    fileprivate let articleCustomTransition = ArticleCustomTransition()

    //記事上の画像ヘッダーおよびナビゲーションバーのインスタンス作成
    fileprivate var gradientHeaderView: GradientHeaderView = GradientHeaderView()
    fileprivate var articleHeaderView: ArticleHeaderView = ArticleHeaderView()

    //記事コンテンツを格納するための変数
    fileprivate var articleContents: [Article] = [] {
        didSet {
            self.articleTableView.reloadData()
            if let article = self.articleContents.first {
                self.gradientHeaderView.setTitle(article.title)
                self.articleHeaderView.setHeaderImage(article.thumbnailUrl)
            }
        }
    }

    //ArticlePresenterに設定したプロトコルを適用するための変数
    fileprivate var presenter: ArticlePresenter!

    //表示するセルの定義を設定したEnum
    fileprivate enum CellType: Int {
        case articleCounter     = 0
        case articleDescription = 1
        case articleStory       = 2
        case articleSummary     = 3

        static func getAllRow() -> [CellType] {
            let allCellType: [CellType] = [
                .articleCounter,
                .articleDescription,
                .articleStory,
                .articleSummary
            ]
            return allCellType
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupGradientHeaderView()
        setupGradientHeaderImage()
        setupArticleTableView()
        setupArticlePresenter()
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
        if #available(iOS 15.0, *) {
            // MEMO: iOS14以前で実施していた調整をiOS15で実施する場合には、
            // self.navigationController?.navigationBar → cで設定していく方針を取ることになります。
            // ※ navigationBarAppearanceでは便利なプロパティも増えています。
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Bold", size: 14.0)!,
                NSAttributedString.Key.foregroundColor : UIColor.clear
            ]
            navigationBarAppearance.backgroundColor = UIColor.clear
            navigationBarAppearance.shadowColor = UIColor.clear
            navigationBarAppearance.shadowImage = UIImage()

            UINavigationBar.appearance().isTranslucent = true
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        } else {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationItem.hidesBackButton = true

        }
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
        articleTableView.rowHeight = UITableView.automaticDimension
        articleTableView.delaysContentTouches = false
        articleTableView.alpha = 0

        articleTableView.registerCustomCell(ArticleCounterTableViewCell.self)
        articleTableView.registerCustomCell(ArticleDescriptionTableViewCell.self)
        articleTableView.registerCustomCell(ArticleStoryTableViewCell.self)
        articleTableView.registerCustomCell(ArticleSummaryTableViewCell.self)
    }

    //Presenterとの接続に関する設定を行う
    private func setupArticlePresenter() {
        presenter = ArticlePresenter(presenter: self)
        presenter.getArticle()
    }
}

//MARK: - ArticlePresenterProtocol

extension ArticleViewController: ArticlePresenterProtocol {

    //Presenter側で通信が成功した場合の処理
    func showArticle(_ article: Article) {
        articleContents.append(article)
        UIView.animate(withDuration: 0.26, animations: {
            self.articleTableView.alpha = 1
        })
    }

    //Presenter側で通信が失敗した場合の処理
    func hideArticle() {
        articleTableView.alpha = 0
        let errorAlert = UIAlertController(
            title: "通信状態エラー",
            message: "データの取得に失敗しました。通信状態の良い場所ないしはお持ちのWiftに接続した状態で再度更新ボタンを押してお試し下さい。",
            preferredStyle: UIAlertController.Style.alert
        )
        errorAlert.addAction(
            UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        )
        self.present(errorAlert, animated: true, completion: {
            self.presenter.getArticle()
        })
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
        return (articleContents.count > 0) ? CellType.getAllRow().count : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //表示する記事データを取得する
        let targetArticle = articleContents.first

        //index番号に応じて読み込むセルを変えている
        switch indexPath.row {

        case CellType.articleCounter.rawValue:
            let cell = tableView.dequeueReusableCustomCell(with: ArticleCounterTableViewCell.self)
            cell.setCell(targetArticle!)
            return cell

        case CellType.articleDescription.rawValue:
            let cell = tableView.dequeueReusableCustomCell(with: ArticleDescriptionTableViewCell.self)
            cell.setCell(targetArticle!)
            return cell

        case CellType.articleStory.rawValue:
            let cell = tableView.dequeueReusableCustomCell(with: ArticleStoryTableViewCell.self)
            cell.showStoryAction = {

                //記事表示用の画面へ遷移する
                let storyboard = UIStoryboard(name: "Story", bundle: nil)
                let storyPageViewController = storyboard.instantiateViewController(withIdentifier: "StoryPageViewController") as! StoryPageViewController

                //カスタムトランジションのプロトコルを適用させる
                let navigationController = UINavigationController(rootViewController: storyPageViewController)
                navigationController.transitioningDelegate = self
                //Modalの画面遷移を実行する
                //MEMO: iOS13以降のPresent/Dismiss時の調整
                //Present/Dismissで実行するカスタムトランジションの場合ではこの設定を忘れると画面遷移がおかしくなるので注意
                if #available(iOS 13.0, *) {
                    navigationController.modalPresentationStyle = .fullScreen
                }
                self.present(navigationController, animated: true, completion: nil)
            }
            return cell

        case CellType.articleSummary.rawValue:
            let cell = tableView.dequeueReusableCustomCell(with: ArticleSummaryTableViewCell.self)
            cell.setCell(targetArticle!)
            return cell

        default:
            return UITableViewCell.init()
        }
    }
}

//MARK: - UIViewControllerTransitioningDelegate

extension ArticleViewController: UIViewControllerTransitioningDelegate {
    
    //進む場合のアニメーションの設定を行う
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        articleCustomTransition.presenting = true
        return articleCustomTransition
    }
    
    //戻る場合のアニメーションの設定を行う
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        articleCustomTransition.presenting = false
        return articleCustomTransition
    }
}
