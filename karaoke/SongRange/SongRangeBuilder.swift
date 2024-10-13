//
//  SongRangeBuilder.swift
//  karaoke
//
//  Created by Michael Golubev on 13.10.2024.
//  Copyright (c) 2024. All rights reserved.
//

import UIKit

/// Helper 'builder' class which allows to configure scene correctly.
/// Usually there is nothing to change here
final class SongRangeBuilder {
    func build() -> UIViewController {
        let viewController = SongRangeViewController()
        let presenter = SongRangePresenter(view: viewController)
        let interactor = SongRangeInteractor(
            presenter: presenter,
            worker: SongRangeWorker()
        )
        let router = SongRangeRouter(
            viewController: viewController,
            dataStore: interactor
        )
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
