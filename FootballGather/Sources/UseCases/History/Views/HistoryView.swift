//
//  HistoryView.swift
//  UITests
//
//  Created by Radu Dan on 12.01.2022.
//

import SwiftUI
import CoreModels

struct HistoryView: View {
    
    let viewModel: HistoryViewModel
    
    var body: some View {
        if viewModel.hasGathers {
            listView
        } else {
            emptyView
        }
    }
    
    private var listView: some View {
        List(viewModel.gathers) { gather in
            row(for: gather)
        }
        .listStyle(.plain)
    }
    
    private var emptyView: some View {
        Text("No gathers played")
            .multilineTextAlignment(.center)
            .padding()
    }
    
    private func row(for gather: Gather) -> some View {
        HStack {
            VStack(alignment: .leading) {
                makePlayerRowDescription(for: gather, isTeamA: true)
                teamSeparatorView
                makePlayerRowDescription(for: gather, isTeamA: false)
            }
            
            Spacer()
            
            Text(viewModel.scoreDescription(for: gather))
        }
        .padding([.top, .bottom])
    }
    
    private func makePlayerRowDescription(
        for gather: Gather,
        isTeamA: Bool
    ) -> some View {
        HStack(spacing: 20) {
            Text(isTeamA ? "Team A" : "Team B")
                .font(.title2)
            Text(
                isTeamA ?
                viewModel.teamAPlayersDescription(for: gather) :
                    viewModel.teamBPlayersDescription(for: gather)
            )
        }
    }
    
    private var teamSeparatorView: some View {
        HStack {
            Spacer()
            Text("vs")
                .font(.headline)
            Spacer()
        }
    }
    
}

// MARK: - Preview

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(viewModel: .init(storage: .init()))
    }
}
