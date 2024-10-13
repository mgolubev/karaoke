//
//  SongRangeProtocols.swift
//  karaoke
//
//  Created by Michael Golubev on 13.10.2024.
//  Copyright (c) 2024. All rights reserved.
//

import Foundation

/// SongRange interactor protocol
protocol SongRangeBusinessLogic: AnyObject {
    func request(_ request: SongRange.Fetch.Request) async
    func request(_ request: SongRange.Move.Request) async
    func request(_ request: SongRange.Close.Request) async
}

/// SongRange presenter protocol
protocol SongRangePresentingLogic: AnyObject {
    func present(_ response: SongRange.Fetch.Response) async
    func present(_ response: SongRange.Move.Response) async
    func present(_ response: SongRange.Close.Response) async
}

/// SongRange view protocol
protocol SongRangeDisplayLogic: AnyObject {
    func display(_ viewModel: SongRange.Fetch.ViewModel) async
    func display(_ viewModel: SongRange.Move.ViewModel) async
    func display(_ viewModel: SongRange.Close.ViewModel) async
}

/// SongRange router protocol
protocol SongRangeRoutingLogic: AnyObject {
    func show()
    func close()
}

/// SongRange data store protocol to pass data between scenes
protocol SongRangeDataStore: AnyObject {}

/// SongRange worker protocol
protocol SongRangeWorkingLogic: AnyObject {
    func fetch() async throws -> SongRange.Model
}
