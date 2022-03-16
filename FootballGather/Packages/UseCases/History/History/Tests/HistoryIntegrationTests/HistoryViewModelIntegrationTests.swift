//
//  HistoryViewModelIntegrationTests.swift
//  
//
//  Created by Radu Dan on 15.03.2022.
//

import XCTest
import FoundationTools
import CoreModels
@testable import History

final class HistoryViewModelIntegrationTests: XCTestCase {
    
    private let storageKey = "test_int_storage_key"
    
    func testSortGathers() {
        let storage = makeAppStorage()
        let now = Date()
        let tomorrow = Calendar.current
            .date(byAdding: .day, value: 1, to: now)
        storage.addGather(makeGather(completedAt: now))
        storage.addGather(makeGather(completedAt: tomorrow!))
        let sut = HistoryViewModel(storage: storage)
        
        XCTAssertTrue(sut.gathers[0].completedAt > sut.gathers[1].completedAt)
        
        storage.clear()
    }
    
    // MARK: - Helpers
    
    private func makeGather(
        completedAt: Date,
        score: String = "0-0"
    ) -> Gather {
        Gather(
            completedAt: completedAt,
            score: score,
            teamAPlayers: .demoPlayers,
            teamBPlayers: .demoPlayers
        )
    }
    
    private func makeSUT(
        populateStorage: Bool = false
    ) -> HistoryViewModel {
        .init(
            storage: makeAppStorage(populateStorage: populateStorage)
        )
    }
    
    private func makeAppStorage(
        populateStorage: Bool = false
    ) -> FoundationTools.AppStorage {
        let commandLineHandler = makeCommandLineHandler(
            populateStorage: populateStorage
        )
        let assembler = AppStorageAssembler(
            commandLineHandler: commandLineHandler
        )
        
        return AppStorage(
            storageKey: storageKey,
            storageFactory: assembler,
            commandLineHandler: commandLineHandler
        )
    }
    
    private func makeCommandLineHandler(
        populateStorage: Bool = false
    ) -> CommandLineHandler {
        var commands = [Command.runUITests.rawValue]
        if populateStorage {
            commands.append(
                Command.populateStorage.rawValue
            )
        }
        
        return CommandLineHandler(
            commandLineArguments: commands
        )
    }
    
}
