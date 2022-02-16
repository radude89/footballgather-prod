//
//  PlayerDetailsViewModel+UIModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 13.10.2021.
//

import Localizable
import CoreModels

// MARK: - PlayerDetailsUIModel

protocol PlayerDetailsUIModel {
    var navigationTitle: String { get }
    var showLeadingBarItem: Bool { get }
    var viewAccessibilityID: AccessibilityID { get }
}

// MARK: - PlayerDetails Model

private extension PlayerDetailsViewModel {
    struct DetailsModel: PlayerDetailsUIModel {
        private let player: Player
        
        let showLeadingBarItem = false
        let viewAccessibilityID: AccessibilityID = .detailsView
        
        var navigationTitle: String {
            player.name
        }
        
        init(player: Player) {
            self.player = player
        }
    }
}

// MARK: - AddPlayer Model

private extension PlayerDetailsViewModel {
    struct AddModel: PlayerDetailsUIModel {
        let showLeadingBarItem = true
        let viewAccessibilityID: AccessibilityID = .addView
        let navigationTitle = LocalizedString.addPlayer
    }
}

// MARK: - Factory

enum PlayerDetailsUIModelFactory {
    static func makeDetailsModel(
        for player: Player,
        state: PlayerDetailsViewModel.State
    ) -> PlayerDetailsUIModel {
        switch state {
        case .viewingDetails:
            return PlayerDetailsViewModel.DetailsModel(player: player)
        case .addingPlayers:
            return PlayerDetailsViewModel.AddModel()
        }
    }
}
