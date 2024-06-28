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
    
    private let viewProvider: PlayersViewProvider<AddView, DetailsView, ConfirmView>
    private let viewModel: PlayersViewModel
    
    @State private var showAddView = false
    @State private var showListView = false
    @State private var isEditing: Bool = false
    
    public init(
        viewModel: PlayersViewModel,
        viewProvider: PlayersViewProvider<AddView, DetailsView, ConfirmView>
    ) {
        self.viewModel = viewModel
        self.viewProvider = viewProvider
    }
    
    public var body: some View {
        NavigationStack {
            mainContent
                .navigationTitle(LocalizedString.players)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        trailingBarButton
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            withAnimation {
                                isEditing.toggle()
                            }
                        } label: {
                            Text(isEditing ? LocalizedString.done : LocalizedString.edit)
                        }
                        .disabled(!viewModel.hasPlayers)
                    }
                }
                .environment(\.editMode, .constant(isEditing ? .active : .inactive))
                .sheet(isPresented: $showAddView) {
                    viewProvider.addView($showListView)
                }
                .onAppear {
                    showListView = viewModel.hasPlayers
                }
        }
        .accessibilityID(viewModel.hasPlayers ? AccessibilityID.playerList : AccessibilityID.emptyView)
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
                ),
                isEditing: $isEditing
            )
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
