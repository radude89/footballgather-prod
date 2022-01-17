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
    
    @ObservedObject var viewModel: PlayersListViewModel
    
    @Environment(\.editMode) private var editMode
    @State private var isShowingConfirmPlayersView = false
    
    var body: some View {
        VStack {
            playerList
            confirmPlayersNavigationLink
        }
    }
    
    private var playerList: some View {
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
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(
                            role: .destructive,
                            action: { onDelete(player) }
                        ) {
                            Label(LocalizedString.delete, systemImage: "trash")
                        }
                    }
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
    
    private func onDelete(_ player: Player) {
        viewModel.delete(player)
    }
    
    private var isEditing: Bool {
        editMode?.wrappedValue == .active
    }
    
    private var confirmPlayersNavigationLink: some View {
        NavigationLink(
            destination: confirmView,
            isActive: $isShowingConfirmPlayersView
        ) {
            confirmPlayersButton
        }
    }
    
    private var confirmView: some View {
        ConfirmPlayersView(players: viewModel.selectedPlayers)
            .navigationTitle(LocalizedString.confirmPlayersTitle)
    }
    
    private var confirmPlayersButton: some View {
        Button(LocalizedString.confirmPlayersTitle) {
            isShowingConfirmPlayersView = true
        }
        .accessibilityID(.confirmButton)
        .accessibilityHint(LocalizedString.confirmPlayersButtonHint)
        .padding(.bottom)
        .disabled(!viewModel.shouldConfirmPlayers)
    }
    
}

// MARK: - Preview

struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersListView(
            viewModel: .init(
                storage: .init(),
                selectedRows: .constant(.init())
            )
        )
            .previewLayout(.sizeThatFits)
    }
}
