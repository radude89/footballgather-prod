//
//  GatherEndView.swift
//  UITests
//
//  Created by Radu Dan on 30.11.2021.
//

import SwiftUI
import Localizable
import UITools

struct GatherEndView: View {
    
    var completion: () -> Void
    
    @State private var showConfirmationAlert = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        endGatherButton
            .confirmationAlert(
                isPresented: $showConfirmationAlert,
                title: LocalizedString.endGatherConfirmation,
                message: LocalizedString.endGatherMessage,
                cancelTitle: LocalizedString.no,
                confirmActionTitle: LocalizedString.yes,
                confirmAction: endGather
            )
    }
    
    private var endGatherButton: some View {
        Button(
            LocalizedString.endGather,
            role: .cancel,
            action: presentEndGatherConfirmationAlert
        )
            .accessibilityID(.endGatherButton)
    }
    
    private func presentEndGatherConfirmationAlert() {
        showConfirmationAlert = true
    }
    
    private func endGather() {
        completion()
        dismiss()
    }
    
}

// MARK: - Preview

struct GatherEndView_Previews: PreviewProvider {
    static var previews: some View {
        GatherEndView {}
    }
}
