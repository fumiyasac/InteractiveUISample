//
//  ArticleStoryTableViewCell.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/18.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import UIKit

class ArticleStoryTableViewCell: UITableViewCell {

    //UI部品の配置
    @IBOutlet weak private var articleStoryImageWrappedView: UIView!
    @IBOutlet weak private var articleStoryButtonWrappedView: UIView!
    @IBOutlet weak private var articleStoryButton: UIButton!

    //ViewControllerへ処理内容を引き渡すためのクロージャー
    var showStoryAction: (() -> ())?

    //MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()

        setupArticleStoryTableViewCell()
    }

    //MARK: - Private Function

    //入力ボタンのTouchDownのタイミングで実行される処理
    @objc private func onTouchDownArticleStoryButton(sender: UIButton) {
        UIView.animate(withDuration: 0.16, animations: {
            self.articleStoryButtonWrappedView.transform = CGAffineTransform(scaleX: 0.94, y: 0.94)
        }, completion: nil)
    }

    //入力ボタンのTouchUpInsideのタイミングで実行される処理
    @objc private func onTouchUpInsideArticleStoryButton(sender: UIButton) {
        UIView.animate(withDuration: 0.16, animations: {
            self.articleStoryButtonWrappedView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { finished in
            
            //ViewController側でクロージャー内に設定した処理を実行する
            self.showStoryAction?()
        })
    }

    //入力ボタンのTouchUpOutsideのタイミングで実行される処理
    @objc private func onTouchUpOutsideArticleStoryButton(sender: UIButton) {
        UIView.animate(withDuration: 0.16, animations: {
            self.articleStoryButtonWrappedView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }

    private func setupArticleStoryTableViewCell() {

        //セルの装飾設定をする
        self.accessoryType  = .none
        self.selectionStyle = .none

        //写真付きサムネイル枠の装飾設定
        articleStoryImageWrappedView.layer.masksToBounds = false
        articleStoryImageWrappedView.layer.cornerRadius = 5.0
        articleStoryImageWrappedView.layer.borderColor = UIColor.init(code: "dddddd").cgColor
        articleStoryImageWrappedView.layer.borderWidth = 1
        articleStoryImageWrappedView.layer.shadowRadius = 2.0
        articleStoryImageWrappedView.layer.shadowOpacity = 0.15
        articleStoryImageWrappedView.layer.shadowOffset = CGSize(width: 0, height: 1)
        articleStoryImageWrappedView.layer.shadowColor = UIColor.black.cgColor

        //ボタンの丸みをつける
        articleStoryButtonWrappedView.layer.cornerRadius = 5.0
        articleStoryButtonWrappedView.layer.masksToBounds = true

        //ボタンアクションに関する設定
        //TouchDown・TouchUpInside・TouchUpOutsideの時のイベントを設定する（完了時の具体的な処理はTouchUpInside側で設定すること）
        articleStoryButton.addTarget(self, action: #selector(self.onTouchDownArticleStoryButton(sender:)), for: .touchDown)
        articleStoryButton.addTarget(self, action: #selector(self.onTouchUpInsideArticleStoryButton(sender:)), for: .touchUpInside)
        articleStoryButton.addTarget(self, action: #selector(self.onTouchUpOutsideArticleStoryButton(sender:)), for: .touchUpOutside)
    }
}
