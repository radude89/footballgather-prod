//
//  ScoreAccessibility.swift
//  
//
//  Created by Radu Dan on 03.12.2021.
//

import CoreModels

public enum ScoreAccessibility {
    public static func viewID(
        for team: Team,
        accessibilityID: String
    ) -> String {
        makeAccessibilityID(for: team, accessibilityID: accessibilityID)
    }
    
    public static func scoreLabelID(for team: Team, accessibilityID: String) -> String {
        makeAccessibilityID(for: team, accessibilityID: accessibilityID)
    }
    
    public static func scoreHeaderID(for team: Team, accessibilityID: String) -> String {
        makeAccessibilityID(for: team, accessibilityID: accessibilityID)
    }
    
    public static func scoreStepperID(for team: Team, accessibilityID: String) -> String {
        makeAccessibilityID(for: team, accessibilityID: accessibilityID)
    }
    
    private static let separator = "-"
    
    internal static func makeAccessibilityID(
        for team: Team,
        accessibilityID: String
    ) -> String {
        accessibilityID + separator + team.name
    }
}
