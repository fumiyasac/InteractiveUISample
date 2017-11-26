//
//  StoryDetailPhotoCollectionViewCell.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/26.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import UIKit

class StoryDetailPhotoCollectionViewCell: UICollectionViewCell {

    //UI部品の配置
    @IBOutlet weak var storyDetailPhotoImageView: UIImageView!
    @IBOutlet weak var storyDetailPhotoButton: UIButton!

    //写真表示用のセルをタップした際のアクション（クロージャーで定義する）
    var storyDetailPhotoTappedAction: (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()

        setupStoryDetailPhotoCollectionViewCell()
    }

    //MARK: - Function

    func setCell(_ photo: Photo) {
        if let photoImageData = photo.imageData {
            let minLength: CGFloat = 128.0
            storyDetailPhotoImageView.image = photoImageData.thumbnailOfSize(minLength)
        }
    }

    //MARK: - Private Function

    //入力ボタンのTouchUpInsideのタイミングで実行される処理
    @objc private func onTouchUpInsideStoryDetailPhotoButton(sender: UIButton) {

        //ViewController側でクロージャー内に設定した処理を実行する
        storyDetailPhotoTappedAction?()
    }

    private func setupStoryDetailPhotoCollectionViewCell() {
        //ボタンアクションに関する設定
        storyDetailPhotoButton.addTarget(self, action: #selector(self.onTouchUpInsideStoryDetailPhotoButton(sender:)), for: .touchUpInside)
    }
}
