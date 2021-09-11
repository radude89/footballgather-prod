//
//  Player+Position.swift
//  Player+Position
//
//  Created by Radu Dan on 08.09.2021.
//

import Foundation

public extension Player {
    enum Position: String {
        case goalkeeper
        case defender
        case midfielder
        case winger
        case forward
    }
}

extension Player.Position: CaseIterable {}
