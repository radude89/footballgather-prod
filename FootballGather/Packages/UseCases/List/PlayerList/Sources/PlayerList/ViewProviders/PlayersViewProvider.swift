//
//  PlayersViewProvider.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 08.02.2022.
//

import SwiftUI
import CoreModels

public struct PlayersViewProvider<AddView: View, DetailsView: View, ConfirmView: View> {
    public let addView: (_ showListView: Binding<Bool>) -> AddView
    public let detailsView: (_ showListView: Binding<Bool>, _ player: Player) -> DetailsView
    public let confirmPlayersView: (_ players: [Player], _ isPresented: Binding<Bool>) -> ConfirmView
    
    public init(
        addView: @escaping (_ showListView: Binding<Bool>) -> AddView,
        detailsView: @escaping (_ showListView: Binding<Bool>, _ player: Player) -> DetailsView,
        confirmPlayersView: @escaping (_ players: [Player], _ isPresented: Binding<Bool>) -> ConfirmView
    ) {
        self.addView = addView
        self.detailsView = detailsView
        self.confirmPlayersView = confirmPlayersView
    }
}
