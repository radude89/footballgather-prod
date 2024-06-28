//
//  ScoreView.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 29.11.2021.
//

import SwiftUI
import CoreModels
import FoundationTools
import GatherAssets

struct ScoreView: View {
    
    private enum ViewConstants {
        static let defaultSpacing: CGFloat = 25
    }
    
    private let viewModel: ScoreViewModel
    
    init(viewModel: ScoreViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(spacing: 2 * ViewConstants.defaultSpacing) {
            scoreView(for: .teamA)
            scoreView(for: .teamB)
        }
        .padding()
    }
    
    private func scoreView(for team: Team) -> some View {
        VStack(spacing: ViewConstants.defaultSpacing) {
            VStack {
                headerView(for: team)
                scoreLabel(for: team)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(
                viewModel.scoreViewAccessibilityLabel(for: team)
            )
            
            stepperView(for: team)
        }
    }
    
    private func headerView(for team: Team) -> some View {
        Text(viewModel.headerTitle(for: team))
            .accessibilityIdentifier(
                ScoreAccessibility.scoreHeaderID(
                    for: team,
                    accessibilityID: AccessibilityID.scoreHeader.rawValue
                )
            )
    }
    
    private func scoreLabel(for team: Team) -> some View {
        Text("\(viewModel.formattedScore(for: team))")
            .padding()
            .font(.system(.largeTitle, design: .monospaced))
            .accessibilityIdentifier(
                ScoreAccessibility.scoreLabelID(
                    for: team,
                    accessibilityID: AccessibilityID.scoreLabel.rawValue
                )
            )
    }
    
    private func stepperView(for team: Team) -> some View {
        Stepper("") {
            viewModel.onIncrementScore(for: team)
        } onDecrement: {
            viewModel.onDecrementScore(for: team)
        }
        .labelsHidden()
        .accessibilityIdentifier(
            ScoreAccessibility.scoreStepperID(
                for: team,
                accessibilityID: AccessibilityID.scoreStepper.rawValue
            )
        )
    }
    
}
