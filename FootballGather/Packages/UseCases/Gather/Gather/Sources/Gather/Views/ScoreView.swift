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
    
    private let viewModel: ScoreViewModel
    @Environment(\.colorScheme) private var colorScheme
    
    init(viewModel: ScoreViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GlassEffectContainer(spacing: 20.0) {
            HStack(spacing: 24) {
                scoreView(for: .teamA)
                scoreView(for: .teamB)
            }
        }
    }

    private var scoreForegroundColor: Color {
        colorScheme == .dark ? .black : .white
    }

    private var scoreBackgroundColor: Color {
        colorScheme == .dark ? .cyan : .mint
    }
    
    private func scoreView(for team: Team) -> some View {
        VStack(spacing: 16) {
            headerView(for: team)
            
            scoreLabel(for: team)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(
                    viewModel.scoreViewAccessibilityLabel(for: team)
                )
            
            stepperView(for: team)
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(.background)
        }
        .glassEffect(.regular, in: .rect(cornerRadius: 24))
    }
    
    private func headerView(for team: Team) -> some View {
        Text(viewModel.headerTitle(for: team))
            .font(.title2)
            .fontWeight(.bold)
            .foregroundStyle(.primary)
            .accessibilityIdentifier(
                ScoreAccessibility.scoreHeaderID(
                    for: team,
                    accessibilityID: AccessibilityID.scoreHeader.rawValue
                )
            )
    }
    
    private func scoreLabel(for team: Team) -> some View {
        Text("\(viewModel.formattedScore(for: team))")
            .font(.system(size: 56, weight: .bold, design: .rounded))
            .foregroundStyle(scoreForegroundColor)
            .frame(minWidth: scoreLabelMinWidth - 12)
            .padding(24)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(scoreBackgroundColor)
            }
            .glassEffect(.regular, in: .rect(cornerRadius: 20))
            .accessibilityIdentifier(
                ScoreAccessibility.scoreLabelID(
                    for: team,
                    accessibilityID: AccessibilityID.scoreLabel.rawValue
                )
            )
    }
    
    private var scoreLabelMinWidth: CGFloat {
        let font = UIFont.systemFont(ofSize: 56, weight: .bold)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let maxScoreString = String(GatherMaxScore.value())
        let size = (maxScoreString as NSString).size(withAttributes: attributes)
        return size.width
    }
    
    private func stepperView(for team: Team) -> some View {
        Stepper("") {
            viewModel.onIncrementScore(for: team)
        } onDecrement: {
            viewModel.onDecrementScore(for: team)
        }
        .labelsHidden()
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .foregroundStyle(.blue)
        .accessibilityIdentifier(
            ScoreAccessibility.scoreStepperID(
                for: team,
                accessibilityID: AccessibilityID.scoreStepper.rawValue
            )
        )
    }
    
}
#Preview {
    ScoreView(viewModel: .init())
        .padding()
}
