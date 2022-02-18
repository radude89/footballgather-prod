//
//  ConfirmPlayersView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 04.11.2021.
//

import SwiftUI
import CoreModels

public struct ConfirmPlayersView: UIViewControllerRepresentable {
    public typealias UIViewControllerType = UIViewController
    
    private let players: [Player]
    private let gatherCoordinator: GatherCoordinatable
    
    public init(players: [Player], gatherCoordinator: GatherCoordinatable) {
        self.players = players
        self.gatherCoordinator = gatherCoordinator
    }
    
    public func makeUIViewController(context: Context) -> UIViewController {
        let viewController = ConfirmPlayersViewController(
            players: players,
            gatherCoordinator: gatherCoordinator
        )
        viewController.setEditing(true, animated: true)
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
