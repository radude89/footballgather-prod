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
    case selectButton = "select-button"
    case doneButton = "done-button"
    case selectedRow = "selected-row"
    case unselectedRow = "unselected-row"
    case addView = "add-view"
    case saveButton = "save-button"
    case cancelButton = "cancel-button"
    case enterNameTextfield = "enter-name-textfield"
    case detailsView = "details-view"
    case confirmPlayersView = "confirm-players-view"
    case confirmButton = "confirm-button"
    case startGatherButton = "start-gather-button"
    case gatherPlayersList = "gather-players-list"
    case endGatherButton = "end-gather-button"
    case scoreHeader = "score-header"
    case scoreLabel = "score-label"
    case scoreStepper = "score-stepper"
    case actionTimerButton = "action-timer-button"
    case timerView = "timer-view"
    case setTimeButton = "set-time-button"
    case setTimeView = "set-time-view"
    case minutesPickerView = "minutes-picker-view"
    case secondsPickerView = "seconds-picker-view"
    case historyView = "history-view"
    case historyNoEntries = "history-no-entries"
}

extension AccessibilityID: CaseIterable {}
