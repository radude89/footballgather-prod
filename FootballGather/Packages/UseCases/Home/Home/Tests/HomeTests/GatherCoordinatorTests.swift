//
//  GatherCoordinatorTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 09.02.2022.
//

import XCTest
@testable import Home

final class GatherCoordinatorTests: XCTestCase {

    @MainActor
    func testStartGather_presentsGatherView() {
        let views = makeViews()
        let sut = GatherCoordinator(gatherEnded: .constant(false))
        
        sut.startGather(from: views.viewController, playersTeams: [:], animated: false)
        
        XCTAssertTrue(views.navController.viewControllerPushed)
    }
    
    // MARK: - Helpers
    
    @MainActor
    private func makeViews() -> (navController: MockNavController, viewController: UIViewController) {
        let viewController = UIViewController()
        viewController.loadViewIfNeeded()
        
        let navController = MockNavController(rootViewController: UIViewController())
        navController.pushViewController(viewController, animated: false)
        navController.loadViewIfNeeded()
        navController.viewControllerPushed = false
        
        return (navController, viewController)
    }
    
    private final class MockNavController: UINavigationController {
        
        var viewControllerPushed = false
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
            viewControllerPushed = true
        }
        
    }
    
}
