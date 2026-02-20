//
//  GatherPlayersView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 29.11.2021.
//

import SwiftUI
import GatherAssets
import CoreModels
import UITools

struct GatherPlayersView: View {
    
    private let viewModel: GatherPlayersViewModel
    
    init(viewModel: GatherPlayersViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 20) {
            section(for: .teamA)
            section(for: .teamB)
        }
        .accessibilityID(AccessibilityID.gatherPlayersList)
    }
    
    private func section(for team: Team) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(viewModel.sectionName(for: team))
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            
            VStack(spacing: 8) {
                ForEach(viewModel.players(in: team)) { player in
                    HStack {
                        Text(player.name)
                        Spacer()
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 12)
                    .background(Color(uiColor: .secondarySystemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}

#Preview {
    GatherPlayersView(
        viewModel: .init(
            playersTeams: [
                .teamA: [
                    Player(name: "John"),
                    Player(name: "Jane"),
                    Player(name: "Arthur")
                ],
                .teamB: [
                    Player(name: "Michael"),
                    Player(name: "Sarah"),
                    Player(name: "David")
                ]
            ]
        )
    )
    .padding()
    .background(Color(uiColor: .systemGroupedBackground))
}
