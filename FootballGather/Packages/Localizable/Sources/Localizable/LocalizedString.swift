//
//  LocalizedString.swift
//  
//
//  Created by Radu Dan on 25.03.2021.
//

import Foundation

public enum LocalizedString: Localizable {
    public static let players = localizedText(key: "players")
    public static let noPlayers = localizedText(key: "no.players")
    public static let addPlayersHint = localizedText(key: "add.players.hint")
    public static let addPlayerLabel = localizedText(key: "add.player.label")
    public static let done = localizedText(key: "done")
    public static let cancelHint = localizedText(key: "cancel.hint")
    public static let select = localizedText(key: "select")
    public static let selectHint = localizedText(key: "select.hint")
    public static let selectedPlayer = localizedText(key: "selected.player")
    public static let tapToSelectPlayer = localizedText(key: "tap.select.player")
    public static let selectedCount = localizedText(key: "selected.count")
    public static let playerNameField = localizedText(key: "player.name.field")
    public static let sectionDetailsHeader = localizedText(key: "section.player.details.header")
    public static let sectionDetailsFooter = localizedText(key: "section.player.details.footer")
    public static let skill = localizedText(key: "skill")
    public static let position = localizedText(key: "position")
    public static let sectionSkillsetHeader = localizedText(key: "skillset.and.position.header")
    public static let sectionSkillsetFooter = localizedText(key: "skillset.and.position.footer")
    public static let save = localizedText(key: "save")
    public static let addPlayer = localizedText(key: "add.player")
    public static let cancel = localizedText(key: "cancel")
    public static let discardConfirmation = localizedText(key: "discard.confirmation")
    public static let discardChangesLost = localizedText(key: "discard.changes.lost")
    public static let discard = localizedText(key: "discard")
    public static let confirmPlayersTitle = localizedText(key: "confirm.players.title")
    public static let confirmPlayersButtonHint = localizedText(key: "confirm.players.button.hint")
    public static let startGather = localizedText(key: "start.gather")
    public static let startGatherHint = localizedText(key: "start.gather.hint")
    public static let gatherInProgress = localizedText(key: "gather.in.progress")
    public static let endGather = localizedText(key: "end.gather")
    public static let endGatherConfirmation = localizedText(key: "end.gather.confirmation")
    public static let endGatherMessage = localizedText(key: "end.gather.message")
    public static let yes = localizedText(key: "yes")
    public static let no = localizedText(key: "no")
    public static let start = localizedText(key: "start")
    public static let startTimerLabel = localizedText(key: "start.timer.label")
    public static let pause = localizedText(key: "pause")
    public static let pauseTimerLabel = localizedText(key: "pause.timer.label")
    public static let resume = localizedText(key: "resume")
    public static let resumeTimerLabel = localizedText(key: "resume.timer.label")
    public static let cancelTimerLabel = localizedText(key: "cancel.timer.label")
}
