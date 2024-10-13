//
//  SongRangeWorker.swift
//  karaoke
//
//  Created by Michael Golubev on 13.10.2024.
//  Copyright (c) 2024. All rights reserved.
//

import Foundation

/// Working logic implementation of SongRange scene
/// It handles any calls related to data manipulating (database, network, etc.)
final class SongRangeWorker: SongRangeWorkingLogic {
    func fetch() async throws -> SongRange.Model {
        .init()
    }
}
