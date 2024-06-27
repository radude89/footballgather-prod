//
//  PlayerDetailsView.swift
//  PlayerDetailsView
//
//  Created by Radu Dan on 07.09.2021.
//

import SwiftUI
import UITools
import FoundationTools
import PlayerDetailsAssets

public struct PlayerDetailsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var showConfirmationAlert = false
    @Bindable private var viewModel: PlayerDetailsViewModel
    
    public init(viewModel: PlayerDetailsViewModel) {
        self.viewModel = viewModel
    }
        
    public var body: some View {
        detailsView
            .accessibilityID(viewModel.viewAccessibilityID)
    }
    
    @ViewBuilder
    private var detailsView: some View {
        if viewModel.isAddingPlayer {
            NavigationStack { formView }
        } else {
            formView
        }
    }
    
    private var formView: some View {
        PlayerDetailsFormView(
            viewModel: .init(
                selectedPlayer: $viewModel.selectedPlayer,
                isAddingPlayer: viewModel.isAddingPlayer
            )
        )
            .interactiveDismissDisabled(true)
            .navigationBarTitle(viewModel.formattedNavigationBarTitle)
            .navigationBarItems(
                leading: viewModel.showLeadingBarItem ? cancelButton : nil,
                trailing: saveButton
            )
            .confirmationAlert(
                isPresented: $showConfirmationAlert,
                title: LocalizedString.discardConfirmation,
                message: LocalizedString.discardChangesLost,
                cancelTitle: LocalizedString.cancel,
                confirmActionTitle: LocalizedString.discard,
                confirmAction: { dismiss() }
            )
    }
    
    private var cancelButton: some View {
        Button(
            LocalizedString.cancel,
            role: .cancel,
            action: handleDismiss
        )
            .accessibilityID(AccessibilityID.cancelButton)
    }
    
    private func handleDismiss() {
        if viewModel.hasEnteredDetails {
            showConfirmationAlert = true
        } else {
            dismiss()
        }
    }
    
    private var saveButton: some View {
        Button(LocalizedString.save, action: saveAndDismiss)
            .disabled(!viewModel.playerIsValid)
            .accessibilityID(AccessibilityID.saveButton)
    }
    
    private func saveAndDismiss() {
        viewModel.savePlayer()
        viewModel.updateBindingToShowListView()
        dismiss()
    }
    
}

// MARK: - Preview

struct PlayerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailsView(
            viewModel: .init(
                storage: FoundationTools.AppStorage(),
                state: .viewingDetails,
                showListView: .constant(false)
            )
        )
    }
}
