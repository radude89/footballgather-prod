//
//  AddPlayerView.swift
//  AddPlayerView
//
//  Created by Radu Dan on 07.09.2021.
//

import SwiftUI
import Localizable

struct AddPlayerView: View {
    
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
                .alert(isPresented: $showConfirmationAlert) {
                    confirmationAlert
                }
        }
        .accessibilityID(.addView)
    }
    
    private var cancelButton: some View {
        Button(
            LocalizedString.cancel,
            role: .cancel,
            action: handleDismiss
        )
    }
    
    private func handleDismiss() {
        if viewModel.hasEnteredDetails {
            showConfirmationAlert = true
        } else {
            dismiss()
        }
    }
    
    private var confirmationAlert: Alert {
        Alert(
            title: Text(LocalizedString.discardConfirmation),
            message: Text(LocalizedString.discardChangesLost),
            primaryButton: .cancel(Text(LocalizedString.cancel)),
            secondaryButton:
                    .destructive(
                        Text(LocalizedString.discard),
                        action: { dismiss() }
                    )
        )
    }
    
    private var saveButton: some View {
        Button(LocalizedString.save, action: savePlayer)
            .disabled(viewModel.saveIsDisabled)
    }
    
    private func savePlayer() {
        viewModel.savePlayer()
        dismiss()
    }
    
}

// MARK: - Preview

struct AddPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlayerView(viewModel: .init(storage: .init()))
    }
}
