//
//  View+Accessibility.swift
//  
//
//  Created by Radu Dan on 10.02.2022.
//

import SwiftUI

struct AccessibilityViewModifier: ViewModifier {
    let id: String
    func body(content: Content) -> some View {
        content
            .accessibilityIdentifier(id)
    }
}

public extension View {
    func accessibilityID2<ID: RawRepresentable>(
        _ id: ID
    ) -> some View where ID.RawValue == String {
        modifier(AccessibilityViewModifier(id: id.rawValue))
    }
}
