//
//  PlayerDetailsViewModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 21.09.2021.
//

import SwiftUI
import CoreModels
import FoundationTools
import Localizable

// MARK: - PlayerDetailsViewModel

final class PlayerDetailsViewModel: ObservableObject {
    
    @Published var selectedPlayer: Player
    
    private let storage: AppStorage
    private let state: State
    private lazy var playerDetails = PlayerDetailsUIModelFactory.makeDetailsModel(
        for: selectedPlayer, state: state
    )
    
    init(
        storage: AppStorage,
        state: State,
        player: Player = .init(name: "")
    ) {
        self.storage = storage
        self.state = state
        selectedPlayer = player
    }
    
    var hasEnteredDetails: Bool {
        selectedPlayer.name.isEmpty == false ||
        selectedPlayer.skill != nil ||
        selectedPlayer.position != nil
    }
    
    var playerIsValid: Bool {
        NameValidator(name: selectedPlayer.name).isValid
    }
    
    var isAddingPlayers: Bool {
        state == .addingPlayers
    }
    
    var formattedNavigationBarTitle: String {
        playerDetails.navigationTitle
    }
    
    var showLeadingBarItem: Bool {
        playerDetails.showLeadingBarItem
    }
    
    var viewAccessibilityID: AccessibilityID {
        playerDetails.viewAccessibilityID
    }
    
    func savePlayer() {
        storage.updatePlayer(selectedPlayer)
    }
    
}

// MARK: - State

extension PlayerDetailsViewModel {
    enum State {
        case viewingDetails
        case addingPlayers
    }
}
