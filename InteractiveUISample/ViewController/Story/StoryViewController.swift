//
//  StoryViewController.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/19.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {

    //UI部品の配置
    @IBOutlet weak var storyCardView: StoryCardView!

    //適用するカスタムトランジションのクラス
    fileprivate let flipPresentCustomTransition = FlipPresentCustomTransition()
    fileprivate let flipDismissCustomTransition = FlipDismissCustomTransition()

    //スワイプアクションに関するControllerのインスタンス
    fileprivate let swipeInteractionController = SwipeInteractionController()

    //表示対象のストーリーデータを格納する変数
    private var targetStory: Story!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupStoryCardView()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToStoryDetailViewController", let destinationViewController = segue.destination as? StoryDetailViewController {

            destinationViewController.setStoryDetail(targetStory)
            destinationViewController.transitioningDelegate = self
            swipeInteractionController.wireToViewController(destinationViewController)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Function

    func setStoryCardView(_ story: Story) {
        targetStory = story
        storyCardView.setStory(story)
    }

    //MARK: - Private Function

    //カード状Viewをタップした際に実行されるアクションとの紐付け
    @objc private func storyCardViewTapped() {
        performSegue(withIdentifier: "ToStoryDetailViewController", sender: nil)
    }

    //カード状Viewの設定
    private func setupStoryCardView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.storyCardViewTapped))
        storyCardView.addGestureRecognizer(tapGestureRecognizer)
    }
}

//MARK: - UIViewControllerTransitioningDelegate

extension StoryViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return flipPresentCustomTransition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return flipDismissCustomTransition
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return swipeInteractionController.interactionInProgress ? swipeInteractionController : nil
    }
}
