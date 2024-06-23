//
//  GatherCoordinatable.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 08.02.2022.
//

import UIKit
import SwiftUI
import CoreModels

@MainActor
public protocol GatherCoordinatable {
    func startGather(
        from parent: UIViewController,
        playersTeams: [Team: [Player]],
        animated: Bool
    )
}

struct EmptyGatherCoordinator: GatherCoordinatable {
    func startGather(
        from parent: UIViewController,
        playersTeams: [Team : [Player]],
        animated: Bool
    ) {}
}
