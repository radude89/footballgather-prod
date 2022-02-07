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

struct PlayersView<AddView: View, DetailsView: View>: View {
    
    @ObservedObject var viewModel: PlayersViewModel
    
    var addViewProvider: (_ showListView: Binding<Bool>) -> AddView
    
    var detailsViewProvider: (
        _ showListView: Binding<Bool>,
        _ player: Player
    ) -> DetailsView
    
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
                    addViewProvider($showListView)
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
                detailsViewProvider: { showListView, player in
                    detailsViewProvider(showListView, player)
                }
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
        PlayersView(
            viewModel: .init(storage: AppStorage()),
            addViewProvider: { _ in AnyView(Text("Add View")) },
            detailsViewProvider: { _,_ in AnyView(Text("Details View")) }
        )
    }
}
