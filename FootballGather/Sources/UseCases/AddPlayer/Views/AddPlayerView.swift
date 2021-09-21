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
    
    @StateObject private var viewModel = AddPlayerViewModel()
        
    var body: some View {
        NavigationView {
            AddPlayerFormView(
                viewModel: .init(selectedPlayer: $viewModel.selectedPlayer)
            )
                .interactiveDismissDisabled(true)
                .navigationBarTitle(LocalizedString.addPlayer)
                .navigationBarItems(
                    leading: cancelButton,
                    trailing: saveButton
                )
        }
        .accessibilityID(.addView)
    }
    
    private var cancelButton: some View {
        Button(
            LocalizedString.cancel,
            role: .cancel,
            action: dismissView
        )
    }
    
    private var saveButton: some View {
        Button(LocalizedString.save, action: savePlayer)
            .disabled(viewModel.saveIsDisabled)
    }
    
    private func dismissView() {
        // TODO: Toggle alert
        
        dismiss()
    }
    
    private func savePlayer() {
        // TODO: Save player details
        
        dismiss()
    }
    
}

// MARK: - Preview

struct AddPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlayerView()
    }
}
