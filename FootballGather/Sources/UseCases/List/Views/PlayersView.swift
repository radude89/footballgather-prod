//
//  PlayerListView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 18.05.2021.
//

import SwiftUI
import Localizable
import CoreModels

// MARK: - PlayersView

struct PlayersView: View {
    
    @ObservedObject var viewModel: PlayersViewModel
    
    @State private var showAddView = false
    @State private var showListView = false
    
    var body: some View {
        NavigationView {
            mainContent
                .navigationTitle(viewModel.formattedNavigationTitle)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading: showListView ? leadingBarButton : nil,
                    trailing: trailingBarButton
                )
                .environment(\.editMode, viewModel.editModeBinding)
                .sheet(isPresented: $showAddView) {
                    PlayerDetailsView(
                        viewModel: .init(
                            storage: viewModel.storage,
                            state: .addingPlayers,
                            showListView: $showListView
                        )
                    )
                }
                .onAppear {
                    showListView = viewModel.hasPlayers
                }
        }
        .accessibilityID(viewModel.mainViewAccessibilityID)
    }
    
    @ViewBuilder
    private var mainContent: some View {
        if !showListView {
            PlayersEmptyView()
        } else {
            PlayersListView(
                viewModel: .init(
                    storage: viewModel.storage,
                    selectedRows: $viewModel.selectedRows,
                    showListView: $showListView
                )
            )
                .onAppear(perform: viewModel.reloadView)
        }
    }
    
    private var leadingBarButton: some View {
        Button(action: viewModel.toggleSelection) {
            Text(viewModel.leadingBarButton.title)
        }
        .accessibilityID(viewModel.leadingBarButton.accessibilityID)
        .accessibilityHint(
            Text(viewModel.leadingBarButton.accessibilityHint)
        )
        .accessibilityLabel(
            Text(viewModel.leadingBarButton.accessibilityLabel)
        )
    }
    
    private var trailingBarButton: some View {
        Button(action: { showAddView = true }) {
            Image(systemName: "plus")
                .accessibility(removeTraits: .isImage)
        }
        .accessibilityID(viewModel.trailingBarButton.accessibilityID)
        .accessibilityHint(
            Text(viewModel.trailingBarButton.accessibilityHint)
        )
        .accessibilityLabel(
            Text(viewModel.trailingBarButton.accessibilityLabel)
        )
    }
    
}

// MARK: - Preview

struct PlayersView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersView(viewModel: .init(storage: AppStorage()))
    }
}
