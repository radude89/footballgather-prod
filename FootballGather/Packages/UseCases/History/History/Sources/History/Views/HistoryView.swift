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
    
    private let viewModel: HistoryViewModel
    @State private var isEditing = false
    
    public init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationStack {
            mainContent
                .navigationTitle(LocalizedString.pastGathers)
        }
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
        List {
            ForEach(viewModel.gathers) { gather in
                row(for: gather)
            }
            .onDelete {
                viewModel.deleteGather(at: $0)
                disableEditModeIfNeeded()
            }
        }
        .listStyle(.insetGrouped)
        .accessibilityID(AccessibilityID.historyView)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation {
                        isEditing.toggle()
                    }
                } label: {
                    Text(isEditing ? LocalizedString.done : LocalizedString.edit)
                }
                .disabled(!viewModel.hasGathers)
            }
        }
        .environment(\.editMode, .constant(isEditing ? .active : .inactive))
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
    
    private func disableEditModeIfNeeded() {
        if viewModel.gathers.isEmpty {
            isEditing = false
        }
    }
    
}
