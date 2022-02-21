//
//  MainTabView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 07.02.2022.
//

import SwiftUI
import HomeAssets

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
                    icon: Images.players.icon,
                    title: LocalizedString.players,
                    view: { AnyView(Text("First Tab")) }
                ),
                .init(
                    icon: Images.history.icon,
                    title: LocalizedString.pastGathers,
                    view: { AnyView(Text("Second Tab")) }
                )
            ]
        )
    }
}
