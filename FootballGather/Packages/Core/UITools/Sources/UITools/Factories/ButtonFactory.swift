//
//  ButtonFactory.swift
//  
//
//  Created by Radu Dan on 12.11.2021.
//

import UIKit

@MainActor
public enum ButtonFactory {
    public static func makeSystemButton(
        title: String,
        isEnabled: Bool = true,
        accessibilityID: String,
        accessibilityLabel: String? = nil,
        accessibilityHint: String? = nil,
        selector: Selector
    ) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        button.isEnabled = isEnabled
        button.accessibilityIdentifier = accessibilityID
        button.accessibilityLabel = accessibilityLabel
        button.accessibilityHint = accessibilityHint
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
}
