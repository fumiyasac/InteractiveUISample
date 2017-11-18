//
//  MainListTableViewCell.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/14.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import UIKit
import FontAwesome_swift

class MainListTableViewCell: UITableViewCell {

    //UI部品の配置
    @IBOutlet weak var listImageWrappedView: UIView!
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var listImageCategoryLabel: UILabel!

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

    //FontAwesome_Swiftで表示するイメージのサイズ
    private let creditIconImageSize: CGSize = CGSize(width: 30, height: 30)

    //視差効果の計算用の変数
    private var imageBackTopInitial: CGFloat!
    private var imageBackBottomInitial: CGFloat!

    //ViewControllerへ処理内容を引き渡すためのクロージャー
    var showArticleAction: (() -> ())?
    
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

    //入力ボタンを押したタイミングで実行される処理
    @objc private func onDownArticleButton(sender: UIButton) {
        UIView.animate(withDuration: 0.06, animations: {
            self.toArticleButtonWrappedView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }

    //入力ボタンを押して離したタイミングで実行される処理
    @objc private func onUpArticleButton(sender: UIButton) {
        UIView.animate(withDuration: 0.06, animations: {
            self.toArticleButtonWrappedView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { finished in

            //ViewController側でクロージャー内に設定した処理を実行する
            self.showArticleAction?()
        })
    }
 
    //このクラスの初期設定を行う
    private func setupMainListTableViewCell() {

        //セルの装飾設定をする
        self.accessoryType = .none
        self.selectionStyle = .none

        //意図的にずらした値を視差効果の計算用の変数にそれぞれセットする
        clipsToBounds = true
        bottomImageViewConstraint.constant -= 2 * imageParallaxFactor
        imageBackTopInitial = topImageViewConstraint.constant
        imageBackBottomInitial = bottomImageViewConstraint.constant

        //画像のアイコンをつける
        creditIconImageView.image = UIImage.fontAwesomeIcon(name: .photo, textColor: ColorDefinition.navigationColor.getColor(), size: creditIconImageSize)

        //ボタンの丸みをつける
        toArticleButtonWrappedView.layer.cornerRadius = 5.0
        toArticleButtonWrappedView.layer.masksToBounds = true

        //画像の外枠UIViewに枠線をつける
        listImageWrappedView.layer.borderWidth = 1
        listImageWrappedView.layer.borderColor = UIColor.init(code: "dddddd").cgColor

        //ボタンアクションに関する設定
        //TouchUp・TouchDownの時のイベントを設定する（完了時の具体的な処理はTouchUp側で設定すること）
        toArticleButton.addTarget(self, action: #selector(self.onDownArticleButton(sender:)), for: .touchDown)
        toArticleButton.addTarget(self, action: #selector(self.onUpArticleButton(sender:)), for: [.touchUpInside, .touchUpOutside])
    }
}
