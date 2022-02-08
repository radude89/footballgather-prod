//
//  PlayersViewProvider.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 08.02.2022.
//

import SwiftUI
import CoreModels

struct PlayersViewProvider<AddView: View, DetailsView: View, ConfirmView: View> {
    let addView: (_ showListView: Binding<Bool>) -> AddView
    let detailsView: (_ showListView: Binding<Bool>, _ player: Player) -> DetailsView
    let confirmPlayersView: (_ players: [Player], _ gatherEnded: Binding<Bool>) -> ConfirmView
}
