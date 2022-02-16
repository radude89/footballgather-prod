//
//  PlayerDetailsView.swift
//  PlayerDetailsView
//
//  Created by Radu Dan on 07.09.2021.
//

import SwiftUI
import UITools
import Localizable

public struct PlayerDetailsView: View {
    
    @ObservedObject var viewModel: PlayerDetailsViewModel
    
    @Environment(\.dismiss) private var dismiss
    @State private var showConfirmationAlert = false
    
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
                isPresented: $showConfirmationAlert,
                title: LocalizedString.discardConfirmation,
                message: LocalizedString.discardChangesLost,
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
        viewModel.updateBindingToShowListView()
        dismiss()
    }
    
}

// MARK: - Preview

struct PlayerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailsView(
            viewModel: .init(
                storage: .init(),
                state: .viewingDetails,
                showListView: .constant(false)
            )
        )
    }
}
