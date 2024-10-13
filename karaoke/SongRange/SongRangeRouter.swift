//
//  SongRangeRouter.swift
//  karaoke
//
//  Created by Michael Golubev on 13.10.2024.
//  Copyright (c) 2024. All rights reserved.
//

import UIKit

/// Routing logic implementation of SongRange scene
final class SongRangeRouter {
    /// weak reference of owner view controller. Use it to display child screens or notify this scene about changes from childs
    weak var viewController: SongRangeViewController?
    /// interface to exchange data between scenes
    let dataStore: SongRangeDataStore

    // MARK: Initialization
    init(
        viewController: SongRangeViewController,
        dataStore: SongRangeDataStore
    ) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

// MARK: Implementation of Routing methods
extension SongRangeRouter: SongRangeRoutingLogic {
    func show() {

    }

    func close() {
        
    }
}
