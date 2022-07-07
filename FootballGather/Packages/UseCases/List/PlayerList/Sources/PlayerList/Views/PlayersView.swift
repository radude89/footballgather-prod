//
//  PlayerListView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 18.05.2021.
//

import SwiftUI
import CoreModels
import FoundationTools
import UITools
import PlayerListAssets

// MARK: - PlayersView

public struct PlayersView<AddView: View, DetailsView: View, ConfirmView: View>: View {
    
    @ObservedObject var viewModel: PlayersViewModel
    
    private let viewProvider: PlayersViewProvider<AddView, DetailsView, ConfirmView>
    
    @State private var showAddView = false
    @State private var showListView = false
    
    public init(
        viewModel: PlayersViewModel,
        viewProvider: PlayersViewProvider<AddView, DetailsView, ConfirmView>
    ) {
        self.viewModel = viewModel
        self.viewProvider = viewProvider
    }
    
    public var body: some View {
        NavigationView {
            mainContent
                .navigationTitle(LocalizedString.players)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        trailingBarButton
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
                .sheet(isPresented: $showAddView) {
                    viewProvider.addView($showListView)
                }
                .onAppear {
                    showListView = viewModel.hasPlayers
                }
        }
        .accessibilityID(viewModel.hasPlayers ? AccessibilityID.playerList : AccessibilityID.emptyView)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    @ViewBuilder
    private var mainContent: some View {
        if !showListView {
            PlayersEmptyView()
        } else {
            PlayersListView(
                viewModel: .init(
                    storage: viewModel.storage,
                    showListView: $showListView
                ),
                viewProvider: PlayersListViewProvider(
                    detailsView: viewProvider.detailsView,
                    confirmPlayersView: viewProvider.confirmPlayersView
                )
            )
                .onAppear(perform: viewModel.reloadView)
        }
    }
    
    private var trailingBarButton: some View {
        Button(action: { showAddView = true }) {
            Image(systemName: "plus")
                .accessibility(removeTraits: .isImage)
        }
        .accessibilityID(AccessibilityID.addButton)
        .accessibilityHint(
            Text(LocalizedString.addPlayersHint)
        )
        .accessibilityLabel(
            Text(LocalizedString.addPlayerLabel)
        )
    }
    
}
