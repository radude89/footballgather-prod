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
    public static let doneHint = localizedText(key: "done.hint")
    public static let edit = localizedText(key: "edit")
    public static let editHint = localizedText(key: "edit.hint")
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
}
