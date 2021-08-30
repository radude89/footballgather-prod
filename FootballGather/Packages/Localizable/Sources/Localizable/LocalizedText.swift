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
}
