//
//  PlayersListViewProvider.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 09.02.2022.
//

import SwiftUI
import CoreModels

struct PlayersListViewProvider<DetailsView: View, ConfirmView: View> {
    let detailsView: (_ showListView: Binding<Bool>, _ player: Player) -> DetailsView
    let confirmPlayersView: (_ players: [Player], _ gatherEnded: Binding<Bool>) -> ConfirmView
}
