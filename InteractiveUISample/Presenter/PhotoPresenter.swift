//
//  PhotoPresenter.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/26.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoPresenterProtocol: class {
    func showPhoto(_ photo: [Photo])
}

class PhotoPresenter {
    var presenter: PhotoPresenterProtocol!

    //MARK: - Initializer

    init(presenter: PhotoPresenterProtocol) {
        self.presenter = presenter
    }

    //MARK: - Functions

    //サンプルニュースデータを取得する
    func getPhoto() {
        let photoLists = getDummyPhotoData()
        self.presenter.showPhoto(photoLists)
    }

    //MARK: - Private Functions

    //サンプルデータを作成する
    private func getDummyPhotoData() -> [Photo] {
        return [
            Photo(id: 1, imageName: "photo1"),
            Photo(id: 2, imageName: "photo2"),
            Photo(id: 3, imageName: "photo3"),
            Photo(id: 4, imageName: "photo4"),
            Photo(id: 5, imageName: "photo5"),
            Photo(id: 6, imageName: "photo6")
        ]
    }
}
