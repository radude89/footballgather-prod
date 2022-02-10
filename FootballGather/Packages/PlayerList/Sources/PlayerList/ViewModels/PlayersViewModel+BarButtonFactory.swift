//
//  PlayersViewModel+BarButtonFactory.swift
//  PlayersViewModel+BarButtonFactory
//
//  Created by Radu Dan on 04.09.2021.
//

import UITools
import Localizable

extension PlayersViewModel {
    enum BarButtonFactory {
        static func barButton(
            _ type: NavigationBarButtonType,
            isSelectingPlayers: Bool
        ) -> ButtonModel {
            switch type {
            case .leading:
                return makeLeadingBarButton(isSelectingPlayers: isSelectingPlayers)
            case .trailing:
                return trailingBarButton
            }
        }
        
        private static func makeLeadingBarButton(
            isSelectingPlayers: Bool
        ) -> PlayersViewModel.ButtonModel {
            if isSelectingPlayers {
                return leadingBarButtonWhenSelectingPlayers
            }
            
            return leadingBarButton
        }
        
        private static let leadingBarButtonWhenSelectingPlayers = PlayersViewModel.ButtonModel(
            title: LocalizedString.cancel,
            accessibility: PlayersViewModel.AccessibilityModel(
                id: .cancelButton,
                hint: LocalizedString.cancelHint,
                label: LocalizedString.cancel
            )
        )
        
        private static let leadingBarButton = PlayersViewModel.ButtonModel(
            title: LocalizedString.select,
            accessibility: PlayersViewModel.AccessibilityModel(
                id: .selectButton,
                hint: LocalizedString.selectHint,
                label: LocalizedString.select
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
