//
//  File.swift
//  
//
//  Created by Radu Dan on 25.03.2021.
//

import Foundation

public enum AccessibilityID: String {
    case playerList = "player-list"
    case emptyView = "empty-view"
    case addButton = "add-button"
}

extension AccessibilityID: CaseIterable {}
