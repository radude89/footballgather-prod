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
                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
            .onDelete {
                viewModel.deleteGather(at: $0)
                disableEditModeIfNeeded()
            }
        }
        .listStyle(.plain)
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
        HStack(alignment: .center, spacing: 16) {
            VStack(
                alignment: .leading,
                spacing: 16
            ) {
                teamSection(
                    players: makePlayerRowDescription(
                        for: gather,
                        teamDescription: TeamARowDescription(viewModel: viewModel)
                    )
                )
                
                Divider()
                    .padding(.horizontal, -8)
                
                teamSection(
                    players: makePlayerRowDescription(
                        for: gather,
                        teamDescription: TeamBRowDescription(viewModel: viewModel)
                    )
                )
            }
            
            Spacer()
            
            scoreView(for: gather)
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.background)
                .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 2)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.separator.opacity(0.5), lineWidth: 1)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(viewModel.accessibilityLabel(for: gather))
    }
    
    private func teamSection<Content: View>(players: Content) -> some View {
        players
            .font(.body)
            .foregroundStyle(.primary)
    }
    
    private func scoreView(for gather: Gather) -> some View {
        Text(viewModel.scoreDescription(for: gather))
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundStyle(.primary)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.tint.opacity(0.1))
            }
            .glassEffect(.regular, in: .rect(cornerRadius: 12))
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
