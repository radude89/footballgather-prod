//
//  PlayerListView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 24.05.2021.
//

import SwiftUI
import CoreModels
import Localizable

// MARK: - PlayerListView

struct PlayersListView: View {
    
    let viewModel: PlayersListViewModel
    
    @Environment(\.editMode) var editMode
    
    var body: some View {
        List(
            viewModel.players,
            selection: viewModel.$selectedRows
        ) { player in
            NavigationLink(
                destination: PlayerDetailsView(
                    viewModel: .init(
                        storage: viewModel.storage,
                        state: .viewingDetails,
                        player: player
                    )
                )
            ) {
                makeListRow(for: player)
            }
        }
        .listStyle(.plain)
    }
    
    private func makeListRow(for player: Player) -> some View {
        Text(PlayersListViewModel.formattedRowTitle(for: player))
            .accessibilityID(
                viewModel.accessibilityID(
                    for: player, isEditing: isEditing
                )
            )
            .accessibilityLabel(
                viewModel.accessibilityLabel(
                    for: player, isEditing: isEditing
                )
            )
            .accessibilityAddTraits(
                viewModel.hasSelected(player) ? .isSelected : []
            )
    }
    
    private var isEditing: Bool {
        editMode?.wrappedValue == .active
    }
    
}

// MARK: - Preview

struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersListView(
            viewModel: .init(
                storage: .init(),
                players: .demoPlayers,
                selectedRows: .constant(.init())
            )
        )
            .previewLayout(.sizeThatFits)
    }
}
