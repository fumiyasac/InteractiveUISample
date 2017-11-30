//
//  SwipeInteractionController.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/26.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit

class SwipeInteractionController: UIPercentDrivenInteractiveTransition {

    //動かしている状態か否かを判定する変数
    var interactionInProgress = false

    //トランジションが終了したか否かを判定する変数
    private var shouldCompleteTransition = false

    //該当するViewControllerを格納する変数 ※弱参照にしておく
    private weak var viewController: UIViewController!

    //MARK: - Function

    //受け取った遷移対象のViewControllerの画面左にGestureRecognizer(UIScreenEdgePanGestureRecognizer)を追加する
    func wireToViewController(_ viewController: UIViewController!) {
        self.viewController = viewController
        prepareGestureRecognizerInView(viewController.view)
    }

    //MARK: - Private Function

    //UIScreenEdgePanGestureRecognizerが発火した際のアクションを定義する
    @objc private func handleGesture(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {

        guard let gestureRecognizerView = gestureRecognizer.view else {
            return
        }

        guard let gestureRecognizerSuperview = gestureRecognizerView.superview else {
            return
        }

        //X軸方向の変化量を算出する
        let translation = gestureRecognizer.translation(in: gestureRecognizerSuperview)
        var progress = (translation.x / 200)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))

        //UIScreenEdgePanGestureRecognizerの状態によって動き方の場合分けにする
        switch gestureRecognizer.state {

        //(1)開始時
        case .began:
            interactionInProgress = true
            viewController.dismiss(animated: true, completion: nil)

        //(2)変更時
        case .changed:
            shouldCompleteTransition = (progress > 0.5)
            update(progress)

        //(3)キャンセル時
        case .cancelled:
            interactionInProgress = false
            cancel()

        //(4)終了時
        case .ended:
            interactionInProgress = false
            if shouldCompleteTransition {
                finish()
            } else {
                cancel()
            }

        default:
            print("This state is unsupported to UIScreenEdgePanGestureRecognizer.")
        }
    }

    //UIScreenEdgePanGestureRecognizerを追加する
    private func prepareGestureRecognizerInView(_ view: UIView) {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handleGesture(_:)))
        gesture.edges = UIRectEdge.left
        view.addGestureRecognizer(gesture)
    }
}

