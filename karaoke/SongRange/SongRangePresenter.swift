//
//  SongRangePresenter.swift
//  karaoke
//
//  Created by Michael Golubev on 13.10.2024.
//  Copyright (c) 2024. All rights reserved.
//

/// Presentation logic implementation of SongRange scene
final class SongRangePresenter {
    /// View layer instance
    weak var view: SongRangeDisplayLogic?

    // MARK: Initialization
    init(view: SongRangeDisplayLogic) {
        self.view = view
    }
}

// MARK: Implementation of Presenting methods
extension SongRangePresenter: SongRangePresentingLogic {
    func present(_ response: SongRange.Fetch.Response) async {
        await view?.display(
            SongRange.Fetch.ViewModel(
                root: response.model?.viewModel() ?? .init(),
                error: response.error?.localizedDescription
            )
        )
    }

    func present(_ response: SongRange.Move.Response) async {
        await view?.display(
            SongRange.Fetch.ViewModel(
                root: response.model?.viewModel() ?? .init(),
                error: response.error?.localizedDescription
            )
        )
    }

    func present(_ response: SongRange.Close.Response) async {
        await view?.display(
            SongRange.Close.ViewModel()
        )
    }
}

// MARK: Models to ViewModel conversion
private extension SongRange.Model {
    func viewModel() -> SongRange.RootViewModel {
        .init(
            author: "Ed Sheeran",
            song: "Perfect",
            chord: "Am",
            hint: "+12",
            voiceHint: .init(top: "E3", bottom: "F#3"),
            songHint: .init(top: "E3", bottom: "F#3")
        )
    }
}
