//
//  LocalizedText.swift
//  
//
//  Created by Radu Dan on 25.03.2021.
//

import Foundation

public enum LocalizedText: Localizable {
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
}
