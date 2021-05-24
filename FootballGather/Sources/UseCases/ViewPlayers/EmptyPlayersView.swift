//
//  EmptyPlayersView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 24.05.2021.
//

import SwiftUI
import Localizable

// MARK: - EmptyPlayersView

struct EmptyPlayersView: View {
    var body: some View {
        Text(LocalizedText.noPlayers)
            .multilineTextAlignment(.center)
            .padding()
    }
}

// MARK: - Preview

struct EmptyPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPlayersView()
            .previewLayout(.sizeThatFits)
    }
}
