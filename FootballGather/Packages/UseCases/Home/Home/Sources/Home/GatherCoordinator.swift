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
import Gather
import FoundationTools

struct GatherCoordinator: GatherCoordinatable {
    
    private let gatherEnded: Binding<Bool>
    private let storage: FoundationTools.AppStorage
    
    init(
        gatherEnded: Binding<Bool>,
        storage: FoundationTools.AppStorage
    ) {
        self.gatherEnded = gatherEnded
        self.storage = storage
    }
    
    func startGather(
        from parent: UIViewController,
        playersTeams: [Team : [Player]],
        animated: Bool
    ) {
        let gatherView = GatherView(
            storage: storage,
            gatherEnded: gatherEnded,
            viewModel: .init(playersTeams: playersTeams)
        )
        let gatherViewController = UIHostingController(rootView: gatherView)
        parent.navigationController?.pushViewController(gatherViewController, animated: animated)
    }
    
}
