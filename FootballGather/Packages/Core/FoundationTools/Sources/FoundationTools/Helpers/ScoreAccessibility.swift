//
//  ScoreAccessibility.swift
//  
//
//  Created by Radu Dan on 03.12.2021.
//

import CoreModels
import Localizable

public enum ScoreAccessibility {
    public static func viewID(
        for team: Team,
        accessibilityID: AccessibilityID
    ) -> String {
        makeAccessibilityID(for: team, accessibilityID: accessibilityID)
    }
    
    public static func scoreLabelID(for team: Team) -> String {
        makeAccessibilityID(for: team, accessibilityID: .scoreLabel)
    }
    
    public static func scoreHeaderID(for team: Team) -> String {
        makeAccessibilityID(for: team, accessibilityID: .scoreHeader)
    }
    
    public static func scoreStepperID(for team: Team) -> String {
        makeAccessibilityID(for: team, accessibilityID: .scoreStepper)
    }
    
    private static let separator = "-"
    
    internal static func makeAccessibilityID(
        for team: Team,
        accessibilityID: AccessibilityID
    ) -> String {
        accessibilityID.rawValue + separator + team.name
    }
}
