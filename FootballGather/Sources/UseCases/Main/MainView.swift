//
//  MainView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 17.01.2022.
//

import SwiftUI
import Localizable
import FoundationTools

struct MainView: View {
    
    @EnvironmentObject var storage: AppStorage
    
    init() {
        updateAnimationsIfRunningUITests()
    }
    
    private func updateAnimationsIfRunningUITests() {
        if CommandLineHandler().isRunningUITests {
            UIView.setAnimationsEnabled(false)
            (UIApplication.shared.connectedScenes.first! as! UIWindowScene).keyWindow?.layer.speed = 100
        }
    }
    
    var body: some View {
        TabView {
            PlayersView(viewModel: .init(storage: storage))
                .tabItem {
                    Label(
                        LocalizedString.players,
                        systemImage: "person.3.sequence"
                    )
                }
            
            HistoryView(viewModel: .init(storage: storage))
                .tabItem {
                    Label(
                        LocalizedString.pastGathers,
                        systemImage: "clock"
                    )
                }
        }
    }
}

// MARK: - Previews

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(AppStorage())
    }
}
