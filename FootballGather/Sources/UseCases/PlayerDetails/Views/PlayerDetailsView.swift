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
    @ObservedObject var viewModel: AddPlayerViewModel
    
    @State private var showConfirmationAlert = false
        
    var body: some View {
        NavigationView {
            AddPlayerFormView(
                viewModel: .init(
                    selectedPlayer: $viewModel.selectedPlayer
                )
            )
                .interactiveDismissDisabled(true)
                .navigationBarTitle(LocalizedString.addPlayer)
                .navigationBarItems(
                    leading: cancelButton,
                    trailing: saveButton
                )
                .confirmationAlert(
                    title: LocalizedString.discardConfirmation,
                    message: LocalizedString.discardChangesLost,
                    confirmActionTitle: LocalizedString.discard,
                    isPresented: $showConfirmationAlert
                )
        }
        .accessibilityID(.addView)
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
        PlayerDetailsView(viewModel: .init(storage: .init()))
    }
}
