//
//  ConfirmPlayersView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 04.11.2021.
//

import SwiftUI
import CoreModels
import TeamSelectionAssets
import UITools

#Preview {
    ConfirmPlayersView(
        players: .demoPlayers,
        gatherCoordinator: EmptyGatherCoordinator()
    )
}

public struct ConfirmPlayersView: View {
    private let gatherCoordinator: GatherCoordinatable
    @State private var viewModel: ConfirmPlayersViewModel

    public init(players: [Player], gatherCoordinator: GatherCoordinatable) {
        self.gatherCoordinator = gatherCoordinator
        _viewModel = State(initialValue: ConfirmPlayersViewModel(players: players))
    }

    public var body: some View {
        List {
            ForEach(viewModel.teams, id: \.self) { team in
                Section(team.name.uppercased()) {
                    let players = viewModel.playersTeams[team] ?? []
                    if players.isEmpty {
                        emptyView
                    } else {
                        makePlayerList(players: players, team: team)
                    }
                }
            }
        }
        .accessibilityIdentifier(AccessibilityID.confirmPlayersView.rawValue)
        .safeAreaInset(edge: .bottom) {
            GlassIconButton(
                icon: "arrow.right.circle.fill",
                tint: viewModel.startGatherIsEnabled ? .green : .gray,
                accessibilityID: AccessibilityID.startGatherButton.rawValue,
                accessibilityLabel: LocalizedString.startGatherHint,
                action: {
                    gatherCoordinator.startGather(playersTeams: viewModel.playersTeams)
                }
            )
            .disabled(!viewModel.startGatherIsEnabled)
        }
    }
    
    private var emptyView: some View {
        Text(LocalizedString.noPlayers)
            .foregroundStyle(.secondary)
            .font(.body)
    }
    
    private func makePlayerList(players: [Player], team: Team) -> some View {
        ForEach(players) { player in
            Menu {
                ForEach(
                    viewModel.teams.filter { $0 != team },
                    id: \.self
                ) { targetTeam in
                    Button("Move to \(targetTeam.name)") {
                        viewModel.move(player, to: targetTeam)
                    }
                }
            } label: {
                HStack {
                    Text(player.name)
                    Spacer()
                    Image(systemName: "chevron.up.chevron.down")
                        .imageScale(.small)
                        .foregroundStyle(.secondary)
                }
            }
            .buttonStyle(.plain)
        }
    }
}
