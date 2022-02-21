//
//  AlertConfirmViewModifier.swift
//  
//
//  Created by Radu Dan on 25.09.2021.
//

import SwiftUI

public struct AlertConfirmViewModifier: ViewModifier {
    
    @Binding public var isPresented: Bool
    
    private let title: String
    private let message: String
    private let cancelTitle: String
    private let confirmActionTitle: String
    private let confirmAction: () -> Void
    private let confirmRole: ButtonRole?
    
    public init(
        isPresented: Binding<Bool>,
        title: String,
        message: String,
        cancelTitle: String,
        confirmActionTitle: String,
        confirmRole: ButtonRole? = .destructive,
        confirmAction: @escaping () -> Void
    ) {
        _isPresented = isPresented
        self.title = title
        self.message = message
        self.cancelTitle = cancelTitle
        self.confirmActionTitle = confirmActionTitle
        self.confirmRole = confirmRole
        self.confirmAction = confirmAction
    }
    
    public func body(content: Content) -> some View {
        content
            .alert(title, isPresented: $isPresented) {
                Button(cancelTitle, role: .cancel) {}
                Button(confirmActionTitle, role: confirmRole, action: confirmAction)
            } message: {
                Text(message)
            }
    }
    
}

// MARK: - View extension

public extension View {
    func confirmationAlert(
        isPresented: Binding<Bool>,
        title: String,
        message: String,
        cancelTitle: String,
        confirmActionTitle: String,
        confirmRole: ButtonRole? = .destructive,
        confirmAction: @escaping () -> Void
    ) -> some View {
        modifier(
            AlertConfirmViewModifier(
                isPresented: isPresented,
                title: title,
                message: message,
                cancelTitle: cancelTitle,
                confirmActionTitle: confirmActionTitle,
                confirmRole: confirmRole,
                confirmAction: confirmAction
            )
        )
    }
}
