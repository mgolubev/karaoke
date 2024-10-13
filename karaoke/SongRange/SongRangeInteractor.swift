//
//  SongRangeInteractor.swift
//  karaoke
//
//  Created by Michael Golubev on 13.10.2024.
//  Copyright (c) 2024. All rights reserved.
//

import Foundation

/// Business logic implementation of SongRange scene.
/// It handles request from UI (user interactions and other events), manipulates data using 'workers' and pass responses to presentation layer.
final class SongRangeInteractor {
    /// Presentation layer instance
    private let presenter: SongRangePresentingLogic
    /// Worker instance
    private let worker: SongRangeWorkingLogic

    /// Actor to synchronize state
    private actor StatusActor {
        /// Model received from worker response
        var model: SongRange.Model?

        @discardableResult func update(model: SongRange.Model) -> SongRange.Model {
            self.model = model
            return model
        }
    }
    private let statusActor = StatusActor()

    // MARK: Initialization
    init(presenter: SongRangePresentingLogic, worker: SongRangeWorkingLogic) {
        self.presenter = presenter
        self.worker = worker
    }
}

// MARK: Implementation of Business logic methods
extension SongRangeInteractor: SongRangeBusinessLogic {
    func request(_ request: SongRange.Fetch.Request) async {
        do {
            let model = try await worker.fetch()
            await statusActor.update(model: model)
            await presenter.present(SongRange.Fetch.Response(model: model))
        }
        catch {
            await presenter.present(SongRange.Fetch.Response(error: error))
        }
    }

    func request(_ request: SongRange.Move.Request) async {
        await presenter.present(SongRange.Move.Response(model: await statusActor.model))
    }

    func request(_ request: SongRange.Close.Request) async {
        await presenter.present(SongRange.Close.Response())
    }
}

// MARK: Implementation of Data Store for interacting with other scenes
extension SongRangeInteractor: SongRangeDataStore {}
