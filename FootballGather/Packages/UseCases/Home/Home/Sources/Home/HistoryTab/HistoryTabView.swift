//
//  HistoryTabView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 07.02.2022.
//

import SwiftUI
import HomeAssets
import FoundationTools
import History

@MainActor
struct HistoryTabView {
    
    private let storage: FoundationTools.AppStorage
    
    init(storage: FoundationTools.AppStorage) {
        self.storage = storage
    }
    
    var provider: MainTabViewProvider {
        .init(
            icon: Images.history.icon,
            title: LocalizedString.pastGathers,
            view: {
                AnyView(
                    HistoryView(viewModel: .init(storage: storage))
                )
            }
        )
    }
    
}
