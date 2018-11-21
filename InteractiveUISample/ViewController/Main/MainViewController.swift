//
//  MainViewController.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/12.
//  Copyright © 2017年 酒井文也. All rights reserved.
//
import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var navigationScrollView: UIScrollView!
    @IBOutlet weak var contentsScrollView: UIScrollView!

    //ナビゲーション用のScrollViewの中に入れる動く下線用のView
    fileprivate var bottomLineView: UIView = UIView()

    //ナビゲーション用のScrollViewの中に入れる動く下線用のViewの高さ
    fileprivate let navigationBottomLinePositionHeight: Int = 2

    //ナビゲーションのボタン名
    private let navigationNameList: [String] = ["新着特集", "コンテンツ紹介"]

    //UIScrollView内のレイアウト決定に関する処理 ※この中でviewDidLayoutSubviewsで行うUI部品の初期配置に関する処理を行う
    private lazy var setNavigationScrollView: (() -> ())? = {
        setupButtonsInNavigationScrollView()
        setupBottomLineInNavigationScrollView()
        return nil
    }()
    
    //スクロールビューの識別用タグ定義
    private enum ScrollViewIdentifier: Int {
        case navigation = 0
        case contents
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupContentsScrollView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //ナビゲーション用のスクロールビューに関する設定をする
        setNavigationScrollView?()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Private Function

    //ナビゲーションに配置されたボタンを押した時のアクション設定
    @objc private func navigationScrollViewButtonTapped(button: UIButton) {

        //押されたボタンのタグを取得
        let page: Int = button.tag

        //ナビゲーション用のボタンが押された場合は
        animateBottomLineView(Double(page), actionIdentifier: .navigationButtonTapped)
        animateContentScrollView(page)
    }

    //この画面のナビゲーションバーの設定
    private func setupNavigationBar() {

        //NavigationControllerのデザイン調整を行う
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]

        //タイトルを入れる
        self.navigationItem.title = "海の見える風景"
    }

    //コンテンツ表示用のUIScrollViewの設定
    private func setupContentsScrollView() {
        contentsScrollView.delegate = self
        contentsScrollView.isPagingEnabled = true
        contentsScrollView.showsHorizontalScrollIndicator = false
    }

    //ボタン表示用のUIScrollViewの設定
    //MEMO: private lazy var setNavigationScrollView: (() -> ())? 内に設定
    private func setupButtonsInNavigationScrollView() {

        //スクロールビュー内のサイズを決定する
        let navigationScrollViewWidth = Int(navigationScrollView.frame.width)
        let navigationScrollViewHeight = Int(navigationScrollView.frame.height)
        navigationScrollView.contentSize = CGSize(width: navigationScrollViewWidth, height: navigationScrollViewHeight)
        
        //スクロールビュー内にUIButtonを配置する
        for i in 0..<navigationNameList.count {
            let button = UIButton(
                frame: CGRect(
                    x: CGFloat(navigationScrollViewWidth / 2 * i),
                    y: CGFloat(0),
                    width: CGFloat(navigationScrollViewWidth / 2),
                    height: CGFloat(navigationScrollViewHeight)
                )
            )
            button.backgroundColor = UIColor.clear
            button.titleLabel!.font = UIFont(name: AppConstants.BOLD_FONT_NAME, size: 14)!
            button.setTitle(navigationNameList[i], for: UIControl.State())
            button.setTitleColor(ColorDefinition.navigationColor.getColor(), for: UIControl.State())
            button.tag = i
            button.addTarget(self, action: #selector(self.navigationScrollViewButtonTapped(button:)), for: .touchUpInside)

            navigationScrollView.addSubview(button)
        }
    }

    //ナビゲーション用のScrollViewの中に入れる動く下線の設定
    //MEMO: private lazy var setNavigationScrollView: (() -> ())? 内に設定
    private func setupBottomLineInNavigationScrollView() {
        let navigationScrollViewWidth = Int(navigationScrollView.frame.width)
        let navigationScrollViewHeight = Int(navigationScrollView.frame.height)
        
        bottomLineView.frame = CGRect(
            x: CGFloat(0),
            y: CGFloat(navigationScrollViewHeight - navigationBottomLinePositionHeight),
            width: CGFloat(navigationScrollViewWidth / 2),
            height: CGFloat(navigationBottomLinePositionHeight)
        )
        bottomLineView.backgroundColor = ColorDefinition.navigationColor.getColor()
        navigationScrollView.addSubview(bottomLineView)
        navigationScrollView.bringSubviewToFront(bottomLineView)
    }
}

//MARK: - UIScrollViewDelegate

extension MainViewController: UIScrollViewDelegate {

    //animateBottomLineViewを実行する際に行われたアクションを識別するためのenum値
    fileprivate enum ActionIdentifier {
        case contentsSlide
        case navigationButtonTapped
        
        //対応するアニメーションの秒数を返す
        func duration() -> Double {
            switch self {
            case .contentsSlide:
                return 0
            case .navigationButtonTapped:
                return 0.26
            }
        }
    }

    //スクロールが発生した際に行われる処理 (※ UIScrollViewDelegate)
    func scrollViewDidScroll(_ scrollview: UIScrollView) {

        //現在表示されているページ番号を判別する
        let pageWidth = contentsScrollView.frame.width
        let fractionalPage = Double(contentsScrollView.contentOffset.x / pageWidth)
        
        //ボタン配置用のスクロールビューもスライドさせる
        animateBottomLineView(fractionalPage, actionIdentifier: .contentsSlide)
    }

    //ナビゲーション用のScrollViewの中に入れる動く下線を所定位置まで動かす
    fileprivate func animateBottomLineView(_ page: Double, actionIdentifier: ActionIdentifier) {
        let navigationScrollViewWidth = Int(navigationScrollView.frame.width)
        let navigationScrollViewHeight = Int(navigationScrollView.frame.height)

        //X軸方向の動かす終点位置を決める
        let positionX = Double(navigationScrollViewWidth / 2) * page

        UIView.animate(withDuration: actionIdentifier.duration(), animations: {
            self.bottomLineView.frame = CGRect(
                x: CGFloat(positionX),
                y: CGFloat(navigationScrollViewHeight - self.navigationBottomLinePositionHeight),
                width: CGFloat(navigationScrollViewWidth / 2),
                height: CGFloat(self.navigationBottomLinePositionHeight)
            )
        })
    }

    //コンテンツ用のScrollViewを所定位置まで動かす
    fileprivate func animateContentScrollView(_ page: Int) {
        UIView.animate(withDuration: 0.26, animations: {
            self.contentsScrollView.contentOffset = CGPoint(
                x: Int(self.contentsScrollView.frame.width) * page,
                y: 0
            )
        })
    }
}
