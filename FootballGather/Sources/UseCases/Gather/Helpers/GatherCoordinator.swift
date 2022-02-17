//
//  GatherCoordinator.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 08.02.2022.
//

import UIKit
import SwiftUI
import CoreModels
import TeamSelection

struct GatherCoordinator: GatherCoordinatable {
    private let gatherEnded: Binding<Bool>
    
    init(gatherEnded: Binding<Bool>) {
        self.gatherEnded = gatherEnded
    }
    
    func startGather(
        from parent: UIViewController,
        playersTeams: [Team : [Player]],
        animated: Bool
    ) {
        let gatherView = GatherView(
            gatherEnded: gatherEnded,
            viewModel: .init(playersTeams: playersTeams)
        )
        let gatherViewController = UIHostingController(rootView: gatherView)
        parent.navigationController?.pushViewController(gatherViewController, animated: animated)
    }
}
