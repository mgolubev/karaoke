//
//  SongRangeViewController.swift
//  karaoke
//
//  Created by Michael Golubev on 13.10.2024.
//  Copyright (c) 2024. All rights reserved.
//

import UIKit

/// Display logic implementation of SongRange scene
final class SongRangeViewController: UIViewController {
    var interactor: SongRangeBusinessLogic?
    var router: SongRangeRoutingLogic?

    private lazy var rootView = SongRangeView()

    override func loadView() {
        view = rootView
        rootView.actionHandler = { [weak interactor] action in
            guard let interactor else { return }
            Task {
                switch action {
                case .close:
                    await interactor.request(SongRange.Close.Request())
                case .move(let value):
                    print("vertical drag \(value)")
                    await interactor.request(SongRange.Move.Request(value: value))
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await interactor?.request(SongRange.Fetch.Request())
        }
    }
}

// MARK: Implementation of Viewing methods. Update view model or call router.
extension SongRangeViewController: SongRangeDisplayLogic {
    func display(_ viewModel: SongRange.Fetch.ViewModel) async {
        rootView.viewModel = viewModel.root
    }

    func display(_ viewModel: SongRange.Move.ViewModel) async {
        rootView.viewModel = viewModel.root
    }

    func display(_ viewModel: SongRange.Close.ViewModel) async {
        router?.close()
    }
}
