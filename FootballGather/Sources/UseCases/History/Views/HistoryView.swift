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
                makePlayerRowDescription(
                    for: gather,
                    teamDescription: TeamARowDescription(viewModel: viewModel)
                )
                
                teamSeparatorView
                
                makePlayerRowDescription(
                    for: gather,
                    teamDescription: TeamBRowDescription(viewModel: viewModel)
                )
            }
            
            Spacer()
            
            Text(viewModel.scoreDescription(for: gather))
        }
        .padding([.top, .bottom])
    }
    
    private func makePlayerRowDescription(
        for gather: Gather,
        teamDescription: HistoryRowDescriptable
    ) -> some View {
        HStack(spacing: 20) {
            Text(teamDescription.title)
                .font(.title2)
            Text(teamDescription.playersDescription(for: gather))
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
        let storage = AppStorage()
        Gather.demoGathers.forEach { storage.addGather($0) }
        
        return HistoryView(viewModel: .init(storage: storage))
    }
}
