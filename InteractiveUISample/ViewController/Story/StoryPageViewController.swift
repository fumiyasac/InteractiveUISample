//
//  StoryPageViewController.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/19.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import UIKit

class StoryPageViewController: UIViewController {

    //UIパーツの配置
    @IBOutlet weak private var storyBackgroundImage: UIImageView!
    @IBOutlet weak private var storyContainerView: UIView!
    @IBOutlet weak private var headerBackButton: UIButton!
    @IBOutlet weak private var headerStoryRelatedButton: UIButton!
    
    @IBOutlet weak fileprivate var currentIndexLabel: UILabel!
    @IBOutlet weak fileprivate var totalIndexLabel: UILabel!

    //ContainerViewにEmbedしたUIPageViewControllerのインスタンスを保持する
    fileprivate var pageViewController: UIPageViewController?

    //ページングして表示させるViewControllerを保持する配列
    fileprivate var storyViewControllerLists = [StoryViewController]()

    //Storyデータを格納するための変数
    fileprivate var storyContents: [Story] = [] {
        didSet {
            self.setupStoryViewControllerLists()
            self.setupPageViewController()
        }
    }

    //StoryPresenterに設定したプロトコルを適用するための変数
    fileprivate var presenter: StoryPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupHeaderBackButton()
        setupHeaderStoryRelatedButton()
        setupBackgroundImage()
        setupStoryPresenter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Private Function

    //ヘッダーの戻るボタンを押した際のアクション
    @objc private func headerBackButtonAction() {
        dismiss(animated: true, completion: nil)
    }

    //関連ジャンル一覧ボタンを押した際のアクション
    @objc private func headerStoryRelatedButtonAction() {
        performSegue(withIdentifier: "ToStoryRelatedViewController", sender: nil)
    }

    //この画面のナビゲーションバーの設定
    private func setupNavigationBar() {

        //NavigationControllerのデザイン調整を行う
        self.navigationController?.navigationBar.barTintColor = ColorDefinition.navigationColor.getColor()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]

        //タイトルを入れる
        self.navigationItem.title = "Story一覧"

        //このナビゲーションバーの戻るボタンのテキストを削除する
        removeBackButtonText()
    }

    //戻るボタンに関するセッティングを行う
    private func setupHeaderBackButton() {

        //戻るボタンとアクション対象メソッドの紐付けをする
        headerBackButton.addTarget(self, action: #selector(self.headerBackButtonAction), for: .touchUpInside)
    }
    
    //関連ジャンル一覧ボタンに関するセッティングを行う
    private func setupHeaderStoryRelatedButton() {

        //関連ジャンル一覧ボタンとアクション対象メソッドの紐付けをする
        headerStoryRelatedButton.addTarget(self, action: #selector(self.headerStoryRelatedButtonAction), for: .touchUpInside)
    }

    //背景の設定
    private func setupBackgroundImage() {
        storyBackgroundImage.image = UIImage(named: "background_sample")
    }

    //Presenterとの接続に関する設定を行う
    private func setupStoryPresenter() {
        presenter = StoryPresenter(presenter: self)
        presenter.getStory()
    }

    private func setupPageViewController() {

        //UIPageViewControllerで表示するViewControllerの作成
        //setupStoryViewControllerLists()

        //ContainerViewにEmbedしたUIPageViewControllerを取得する
        pageViewController = childViewControllers[0] as? UIPageViewController

        //UIPageViewControllerのデータソースの宣言
        pageViewController!.delegate = self
        pageViewController!.dataSource = self

        //MEMO: UIPageViewControllerでUIScrollViewDelegateが欲しい場合はこのように適用する
        //for view in pageViewController!.view.subviews {
        //    if let scrollView = view as? UIScrollView {
        //        scrollView.delegate = self
        //    }
        //}

        //最初に表示する画面として配列の先頭のViewControllerを設定する
        pageViewController!.setViewControllers([storyViewControllerLists[0]], direction: .forward, animated: false, completion: nil)
    }

    //Storyboard上に配置したViewController(StoryboardID = StoryViewController)をインスタンス化して配列に追加する
    private func setupStoryViewControllerLists() {

        for index in 0..<storyContents.count {
            let storyboard: UIStoryboard = UIStoryboard(name: "Story", bundle: Bundle.main)
            let storyViewController = storyboard.instantiateViewController(withIdentifier: "StoryViewController") as! StoryViewController

            //「タグ番号 = インデックスの値」でスワイプ完了時にどのViewControllerかを判別できるようにする ＆ ストーリーデータをセットする
            storyViewController.view.tag = index
            storyViewController.setStoryCardView(storyContents[index])

            //storyViewControllerListsに追加する
            storyViewControllerLists.append(storyViewController)
        }

        //StoryViewControllerの総数をセットする
        totalIndexLabel.text = "\(storyContents.count)"
    }
}

//MARK: - StoryPresenterProtocol

extension StoryPageViewController: StoryPresenterProtocol {

    //表示するデータを取得した場合の処理
    func showStory(_ story: [Story]) {
        storyContents = story
    }
}

//MARK: - UIScrollViewDelegate

//MEMO: 必要に応じて使う
//extension StoryPageViewController: UIScrollViewDelegate {}

//MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource

extension StoryPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    //ページが動いたタイミング（この場合はスワイプアニメーションに該当）に発動する処理を記載するメソッド
    //（実装例）http://c-geru.com/as_blind_side/2014/09/uipageviewcontroller.html
    //（実装例に関する解説）http://chaoruko-tech.hatenablog.com/entry/2014/05/15/103811
    //（公式ドキュメント）https://developer.apple.com/reference/uikit/uipageviewcontrollerdelegate
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        //スワイプアニメーションが完了していない時には処理をさせなくする
        if !completed { return }

        //ここから先はUIPageViewControllerのスワイプアニメーション完了時に発動する
        if let targetViewControllers = pageViewController.viewControllers {
            if let targetViewController = targetViewControllers.last {

                //現在位置の表示インデクス番号を表示する
                currentIndexLabel.text = "\(targetViewController.view.tag + 1)"
            }
        }
    }

    //逆方向にページ送りした時に呼ばれるメソッド
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        //インデックスを取得する
        guard let index = storyViewControllerLists.index(of: viewController as! StoryViewController) else {
            return nil
        }

        //インデックスの値に応じてコンテンツを動かす
        if index <= 0 {
            return nil
        } else {
            return storyViewControllerLists[index - 1]
        }
    }

    //順方向にページ送りした時に呼ばれるメソッド
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        //インデックスを取得する
        guard let index = storyViewControllerLists.index(of: viewController as! StoryViewController) else {
            return nil
        }

        //インデックスの値に応じてコンテンツを動かす
        if index >= storyViewControllerLists.count - 1 {
            return nil
        } else {
            return storyViewControllerLists[index + 1]
        }
    }
}
