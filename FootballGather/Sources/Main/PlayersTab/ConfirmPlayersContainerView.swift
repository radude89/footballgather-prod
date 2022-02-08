//
//  ConfirmPlayersContainerView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 08.02.2022.
//

import SwiftUI
import CoreModels

struct ConfirmPlayersContainerView: View {
    
    private let players: [Player]
    private let gatherEnded: Binding<Bool>
    
    init(players: [Player], gatherEnded: Binding<Bool>) {
        self.players = players
        self.gatherEnded = gatherEnded
    }
    
    var body: some View {
        ConfirmPlayersView(
            players: players,
            gatherCoordinator: GatherCoordinator(gatherEnded: gatherEnded)
        )
    }
    
}

struct ConfirmPlayersContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmPlayersContainerView(
            players: .demoPlayers,
            gatherEnded: .constant(false)
        )
    }
}
