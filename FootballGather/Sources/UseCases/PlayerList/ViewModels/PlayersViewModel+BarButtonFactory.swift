//
//  PlayersViewModel+BarButtonFactory.swift
//  PlayersViewModel+BarButtonFactory
//
//  Created by Radu Dan on 04.09.2021.
//

import FoundationTools
import Localizable

extension PlayersViewModel {
    enum BarButtonFactory {
        static func barButton(
            _ type: NavigationBarButtonType,
            isEditing: Bool
        ) -> ButtonModel {
            switch type {
            case .leading:
                return makeLeadingBarButton(isEditing: isEditing)
            case .trailing:
                return trailingBarButton
            }
        }
        
        private static func makeLeadingBarButton(isEditing: Bool) -> PlayersViewModel.ButtonModel {
            if isEditing {
                return leadingBarButtonWhenEditing
            }
            
            return leadingBarButton
        }
        
        private static let leadingBarButtonWhenEditing = PlayersViewModel.ButtonModel(
            title: LocalizedString.done,
            accessibility: PlayersViewModel.AccessibilityModel(
                id: .doneButton,
                hint: LocalizedString.doneHint,
                label: LocalizedString.done
            )
        )
        
        private static let leadingBarButton = PlayersViewModel.ButtonModel(
            title: LocalizedString.edit,
            accessibility: PlayersViewModel.AccessibilityModel(
                id: .editButton,
                hint: LocalizedString.editHint,
                label: LocalizedString.edit
            )
        )
        
        private static let trailingBarButton = PlayersViewModel.ButtonModel(
            title: "",
            accessibility: PlayersViewModel.AccessibilityModel(
                id: .addButton,
                hint: LocalizedString.addPlayersHint,
                label: LocalizedString.addPlayerLabel
            )
        )
    }
}
