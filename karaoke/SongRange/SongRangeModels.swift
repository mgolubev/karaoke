//
//  SongRangeModels.swift
//  karaoke
//
//  Created by Michael Golubev on 13.10.2024.
//  Copyright (c) 2024. All rights reserved.
//

import Foundation

/// Scenes models and use cases description
enum SongRange {
    /// Fetch use case
    enum Fetch {
        struct Request {}

        struct Response {
            var model: Model?
            var error: Error?
        }

        struct ViewModel {
            var root: RootViewModel
            var error: String?
        }
    }

    /// Move use case
    enum Move {
        struct Request {
            let value: Float
        }

        struct Response {
            var model: Model?
            var error: Error?
        }

        struct ViewModel {
            var root: RootViewModel
            var error: String?
        }
    }

    /// Close use case
    enum Close {
        struct Request {}

        struct Response {}

        struct ViewModel {}
    }

    /// Model for presentation
    struct Model {

    }

    /// View model for UI
    struct RootViewModel {
        var author: String?
        var song: String?
        var chord: String?
        var hint: String?
        var voiceHint: SliderHint?
        var songHint: SliderHint?
    }

    struct SliderHint {
        var top: String?
        var bottom: String?
    }
}
