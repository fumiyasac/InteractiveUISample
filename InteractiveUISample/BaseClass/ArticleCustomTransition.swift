//
//  ArticleCustomTransition.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/18.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit

class ArticleCustomTransition: NSObject {

    //トランジション（実行）の秒数
    fileprivate let duration: TimeInterval = 0.30

    //ディレイ（遅延）の秒数
    fileprivate let delay: TimeInterval = 0.00

    //トランジションの方向(present: true, dismiss: false)
    var presenting = true
}

extension ArticleCustomTransition: UIViewControllerAnimatedTransitioning {

    //アニメーションの時間を定義する
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    /**
     * アニメーションの実装を定義する
     * この場合には画面遷移コンテキスト（UIViewControllerContextTransitioningを採用したオブジェクト）
     * → 遷移元や遷移先のViewControllerやそのほか関連する情報が格納されているもの
     */
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        //コンテキストを元にViewのインスタンスを取得する（存在しない場合は処理を終了）
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
            return
        }

        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            return
        }

        //アニメーションの実態となるコンテナビューを作成する
        let containerView = transitionContext.containerView

        //ContainerView内の左右のオフセット状態の値を決定する
        let offScreenRight = CGAffineTransform(translationX: containerView.frame.width, y: 0)
        let offScreenLeft = CGAffineTransform(translationX: -containerView.frame.width, y: 0)

        //遷移先のViewControllerの初期位置を決定する
        if presenting {
            toView.transform = offScreenRight
        } else {
            toView.transform = offScreenLeft
        }

        //アニメーションの実体となるContainerViewに必要なものを追加する
        containerView.addSubview(toView)

        //NavigationControllerに似たアニメーションを実装する
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {

            //遷移元のViewControllerを移動させる
            if self.presenting {
                fromView.transform = offScreenLeft
            } else {
                fromView.transform = offScreenRight
            }

            //遷移先のViewControllerが画面に表示されるようにする
            toView.transform = CGAffineTransform.identity

        }, completion:{ finished in
            transitionContext.completeTransition(true)
        })
    }
}
