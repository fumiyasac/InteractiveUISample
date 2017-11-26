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

    @IBOutlet weak fileprivate var currentIndexLabel: UILabel!
    @IBOutlet weak fileprivate var totalIndexLabel: UILabel!

    //Storyデータの表示数
    fileprivate let storyViewControllerListsCount: Int = 3

    //ContainerViewにEmbedしたUIPageViewControllerのインスタンスを保持する
    fileprivate var pageViewController: UIPageViewController?

    //ページングして表示させるViewControllerを保持する配列
    fileprivate var storyViewControllerLists = [StoryViewController]()

    //Storyデータを格納するための配列


    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupHeaderBackButton()
        setupBackgroundImage()
        setupPageViewController()
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

        //NavigationControllerのデザイン調整を行う
        self.navigationController?.navigationBar.barTintColor = ColorDefinition.navigationColor.getColor()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]

        //タイトルを入れる
        self.navigationItem.title = "Story一覧"
    }

    //戻るボタンに関するセッティングを行う
    private func setupHeaderBackButton() {

        //戻るボタンとアクション対象メソッドの紐付けをする
        headerBackButton.addTarget(self, action: #selector(self.headerBackButtonAction), for: .touchUpInside)
    }

    //背景の設定
    private func setupBackgroundImage() {
        storyBackgroundImage.image = UIImage(named: "background_sample")
    }

    private func setupPageViewController() {

        //UIPageViewControllerで表示するViewControllerの作成
        setupStoryViewControllerLists()

        //ContainerViewにEmbedしたUIPageViewControllerを取得する
        pageViewController = childViewControllers[0] as? UIPageViewController

        //UIPageViewControllerのデータソースの宣言
        pageViewController!.delegate = self
        pageViewController!.dataSource = self

        //最初に表示する画面として配列の先頭のViewControllerを設定する
        pageViewController!.setViewControllers([storyViewControllerLists[0]], direction: .forward, animated: false, completion: nil)
    }

    //Storyboard上に配置したViewController(StoryboardID = StoryViewController)をインスタンス化して配列に追加する
    private func setupStoryViewControllerLists() {

        for index in 0...storyViewControllerListsCount {
            let storyboard: UIStoryboard = UIStoryboard(name: "Story", bundle: Bundle.main)
            let storyViewController = storyboard.instantiateViewController(withIdentifier: "StoryViewController") as! StoryViewController
            
            //「タグ番号 = インデックスの値」でスワイプ完了時にどのViewControllerかを判別できるようにする
            storyViewController.view.tag = index
            
            //storyViewControllerListsに追加する
            storyViewControllerLists.append(storyViewController)
        }

        //StoryViewControllerの総数をセットする
        totalIndexLabel.text = "\(storyViewControllerListsCount)"
    }
}

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
        if index >= storyViewControllerListsCount - 1 {
            return nil
        } else {
            return storyViewControllerLists[index + 1]
        }
    }
}
