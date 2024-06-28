//
//  GatherEndView.swift
//  UITests
//
//  Created by Radu Dan on 30.11.2021.
//

import SwiftUI
import GatherAssets
import UITools

struct GatherEndView: View {
    
    @State private var showConfirmationAlert = false
    @Environment(\.dismiss) private var dismiss
    
    private let completion: () -> Void
    
    init(completion: @escaping () -> Void) {
        self.completion = completion
    }
    
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
            .accessibilityID(AccessibilityID.endGatherButton)
    }
    
    private func presentEndGatherConfirmationAlert() {
        showConfirmationAlert = true
    }
    
    private func endGather() {
        completion()
        dismiss()
    }
    
}
