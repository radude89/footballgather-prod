//
//  ConfirmPlayersView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 04.11.2021.
//

import SwiftUI
import CoreModels

struct ConfirmPlayersView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    let players: [Player]
    let gatherCoordinator: GatherCoordinatable
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = ConfirmPlayersViewController(
            players: players,
            gatherCoordinator: gatherCoordinator
        )
        viewController.setEditing(true, animated: true)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
