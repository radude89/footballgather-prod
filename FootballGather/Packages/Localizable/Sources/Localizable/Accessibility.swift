//
//  File.swift
//  
//
//  Created by Radu Dan on 25.03.2021.
//

import Foundation

public enum AccessibilityID: String {    
    case hello = "hello-text-id"
}

extension AccessibilityID {
    public enum View: String {
        case playerList = "player-list-view"
    }
}

extension AccessibilityID: CaseIterable {}

extension AccessibilityID.View: CaseIterable {}

