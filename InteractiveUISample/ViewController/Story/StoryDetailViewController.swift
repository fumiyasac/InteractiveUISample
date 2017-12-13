//
//  StoryDetailViewController.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/19.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import UIKit

class StoryDetailViewController: UIViewController {

    //UI部品の配置
    @IBOutlet weak private var storyDetailImageView: UIImageView!

    @IBOutlet weak private var storyDetailHeaderWrappedView: UIView!
    @IBOutlet weak private var storyDetailBackButton: UIButton!

    @IBOutlet weak private var storyDetailContentsWrappedView: UIView!
    @IBOutlet weak private var storyDetailTextView: UITextView!
    @IBOutlet weak private var storyDetailPhotoCollectionView: UICollectionView!

    //グラデーションレイヤーを作成
    private let gradientLayer: CAGradientLayer = CAGradientLayer()

    //写真コンテンツを格納するための変数
    fileprivate var photoContents: [Photo] = [] {
        didSet {
            self.storyDetailPhotoCollectionView.reloadData()
        }
    }

    //PhotoPresenterに設定したプロトコルを適用するための変数
    fileprivate var presenter: PhotoPresenter!

    //詳細表示用のデータを格納するための変数
    private var targetMainText: String!
    private var targetPhoto: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupStoryDetail()
        setupStoryDetailPhotoCollectionView()
        setupPhotoPresenter()
        setupStoryDetailImageGradation()
        setupStoryDetailBackButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Function

    func setStoryDetail(_ story: Story) {
        targetMainText = story.mainText
        targetPhoto = story.photo
    }

    //MARK: - Private Function

    //一覧に戻るボタンをタップした際に実行されるアクションとの紐付け
    @objc private func onTouchUpInsideStoryDetailBackButton() {
        self.dismiss(animated: true, completion: nil)
    }

    //詳細表示用の初期化を行う
    private func setupStoryDetail() {
        storyDetailTextView.text = targetMainText
        storyDetailImageView.image = targetPhoto
    }

    //写真表示用のUICollectionViewの初期化を行う
    private func setupStoryDetailPhotoCollectionView() {
        storyDetailPhotoCollectionView.delegate = self
        storyDetailPhotoCollectionView.dataSource = self
        storyDetailPhotoCollectionView.registerCustomCell(StoryDetailPhotoCollectionViewCell.self)
    }

    //Presenterとの接続に関する設定を行う
    private func setupPhotoPresenter() {
        presenter = PhotoPresenter(presenter: self)
        presenter.getPhoto()
    }

    //背景グラデーションの設定を行う
    private func setupStoryDetailImageGradation() {

        //グラデーションの色を配列で管理（上部分 & 下部分）
        let gradientColors: [CGColor] = [
            UIColor.init(code: "#555555", alpha: 0.30).cgColor,
            UIColor.init(code: "#000000", alpha: 0.53).cgColor
        ]

        //グラデーションの色をレイヤーに割り当てる
        gradientLayer.colors = gradientColors

        //グラデーションレイヤーを下に敷いたImageViewと同じにする(ImageViewは画面いっぱいにしているのでself.view.frameにしている)
        gradientLayer.frame = self.view.frame

        //グラデーションレイヤーをビューの一番下に配置
        storyDetailImageView.layer.insertSublayer(gradientLayer, at: 0)
    }

    //戻るボタンの設定を行う
    private func setupStoryDetailBackButton() {
        storyDetailBackButton.addTarget(self, action: #selector(self.onTouchUpInsideStoryDetailBackButton), for: .touchUpInside)
    }
}

//MARK: - PhotoPresenterProtocol

extension StoryDetailViewController: PhotoPresenterProtocol {

    //写真に表示するデータを取得した場合の処理
    func showPhoto(_ photo: [Photo]) {
        photoContents = photo
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension StoryDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoContents.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCustomCell(with: StoryDetailPhotoCollectionViewCell.self, indexPath: indexPath)
        let photo = photoContents[indexPath.row]

        cell.setCell(photo)
        cell.storyDetailPhotoTappedAction = {

            //ギャラリーの写真を表示する処理をクロージャー内に記載する
            let storyPictureViewController = UIStoryboard(name: "Story", bundle: nil).instantiateViewController(withIdentifier: "StoryPictureViewController") as! StoryPictureViewController

            storyPictureViewController.modalPresentationStyle = .overCurrentContext
            storyPictureViewController.modalTransitionStyle = .crossDissolve
            storyPictureViewController.view.backgroundColor = UIColor.darkGray
            storyPictureViewController.setPicture(photo)

            self.present(storyPictureViewController, animated: true, completion: nil)
        }
        return cell
    }
}
