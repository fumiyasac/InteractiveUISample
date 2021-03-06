//
//  StoryPictureViewController.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/25.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import UIKit

/**
 * MEMO: Srotyboard内の設定に関して：
 *
 * このControllerでInterfaceBuilderで下記のような形で設定をしておく
 *
 * 手順：
 * (1) storyPictureImageViewに対して、上下左右：0(優先度：1000)の制約をつける
 * (2) このままだと警告が出てしまうのでダミーの画像をInterfaceBuilder経由で入れておく
 * (3) storyPictureImageViewの「Clip to Bounds」にチェックをつけておく
 * (4) storyPictureImageViewのContentModeを「Aspect Fit」にしておく
 * (5) storyPictureImageViewの「User Interaction Enabled」と「Multiple Touch」のチェックをはずす
 * (6) storyPictureScrollViewの「User Interaction Enabled」と「Multiple Touch」のチェックをつけておく
 */
 
class StoryPictureViewController: UIViewController {

    //UI部品の配置
    @IBOutlet weak fileprivate var storyPictureScrollView: UIScrollView!
    @IBOutlet weak fileprivate var storyPictureImageView: UIImageView!
    @IBOutlet weak private var storyPictureCloseButton: UIButton!
    
    //UIScrollViewの中にあるUIImageViewの上下左右の制約
    @IBOutlet weak fileprivate var storyPictureImageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak fileprivate var storyPictureImageBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak fileprivate var storyPictureImageLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak fileprivate var storyPictureImageRightConstraint: NSLayoutConstraint!

    private var targetStoryPicture: Photo? = nil {
        didSet {
            if let photo = targetStoryPicture {
                self.storyPictureImageView.image = photo.imageData
                self.setStoryPictureImageViewScale(self.view.bounds.size)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupStoryPictureScrollView()
        setupStoryDetailBackButton()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //画像スライダー用のUIScrollView等の初期設定を行う
        setStoryPictureImageViewScale(self.view.bounds.size)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Function

    func setPicture(_ photo: Photo) {
        targetStoryPicture = photo
    }

    //MARK: - Private Function

    //一覧に戻るボタンをタップした際に実行されるアクションとの紐付け
    @objc private func onTouchUpInsideStoryPictureCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }

    //Story用の写真を配置したUIScrollViewの初期設定
    private func setupStoryPictureScrollView() {
        storyPictureScrollView.delegate = self
    }

    //Story用の写真の拡大縮小比を設定する
    private func setStoryPictureImageViewScale(_ size: CGSize) {

        //self.viewのサイズを元にUIImageViewに表示する画像の縦横サイズの比を取り、小さい方を適用する
        let widthScale = size.width / storyPictureImageView.bounds.width
        let heightScale = size.height / storyPictureImageView.bounds.height
        let minScale = min(widthScale, heightScale)

        //最小の拡大縮小比
        storyPictureScrollView.minimumZoomScale = minScale

        //現在時点での拡大縮小比
        storyPictureScrollView.zoomScale = minScale
    }

    //戻るボタンの設定を行う
    private func setupStoryDetailBackButton() {
        storyPictureCloseButton.addTarget(self, action: #selector(self.onTouchUpInsideStoryPictureCloseButton), for: .touchUpInside)
    }
}

//MARK: - UIScrollViewDelegate

extension StoryPictureViewController: UIScrollViewDelegate {

    //（重要）UIScrollViewのデリゲートメソッドの一覧：
    //参考にした記事：よく使うデリゲートのテンプレート：
    //https://qiita.com/hoshi005/items/92771d82857e08460e5c

    //ズーム中に実行されてズームの値に対応する要素を返すメソッド
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return storyPictureImageView
    }

    //ズームしたら呼び出されるメソッド ※UIScrollView内のUIImageViewの制約を更新する為に使用する
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateStoryPictureImageViewScale(self.view.bounds.size)
    }

    //UIScrollViewの中で拡大・縮小の動きに合わせて、中のUIImageViewの大きさを変更する
    private func updateStoryPictureImageViewScale(_ size: CGSize) {

        //Y軸方向のAutoLayoutの制約を加算する
        let yOffset = max(0, (size.height - storyPictureImageView.frame.height) / 2)
        storyPictureImageTopConstraint.constant = yOffset
        storyPictureImageBottomConstraint.constant = yOffset

        //X軸方向のAutoLayoutの制約を加算する
        let xOffset = max(0, (size.width - storyPictureImageView.frame.width) / 2)
        storyPictureImageLeftConstraint.constant = xOffset
        storyPictureImageRightConstraint.constant = xOffset

        self.view.layoutIfNeeded()
    }
}
