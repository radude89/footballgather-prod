//
//  PlayersViewModel.swift
//  PlayersViewModel
//
//  Created by Radu Dan on 02.09.2021.
//

import SwiftUI
import CoreModels
import FoundationTools

@Observable
@MainActor
public final class PlayersViewModel {
    
    private(set) var storage: PlayerStorageHandler
    private let urlOpener: URLOpener
    private static let urlString = "https://footballgather.app/support.html"

    public init(
        storage: PlayerStorageHandler,
        urlOpener: URLOpener = UIApplication.shared
    ) {
        self.storage = storage
        self.urlOpener = urlOpener
    }
    
    var hasPlayers: Bool {
        storage.storedPlayers.isEmpty == false
    }
    
    var storedPlayers: [Player] {
        storage.storedPlayers
    }

    func onTapSupportButton() async {
        guard let url = URL(string: Self.urlString),
              urlOpener.canOpenURL(url) else {
            return
        }

        await urlOpener.openURL(url)
    }

}
