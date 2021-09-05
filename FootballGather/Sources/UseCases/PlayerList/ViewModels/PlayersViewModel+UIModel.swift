//
//  PlayersViewModel+UIModel.swift
//  PlayersViewModel+UIModel
//
//  Created by Radu Dan on 04.09.2021.
//

import FoundationTools
import Localizable
import SwiftUI

// MARK: - UI Models

extension PlayersViewModel {
    struct ButtonModel {
        let title: String
        let accessibility: AccessibilityModel
    }

    struct AccessibilityModel {
        let id: AccessibilityID
        let hint: String
        let label: String
    }
}

extension PlayersViewModel.ButtonModel: Equatable {}

extension PlayersViewModel.AccessibilityModel: Equatable {}

extension PlayersViewModel.ButtonModel {
    var accessibilityID: AccessibilityID {
        accessibility.id
    }
    
    var accessibilityHint: String {
        accessibility.hint
    }
    
    var accessibilityLabel: String {
        accessibility.label
    }
}

// MARK: - ViewModel Texts

extension PlayersViewModel {
    var formattedNavigationTitle: String {
        if !isEditing && numberOfSelectedPlayers > 0 {
            return String(format: LocalizedString.selectedCount, numberOfSelectedPlayers)
        }
        
        return LocalizedString.players
    }
    
    private var numberOfSelectedPlayers: Int {
        selectedRows.count
    }
    
    var leadingBarButton: ButtonModel {
        BarButtonFactory.barButton(.leading, isEditing: isEditing)
    }
    
    var trailingBarButton: ButtonModel {
        BarButtonFactory.barButton(.trailing, isEditing: isEditing)
    }
    
    var mainViewAccessibilityID: Localizable.AccessibilityID {
        hasPlayers ? .playerList : .emptyView
    }
    
    var editModeBinding: Binding<EditMode> {
        isEditing ? .constant(.active) : .constant(.inactive)
    }
}
