//
//  PlayerListView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 24.05.2021.
//

import SwiftUI
import CoreModels
import PlayerListAssets
import UITools
import FoundationTools

// MARK: - PlayerListView

struct PlayersListView<DetailsView: View, ConfirmView: View>: View {
    
    @ObservedObject var viewModel: PlayersListViewModel
    @Binding var isEditing: Bool
    
    let viewProvider: PlayersListViewProvider<DetailsView, ConfirmView>
    
    @State private var isShowingConfirmPlayersView = false
    @State private var gatherEnded = false
    
    var body: some View {
        VStack {
            playerList
            confirmPlayersNavigationLink
        }
        .alert(
            LocalizedString.gatherCompleteTitle,
            isPresented: $gatherEnded,
            actions: {
                Button(LocalizedString.ok, role: .cancel, action: {
                    isShowingConfirmPlayersView = false
                })
            }, message: {
                Text(LocalizedString.gatherCompleteMessage)
            }
        )
    }
    
    private var playerList: some View {
        List {
            ForEach(viewModel.players) { player in
                NavigationLink(
                    destination: viewProvider.detailsView(
                        viewModel.$showListView,
                        player
                    )
                ) {
                    makeListRow(for: player)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(
                        role: .destructive,
                        action: {
                            deletePlayer(player)
                            disableEditModeIfNeeded()
                        }
                    ) {
                        Label(LocalizedString.delete, systemImage: "trash")
                    }
                }
            }
            .onDelete { indexSet in
                viewModel.delete(at: indexSet)
                disableEditModeIfNeeded()
            }
        }
        .listStyle(.plain)
    }
    
    private func makeListRow(for player: Player) -> some View {
        Text(PlayersListViewModel.formattedRowTitle(for: player))
            .accessibilityID(AccessibilityID.unselectedRow)
            .accessibilityLabel(Text(String(player.name)))
            .accessibilityHint(LocalizedString.swipeDeleteHint)
    }
    
    private func deletePlayer(_ player: Player) {
        viewModel.delete(player)
    }
    
    private func disableEditModeIfNeeded() {
        if viewModel.players.isEmpty {
            isEditing = false
        }
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
        viewProvider.confirmPlayersView(
            viewModel.players,
            $gatherEnded
        )
        .navigationTitle(LocalizedString.confirmPlayersTitle)
    }
    
    private var confirmPlayersButton: some View {
        Button(LocalizedString.confirmPlayersTitle) {
            isShowingConfirmPlayersView = true
        }
        .accessibilityID(AccessibilityID.confirmButton)
        .padding(.bottom)
    }
    
}
