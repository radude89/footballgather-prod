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
    @Binding var showListView: Bool
    
    private let storage: FoundationTools.AppStorage
    private let state: State
    private lazy var playerDetails = PlayerDetailsUIModelFactory.makeDetailsModel(
        for: selectedPlayer, state: state
    )
    
    init(
        storage: FoundationTools.AppStorage,
        state: State,
        player: Player = .init(name: ""),
        showListView: Binding<Bool> = .constant(false)
    ) {
        self.storage = storage
        self.state = state
        selectedPlayer = player
        _showListView = showListView
    }
    
    var hasEnteredDetails: Bool {
        selectedPlayer.name.isEmpty == false ||
        selectedPlayer.skill != nil ||
        selectedPlayer.position != nil
    }
    
    var playerIsValid: Bool {
        let enteredNameIsValid = NameValidator(name: selectedPlayer.name).isValid
        
        if state == .viewingDetails {
            return !sameDetailsEntered && enteredNameIsValid
        }
        
        return enteredNameIsValid
    }
    
    private var sameDetailsEntered: Bool {
        PlayerDetailsDuplicateVerifier(storage: storage).sameDetailsEntered(for: selectedPlayer)
    }
    
    var isAddingPlayer: Bool {
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
    
    func updateBindingToShowListView() {
        showListView = true
    }
    
}

// MARK: - State

extension PlayerDetailsViewModel {
    enum State: CaseIterable {
        case viewingDetails
        case addingPlayers
    }
}
