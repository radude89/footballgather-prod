//
//  Accessibility+SwiftUI.swift
//  
//
//  Created by Radu Dan on 18.05.2021.
//

import SwiftUI

@available(iOS 14.0, *)
extension View {
    public func accessibilityID(
        _ identifier: AccessibilityID
    ) -> ModifiedContent<Self, AccessibilityAttachmentModifier> {
        accessibilityIdentifier(identifier.rawValue)
    }
}
