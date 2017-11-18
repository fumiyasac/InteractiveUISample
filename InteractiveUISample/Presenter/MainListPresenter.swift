//
//  MainListPresenter.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/18.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import Foundation
import UIKit

protocol MainListPresenterProtocol: class {

}

class MainListPresenter {
    var presenter: MainListPresenterProtocol!

    //MARK: - Initializer

    init(presenter: MainListPresenterProtocol) {
        self.presenter = presenter
    }


}
