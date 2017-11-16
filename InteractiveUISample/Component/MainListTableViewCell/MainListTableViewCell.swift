//
//  MainListTableViewCell.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/14.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import UIKit

class MainListTableViewCell: UITableViewCell {

    //ViewControllerへ処理内容を引き渡すためのクロージャー
    var showArticleAction: (() -> ())?

    //UI部品の配置
    @IBOutlet weak var listImageWrappedView: UIView!
    @IBOutlet weak var listImageView: UIImageView!

    @IBOutlet weak var creditIconImageView: UIImageView!
    @IBOutlet weak var creditNameLabel: UILabel!

    @IBOutlet weak var listTitleLabel: UILabel!
    @IBOutlet weak var listDescriptionLabel: UILabel!

    @IBOutlet weak var toArticleButtonWrappedView: UIView!
    @IBOutlet weak var toArticleButton: UIButton!

    //UIViewに内包したUIImageViewの上下の制約
    @IBOutlet weak var topImageViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomImageViewConstraint: NSLayoutConstraint!
    
    //視差効果のズレを生むための定数（大きいほど視差効果が大きい）
    private let imageParallaxFactor: CGFloat = 75

    //視差効果の計算用の変数
    private var imageBackTopInitial: CGFloat!
    private var imageBackBottomInitial: CGFloat!

    override func awakeFromNib() {
        super.awakeFromNib()

        setupMainListTableViewCell()
    }

    //MARK: - Functions

    //画像にかけられているAutoLayoutの制約を再計算して制約をかけ直す
    func setBackgroundOffset(_ offset: CGFloat) {
        let boundOffset = max(0, min(1, offset))
        let pixelOffset = (1 - boundOffset) * 2 * imageParallaxFactor
        topImageViewConstraint.constant = imageBackTopInitial - pixelOffset
        bottomImageViewConstraint.constant = imageBackBottomInitial + pixelOffset
    }

    //MARK: - Private Functions

    //このクラスの初期設定を行う
    private func setupMainListTableViewCell() {
 
        //意図的にずらした値を視差効果の計算用の変数にそれぞれセットする
        clipsToBounds = true
        bottomImageViewConstraint.constant -= 2 * imageParallaxFactor
        imageBackTopInitial = topImageViewConstraint.constant
        imageBackBottomInitial = bottomImageViewConstraint.constant

        //ボタンの丸みをつける
        toArticleButton.layer.cornerRadius = 5.0
        
        //画像の外枠UIViewに枠線をつける
        listImageWrappedView.layer.borderWidth = 1
        listImageWrappedView.layer.borderColor = UIColor.init(code: "dddddd").cgColor
    }
}
