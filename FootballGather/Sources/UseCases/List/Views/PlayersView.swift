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

struct PlayersView<AddView: View, DetailsView: View, ConfirmView: View>: View {
    
    @ObservedObject var viewModel: PlayersViewModel
    
    let viewProvider: PlayersViewProvider<AddView, DetailsView, ConfirmView>
    
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
                    viewProvider.addView($showListView)
                }
                .onAppear {
                    showListView = viewModel.hasPlayers
                }
        }
        .accessibilityID(viewModel.mainViewAccessibilityID)
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
                    selectedRows: $viewModel.selectedRows,
                    showListView: $showListView
                ),
                detailsViewProvider: viewProvider.detailsView,
                confirmPlayersViewProvider: viewProvider.confirmPlayersView
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
        let viewProvider = PlayersViewProvider(
            addView: { _ in AnyView(Text("Add View")) },
            detailsView: { _,_ in AnyView(Text("Details View")) },
            confirmPlayersView: { _,_ in AnyView(Text("Confirm view")) }
        )
        
        return PlayersView(
            viewModel: .init(storage: AppStorage()),
            viewProvider: viewProvider
        )
    }
}
