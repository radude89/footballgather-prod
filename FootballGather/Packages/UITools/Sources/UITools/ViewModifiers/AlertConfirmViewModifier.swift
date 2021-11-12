//
//  AlertConfirmViewModifier.swift
//  
//
//  Created by Radu Dan on 25.09.2021.
//

import SwiftUI
import Localizable

public struct AlertConfirmViewModifier: ViewModifier {
    
    @Binding public var isPresented: Bool
    
    @Environment(\.dismiss) private var dismiss
    
    private let title: String
    private let message: String
    private let cancelTitle: String
    private let confirmActionTitle: String
    
    public init(
        title: String,
        message: String,
        cancelTitle: String = LocalizedString.cancel,
        confirmActionTitle: String,
        isPresented: Binding<Bool>
    ) {
        self.title = title
        self.message = message
        self.cancelTitle = cancelTitle
        self.confirmActionTitle = confirmActionTitle
        _isPresented = isPresented
    }
    
    public func body(content: Content) -> some View {
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

// MARK: - View extension

public extension View {
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
