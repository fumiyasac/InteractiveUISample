//
//  FlipPresentCustomTransition.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/26.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit

class FlipPresentCustomTransition: NSObject {

    //トランジション（実行）の秒数
    fileprivate let duration: TimeInterval = 0.48

    //ディレイ（遅延）の秒数
    fileprivate let delay: TimeInterval = 0.00
}

extension FlipPresentCustomTransition: UIViewControllerAnimatedTransitioning {

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

        //コンテキストを元にViewControllerのインスタンスを取得する（存在しない場合は処理を終了）
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            return
        }

        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }

        //アニメーションの実態となるコンテナビューを作成する
        let containerView = transitionContext.containerView

        //遷移前と遷移後のframe（大きさと位置）を定義する
        let initialFrame = CGRect(x: 0, y: 0, width: CGFloat(DeviceSize.screenWidth()), height: CGFloat(DeviceSize.screenHeight()))
        let finalFrame = transitionContext.finalFrame(for: toViewController)

        //UIViewのスナップショットを取得する
        // (参考) snapshotViewに関する公式ドキュメント
        // https://developer.apple.com/documentation/uikit/uiview/1622531-snapshotview
        guard let snapshotView = toViewController.view.snapshotView(afterScreenUpdates: true) else {
            return
        }

        //スナップショットの設定
        snapshotView.frame = initialFrame
        snapshotView.layer.masksToBounds = true

        //コンテナビューの中に遷移先のViewControllerを配置し、更にその上にスナップショットのViewを配置する
        containerView.addSubview(toViewController.view)
        containerView.addSubview(snapshotView)

        //遷移先のViewControllerは非表示の状態にしておく
        toViewController.view.isHidden = true

        //CoreAnimationを用いて回転して切り替える処理を登録しておく
        /**
         * 今回のサンプルの動きに関しては下記の記事で紹介されているサンプルを元に実装している
         *
         * 参考: Custom UIViewController Transitions: Getting Started
         * https://www.raywenderlich.com/170144/custom-uiviewcontroller-transitions-getting-started
         */

        //コンテナビューに適用するパースペクティブを設定する
        /**
         * 参考: [Objective-C] フリップアニメーションでビューを切り替える
         * https://qiita.com/edo_m18/items/45fcbc67154eb68ef469
         */
        var perspectiveTransform = CATransform3DIdentity
        perspectiveTransform.m34 = -0.002
        containerView.layer.sublayerTransform = perspectiveTransform

        //X軸に対して90°(π/2ラジアン)回転させる
        /**
         * 角度の計算を利用して裏返しをして画面遷移を行うようにする
         *
         * 参考1: 【iOS Swift入門 #233】表裏(両面)をもつViewを作る
         * http://swift.swift-studying.com/entry/2015/07/18/115735
         * 参考2: Effect – UIViewで裏返せるパネルをつくる
         * http://lepetit-prince.net/ios/?p=631
         */
        snapshotView.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi / 2), 0.0, 1.0, 0.0)

        //アニメーションを実行する秒数設定する
        let targetDuration = transitionDuration(using: transitionContext)

        //キーフレームアニメーションを設定する
        UIView.animateKeyframes(withDuration: targetDuration, delay: delay, options: .calculationModeCubic, animations: {

            //キーフレーム(1)
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3, animations: {
               fromViewController.view.layer.transform = CATransform3DMakeRotation(CGFloat(-Double.pi / 2), 0.0, 1.0, 0.0)
            })

            //キーフレーム(2)
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
                snapshotView.layer.transform = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0)
            })

            //キーフレーム(3)
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                snapshotView.frame = finalFrame
            })

        }, completion: { _ in

            //アニメーションが完了した際の処理を実行する
            toViewController.view.isHidden = false
            snapshotView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
