//
//  PlayerListView.swift
//  UITests
//
//  Created by Radu Dan on 18.05.2021.
//

import SwiftUI
import Localizable

struct PlayerListView: View {
    var body: some View {
        Text("Hello, World!")
            .accessibilityID(.playerList)
    }
}

struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListView()
    }
}
