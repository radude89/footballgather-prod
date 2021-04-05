//
//  File.swift
//  
//
//  Created by Radu Dan on 25.03.2021.
//

import Foundation
import SwiftUI

public enum AccessibilityIDs: String {
    public typealias RawValue = String
    
    case hello = "hello-text-id"
}

@available(iOS 14.0, *)
extension View {
    public func accessibilityID(_ identifier: AccessibilityIDs) -> ModifiedContent<Self, AccessibilityAttachmentModifier> {
        accessibilityIdentifier(identifier.rawValue)
    }
}
