//
//  PlayersFinder.swift
//  UITests
//
//  Created by Radu Dan on 15.11.2021.
//

import XCTest
import CoreModels

struct PlayersFinder {
    
    private let app: XCUIApplication
    private let table: XCUIElement
    
    init(app: XCUIApplication, table: XCUIElement) {
        self.app = app
        self.table = table
    }
    
    func nameOfPlayers(inTeam team: Team) -> [String] {
        switch team {
        case .bench:
            return benchPlayerNames
        case .teamA:
            return teamAPlayerNames
        case .teamB:
            return teamBPlayerNames
        }
    }
    
    private var benchPlayerNames: [String] {
        Array(tableLabels[benchIndex + 1 ..< teamAIndex])
    }
    
    private var teamAPlayerNames: [String] {
        Array(tableLabels[teamAIndex + 1 ..< teamBIndex])
    }
    
    private var teamBPlayerNames: [String] {
        Array(tableLabels[(teamBIndex + 1)...])
    }
    
    private var tableLabels: [String] {
        (0 ..< table.staticTexts.count).enumerated().map {
            table.staticTexts.element(boundBy: $0.offset).label
        }
    }
    
    private var benchIndex: Int {
        index(of: .bench)
    }
    
    private var teamAIndex: Int {
        index(of: .teamA)
    }
    
    private var teamBIndex: Int {
        index(of: .teamB)
    }
    
    private func index(of team: Team) -> Int {
        tableLabels.firstIndex(of: team.name.uppercased())!
    }
    
}
