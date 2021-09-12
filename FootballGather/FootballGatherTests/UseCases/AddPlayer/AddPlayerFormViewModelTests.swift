//
//  AddPlayerFormViewModelTests.swift
//  AddPlayerFormViewModelTests
//
//  Created by Radu Dan on 12.09.2021.
//

import XCTest
import Combine
import CoreModels
@testable import FootballGather

final class AddPlayerFormViewModelTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    func testSelectedPlayer() throws {
        var expectedPlayerNames = ["", "John"]
        let receivedAllExpectation = expectation(description: "Adding player expectation")
        let sut = AddPlayerFormViewModel()
                
        sut.$selectedPlayer
            .sink { player in
                guard let expectedPlayerName = expectedPlayerNames.first else {
                    XCTFail("Received more values than expected.")
                    return
                }
                
                guard expectedPlayerName == player.name else {
                    XCTFail("Expected received \(player.name) to match first expected \(expectedPlayerName)")
                    return
                }
                
                expectedPlayerNames = Array(expectedPlayerNames.dropFirst())
                
                if expectedPlayerNames.isEmpty {
                    receivedAllExpectation.fulfill()
                }
                
            }
            .store(in: &cancellables)
        
        sut.selectedPlayer.name = "John"
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
}
