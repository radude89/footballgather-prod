//
//  PlayerDetailsView.swift
//  PlayerDetailsView
//
//  Created by Radu Dan on 07.09.2021.
//

import SwiftUI
import UITools
import Localizable

struct PlayerDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: PlayerDetailsViewModel
    
    @State private var showConfirmationAlert = false
        
    var body: some View {
        detailsView
            .accessibilityID(viewModel.viewAccessibilityID)
    }
    
    @ViewBuilder
    private var detailsView: some View {
        if viewModel.isAddingPlayer {
            NavigationView { formView }
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
                title: LocalizedString.discardConfirmation,
                message: LocalizedString.discardChangesLost,
                confirmActionTitle: LocalizedString.discard,
                isPresented: $showConfirmationAlert
            )
    }
    
    private var cancelButton: some View {
        Button(
            LocalizedString.cancel,
            role: .cancel,
            action: handleDismiss
        )
            .accessibilityID(.cancelButton)
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
            .accessibilityID(.saveButton)
    }
    
    private func saveAndDismiss() {
        viewModel.savePlayer()
        dismiss()
    }
    
}

// MARK: - Preview

struct PlayerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailsView(
            viewModel: .init(storage: .init(), state: .viewingDetails)
        )
    }
}