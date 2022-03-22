//
//  HistoryView.swift
//  UITests
//
//  Created by Radu Dan on 12.01.2022.
//

import SwiftUI
import CoreModels
import HistoryAssets
import FoundationTools
import UITools

public struct HistoryView: View {
    
    @EnvironmentObject var storage: FoundationTools.AppStorage
    
    let viewModel: HistoryViewModel
    
    public init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationView {
            mainContent
                .navigationTitle(LocalizedString.pastGathers)
                .navigationBarTitleDisplayMode(.inline)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    @ViewBuilder
    private var mainContent: some View {
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
        .listStyle(.insetGrouped)
        .accessibilityID(AccessibilityID.historyView)
    }
    
    private var emptyView: some View {
        Text(LocalizedString.noGathers)
            .multilineTextAlignment(.center)
            .padding()
            .accessibilityID(AccessibilityID.historyNoEntries)
    }
    
    private func row(for gather: Gather) -> some View {
        HStack {
            VStack(
                alignment: .leading,
                spacing: 10
            ) {
                makePlayerRowDescription(
                    for: gather,
                    teamDescription: TeamARowDescription(viewModel: viewModel)
                )
                
                Text(LocalizedString.vs)
                    .font(.headline)
                
                makePlayerRowDescription(
                    for: gather,
                    teamDescription: TeamBRowDescription(viewModel: viewModel)
                )
            }
            
            Spacer()
            
            Text(viewModel.scoreDescription(for: gather))
        }
        .padding([.top, .bottom])
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(viewModel.accessibilityLabel(for: gather))
    }
    
    private func makePlayerRowDescription(
        for gather: Gather,
        teamDescription: HistoryRowDescriptable
    ) -> some View {
        Text(teamDescription.playersDescription(for: gather))
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
