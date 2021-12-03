//
//  GatherScoreView.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 29.11.2021.
//

import SwiftUI
import CoreModels
import FoundationTools

struct GatherScoreView: View {
    
    @ObservedObject var viewModel: GatherScoreViewModel
    
    private enum ViewConstants {
        static let defaultSpacing: CGFloat = 25
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
            headerView(for: team)
            scoreLabel(for: team)
            stepperView(for: team)
        }
    }
    
    private func headerView(for team: Team) -> some View {
        Text(viewModel.headerTitle(for: team))
            .accessibilityIdentifier(GatherScoreAccessibility.scoreHeaderID(for: team))
    }
    
    private func scoreLabel(for team: Team) -> some View {
        Text("\(viewModel.formattedScore(for: team))")
            .padding()
            .font(.system(.largeTitle, design: .monospaced))
            .background(
                Circle()
                    .stroke(.black, lineWidth: 2)
            )
            .accessibilityIdentifier(GatherScoreAccessibility.scoreLabelID(for: team))
    }
    
    private func stepperView(for team: Team) -> some View {
        Stepper("") {
            viewModel.onIncrementScore(for: team)
        } onDecrement: {
            viewModel.onDecrementScore(for: team)
        }
        .labelsHidden()
        .accessibilityIdentifier(GatherScoreAccessibility.scoreStepperID(for: team))
    }
    
}

// MARK: - Preview

struct GatherScoreView_Previews: PreviewProvider {
    static var previews: some View {
        GatherScoreView(viewModel: .init())
    }
}
