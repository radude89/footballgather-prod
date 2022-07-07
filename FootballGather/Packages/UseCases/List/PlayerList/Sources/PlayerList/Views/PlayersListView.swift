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
                        action: { deletePlayer(player) }
                    ) {
                        Label(LocalizedString.delete, systemImage: "trash")
                    }
                }
            }
            .onDelete(perform: viewModel.delete)
        }
        .listStyle(.plain)
    }
    
    private func makeListRow(for player: Player) -> some View {
        Text(PlayersListViewModel.formattedRowTitle(for: player))
            .accessibilityID(AccessibilityID.unselectedRow)
            .accessibilityLabel(Text(String(player.name)))
    }
    
    private func deletePlayer(_ player: Player) {
        viewModel.delete(player)
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
        .accessibilityHint(LocalizedString.confirmPlayersButtonHint)
        .padding(.bottom)
    }
    
}
