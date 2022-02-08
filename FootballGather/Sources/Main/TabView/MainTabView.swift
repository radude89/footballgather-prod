//
//  MainTabView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 07.02.2022.
//

import SwiftUI
import Localizable

struct MainTabView: View {
    
    let tabProviders: [MainTabViewProvider]
    
    var body: some View {
        TabView {
            tabsView
        }
    }
    
    private var tabsView: some View {
        ForEach(tabProviders, id: \.title) { tabProvider in
            tabItemView(provider: tabProvider)
        }
    }
    
    private func tabItemView(provider: MainTabViewProvider) -> some View {
        provider.view().tabItem {
            tabLabel(provider: provider)
        }
    }
    
    private func tabLabel(provider: MainTabViewProvider) -> some View {
        Label(
            provider.title,
            systemImage: provider.icon
        )
    }
    
}

// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(
            tabProviders: [
                .init(
                    icon: "person.3.sequence",
                    title: LocalizedString.players,
                    view: { AnyView(Text("First Tab")) }
                ),
                .init(
                    icon: "clock",
                    title: LocalizedString.pastGathers,
                    view: { AnyView(Text("Second Tab")) }
                )
            ]
        )
    }
}
