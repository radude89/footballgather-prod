//
//  AccessibilityID.swift
//  
//
//  Created by Radu Dan on 25.03.2021.
//

import Foundation

public enum AccessibilityID: String {
    case playerList = "player-list"
    case emptyView = "empty-view"
    case addButton = "add-button"
    case editButton = "edit-button"
    case doneButton = "done-button"
    case selectedRow = "selected-row"
    case unselectedRow = "unselected-row"
    case addView = "add-view"
}

extension AccessibilityID: CaseIterable {}
