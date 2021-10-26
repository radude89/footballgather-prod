//
//  ConfirmPlayersView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 25.10.2021.
//

import SwiftUI
import Localizable
import CoreModels

struct ConfirmPlayersView: View {
    
    let viewModel: ConfirmPlayersViewModel
    
    var body: some View {
        VStack {
            teamsListView
            startGatherButton
        }
        .navigationTitle(LocalizedString.confirmPlayersTitle)
    }
    
    private var teamsListView: some View {
        List {
            teamsListViewContent
        }
        .accessibilityID(.confirmPlayersView)
    }
    
    private var teamsListViewContent: some View {
        ForEach(viewModel.teams, id:\.self) { team in
            makeSection(for: team)
        }
    }
    
    private func makeSection(for team: Team) -> some View {
        Section(viewModel.sectionName(for: team)) {
            makeRows(for: team)
        }
        .accessibilityID(
            viewModel.accessibilityID(for: team)
        )
    }
    
    private func makeRows(for team: Team) -> some View {
        ForEach(viewModel.players(in: team)) { player in
            Text(viewModel.rowDescription(for: player))
        }
    }
    
    private var startGatherButton: some View {
        Button(LocalizedString.startGather) {
            
        }
        .accessibilityID(.startGatherButton)
        .padding()
        .disabled(true)
    }
    
}

// MARK: - Previews

struct ConfirmPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmPlayersView(
            viewModel: .init(players: .demoPlayers)
        )
    }
}
