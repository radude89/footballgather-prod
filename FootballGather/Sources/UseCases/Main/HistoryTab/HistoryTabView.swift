//
//  HistoryTabView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 07.02.2022.
//

import SwiftUI
import Localizable

struct HistoryTabView {
    
    private let storage: AppStorage
    
    init(storage: AppStorage) {
        self.storage = storage
    }
    
    var provider: MainTabViewProvider {
        .init(
            icon: "clock",
            title: LocalizedString.pastGathers,
            view: {
                AnyView(
                    HistoryView(viewModel: .init(storage: storage))
                )
            }
        )
    }
    
}
