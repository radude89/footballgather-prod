//
//  GatherScoreView.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 29.11.2021.
//

import SwiftUI
import CoreModels

struct GatherScoreView: View {
    @State private var teamAScore = 99
    @State private var teamBScore = 98
    
    var body: some View {
        HStack(spacing: 50) {
            scoreView(for: .teamA, value: $teamAScore)
            scoreView(for: .teamB, value: $teamBScore)
        }
        .padding()
    }
    
    private func scoreView(for team: Team, value: Binding<Int>) -> some View {
        VStack(spacing: 25) {
            Text(team.name.uppercased())
            Text("\(value.wrappedValue)")
                .padding()
                .font(.system(.largeTitle, design: .monospaced))
                .background(
                    Circle()
                        .stroke(.black, lineWidth: 2)
                )
            Stepper("", value: value, in: 1...99)
                .labelsHidden()
        }
    }
}

struct GatherScoreView_Previews: PreviewProvider {
    static var previews: some View {
        GatherScoreView()
    }
}
