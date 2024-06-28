//
//  GatherPlayersView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 29.11.2021.
//

import SwiftUI
import GatherAssets
import CoreModels
import UITools

struct GatherPlayersView: View {
    
    private let viewModel: GatherPlayersViewModel
    
    init(viewModel: GatherPlayersViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List {
            section(for: .teamA)
            section(for: .teamB)
        }
        .listStyle(.grouped)
        .accessibilityID(AccessibilityID.gatherPlayersList)
    }
    
    private func section(for team: Team) -> some View {
        Section(
            header: Text(viewModel.sectionName(for: team))
        ) {
            ForEach(viewModel.players(in: team)) { player in
                Text(player.name)
            }
        }
    }
    
}
