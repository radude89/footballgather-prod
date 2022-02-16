//
//  AccessibilityID.swift
//  
//
//  Created by Radu Dan on 10.02.2022.
//

import SwiftUI

public enum AccessibilityID: String {
    case selectedRow = "selected-row"
    case unselectedRow = "unselected-row"
    case addButton = "add-button"
    case selectButton = "select-button"
    case cancelButton = "cancel-button"
    case playerList = "player-list"
    case emptyView = "empty-view"
}

extension AccessibilityID: CaseIterable {}
