//
//  HistoryRowDescriptable.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 14.01.2022.
//

import CoreModels

@MainActor
protocol HistoryRowDescriptable {
    func playersDescription(for gather: Gather) -> String
}

struct TeamARowDescription {
    private let viewModel: HistoryViewModel
    
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
    }
}

extension TeamARowDescription: HistoryRowDescriptable {
    func playersDescription(for gather: Gather) -> String {
        viewModel.teamAPlayersDescription(for: gather)
    }
}

struct TeamBRowDescription {
    private let viewModel: HistoryViewModel
    
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
    }
}

extension TeamBRowDescription: HistoryRowDescriptable {
    func playersDescription(for gather: Gather) -> String {
        viewModel.teamBPlayersDescription(for: gather)
    }
}
