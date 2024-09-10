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
        AnyView(
            provider.view.tabItem {
                tabLabel(provider: provider)
            }
        )
    }
    
    private func tabLabel(provider: MainTabViewProvider) -> some View {
        Label(
            provider.title,
            systemImage: provider.icon
        )
    }
    
}
