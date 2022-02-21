//
//  HistoryRowDescriptable.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 14.01.2022.
//

import CoreModels

protocol HistoryRowDescriptable {
    var title: String { get }
    
    func playersDescription(for gather: Gather) -> String
}

struct TeamARowDescription: HistoryRowDescriptable {
    private let viewModel: HistoryViewModel
    let title = Team.teamA.name
    
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
    }
    
    func playersDescription(for gather: Gather) -> String {
        viewModel.teamAPlayersDescription(for: gather)
    }
}

struct TeamBRowDescription: HistoryRowDescriptable {
    private let viewModel: HistoryViewModel
    let title = Team.teamB.name
    
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
    }
    
    func playersDescription(for gather: Gather) -> String {
        viewModel.teamBPlayersDescription(for: gather)
    }
}
