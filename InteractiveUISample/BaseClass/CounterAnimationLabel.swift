//
//  CounterAnimationLabel.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/19.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit

/**
 * カウンターの様な切り替えアニメーションを伴って値の切り替えを行う機能を入れたUILabelクラス
 * (補足).textで直接入れる場合はアニメーションを伴わない
 *
 * 元ネタ：
 * iOS Swift Tutorial: Create a Counting UILabel Animation 04/24
 * https://www.youtube.com/watch?v=Wz6-IQV_qDw&t=9s
 *
 */

class CounterAnimationLabel: UILabel {

    //MARK: - Public Enum

    //カウンターアニメーションの設定オプション
    public enum CounterAnimationType {
        case Linear
        case EaseIn
        case EaseOut
    }

    //カウンターアニメーションの型(整数 or 小数)設定オプション
    public enum CounterType {
        case Int
        case Float
    }

    //実行を1度だけとするか否かのフラグ
    private var onceFlag = false

    //カウンターアニメーションにおいて値の更新の速さ補正用の値
    private let counterVelocity: Float = 3.0

    //カウント開始の値（この場合は1~9999の中でランダムに決定される）
    private let startNumber: Float = 0.0

    //最終的に.textに格納される値
    private var endNumber: Float = 0.0

    //選択されたアニメーションの全体時間
    private var duration: TimeInterval!

    //選択されたカウンターアニメーションの型
    private var counterType: CounterType!

    //選択されたカウンターアニメーションの設定
    private var counterAnimationType: CounterAnimationType!

    //カウンターアニメーションの差分算出で使用する変数
    private var progress: TimeInterval!
    private var lastUpdate: TimeInterval!

    //計算時に内部に仕込むタイマー
    private var timer: Timer?

    //アニメーション実行時にラベルで表示している数値
    private var currentCounterValue: Float {
        if progress >= duration {
            return endNumber
        }
        let percentage = Float(progress / duration)
        let update = updateCounter(counterValue: percentage)
        
        return startNumber + (update * (endNumber - startNumber))
    }

    //MARK: - Functions

    //アニメーションを伴って値を代入する
    func changeCountValueWithAnimation(_ value: Float, withDuration duration: TimeInterval, andAnimationType animationType: CounterAnimationType, andCounterType counterType: CounterType) {
        self.endNumber = value
        self.duration = duration
        self.counterType = counterType
        self.counterAnimationType = animationType
        self.progress = 0
        self.lastUpdate = Date.timeIntervalSinceReferenceDate

        //カウンターアニメーションが実行されたかを判定する
        if self.onceFlag {
            updateText(value: endNumber)
            return
        } else {
            self.onceFlag = true
        }

        //タイマーの初期化
        invalidateTimer()

        //durationの値が0の場合は従来通り
        if duration == 0 {
            updateText(value: value)
            return
        }

        //0.01秒間隔でupdateValue()メソッドを実行する
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.updateValue), userInfo: nil, repeats: true)
    }

    //MARK: - Private Functions

    //仕込まれたタイマーの間隔で値の更新を行う
    @objc private func updateValue() {
        
        //現在時刻の差分から指定した秒数からどのくらい経過したかを算出する
        let now = Date.timeIntervalSinceReferenceDate
        progress = progress + (now - lastUpdate)
        lastUpdate = now
        
        //経過時間が指定した秒数以上になった場合はタイマーを破棄する
        if progress >= duration {
            invalidateTimer()
            progress = duration
        }

        //値の更新をする
        updateText(value: currentCounterValue)
    }

    //.textの変化の仕方を設定する
    // (参考) アニメーションの変化の仕方：イージングの基本
    // https://developers.google.com/web/fundamentals/design-and-ux/animations/the-basics-of-easing?hl=ja
    private func updateCounter(counterValue: Float) -> Float {
        switch counterAnimationType! {
        case .Linear:
            return counterValue
        case .EaseIn:
            return powf(counterValue, counterVelocity)
        case .EaseOut:
            return 1.0 - powf(1.0 - counterValue, counterVelocity)
        }
    }

    //.textプロパティに値を入れる
    private func updateText(value: Float) {
        switch counterType! {
        case .Int:
            self.text = "\(Int(value))"
        case .Float:
            self.text = String(format: "%.2f", value)
        }
    }

    //タイマーを破棄する
    private func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
}
