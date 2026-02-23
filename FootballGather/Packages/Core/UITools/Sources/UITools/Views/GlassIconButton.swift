//
//  GlassIconButton.swift
//  UITools
//
//  Created by Claude on 20.02.2026.
//

import SwiftUI

/// A reusable button component with Liquid Glass styling, icon, and optional text
public struct GlassIconButton: View {
    
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.colorScheme) private var colorScheme
    
    private let icon: String
    private let tint: Color
    private let spacing: CGFloat
    private let padding: CGFloat
    private let bottomPadding: CGFloat
    private let accessibilityID: String?
    private let accessibilityLabel: String?
    private let action: () -> Void
    
    /// Creates a glass button with an icon
    /// - Parameters:
    ///   - icon: SF Symbol name for the icon
    ///   - tint: Color to apply to the icon
    ///   - spacing: Spacing between icon and text (default: 8)
    ///   - padding: Inner padding around the content (default: 8)
    ///   - bottomPadding: Bottom padding for the button (default: 12)
    ///   - accessibilityID: Optional accessibility identifier
    ///   - accessibilityLabel: Optional accessibility label
    ///   - action: Action to perform when button is tapped
    public init(
        icon: String,
        tint: Color = .green,
        spacing: CGFloat = 8,
        padding: CGFloat = 8,
        bottomPadding: CGFloat = 12,
        accessibilityID: String? = nil,
        accessibilityLabel: String? = nil,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.tint = tint
        self.spacing = spacing
        self.padding = padding
        self.bottomPadding = bottomPadding
        self.accessibilityID = accessibilityID
        self.accessibilityLabel = accessibilityLabel
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: spacing) {
                Image(systemName: icon)
                    .imageScale(.large)
            }
            .foregroundStyle(tint)
            .opacity(isEnabled ? 1 : colorScheme == .dark ? 0.1 : 0.85)
            .padding(padding)
        }
        .buttonStyle(.glass)
        .apply { view in
            if let accessibilityID {
                view.accessibilityIdentifier(accessibilityID)
            } else {
                view
            }
        }
        .apply { view in
            if let accessibilityLabel {
                view.accessibilityLabel(accessibilityLabel)
            } else {
                view
            }
        }
        .padding(.bottom, bottomPadding)
    }
}

// Helper extension for conditional view modifiers
private extension View {
    @ViewBuilder
    func apply<V: View>(@ViewBuilder transform: (Self) -> V) -> some View {
        transform(self)
    }
}

#Preview {
    VStack(spacing: 20) {
        GlassIconButton(
            icon: "arrow.right.circle.fill",
            tint: .green,
            accessibilityLabel: "Confirm"
        ) {}
        
        GlassIconButton(
            icon: "checkmark.circle.fill",
            tint: .blue,
            accessibilityLabel: "Done"
        ) {}
        
        GlassIconButton(
            icon: "xmark.circle.fill",
            tint: .red,
            accessibilityLabel: "Cancel"
        ) {}
        
        GlassIconButton(
            icon: "xmark.circle.fill",
            tint: .red,
            accessibilityLabel: "Cancel"
        ) {}
            .disabled(true)
    }
    .padding()
}
