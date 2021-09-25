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
    }
    
    private func saveAndDismiss() {
        viewModel.savePlayer()
        dismiss()
    }
    
}

extension View {
    func confirmationAlert(
        title: String,
        message: String,
        confirmActionTitle: String,
        isPresented: Binding<Bool>
    ) -> some View {
        modifier(
            AlertConfirmViewModifier(
                title: title,
                message: message,
                confirmActionTitle: confirmActionTitle,
                isPresented: isPresented
            )
        )
    }
}

struct AlertConfirmViewModifier: ViewModifier {
    
    @Environment(\.dismiss) var dismiss
    @Binding var isPresented: Bool
    
    private let title: String
    private let message: String
    private let cancelTitle: String
    private let confirmActionTitle: String
    
    init(title: String,
         message: String,
         cancelTitle: String = LocalizedString.cancel,
         confirmActionTitle: String,
         isPresented: Binding<Bool>) {
        self.title = title
        self.message = message
        self.cancelTitle = cancelTitle
        self.confirmActionTitle = confirmActionTitle
        _isPresented = isPresented
    }
    
    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: $isPresented) {
                Button(cancelTitle, role: .cancel) {}
                Button(confirmActionTitle, role: .destructive) {
                    dismiss()
                }
            } message: {
                Text(message)
            }
    }
    
}

// MARK: - Preview

struct AddPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlayerView(viewModel: .init(storage: .init()))
    }
}
