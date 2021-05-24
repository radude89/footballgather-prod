//
//  PlayerTests.swift
//  
//
//  Created by Radu Dan on 24.05.2021.
//

import XCTest
@testable import CoreModels

final class PlayerTests: XCTestCase {
    
    func testInit() {
        let id = UUID()
        let name = "John Doe"
        let player = Player(id: id, name: name)
        
        XCTAssertEqual(player.id, id)
        XCTAssertEqual(player.name, name)
    }
    
    func testInit_whenNameIsEmpty() {
        let id = UUID()
        let name = ""
        let player = Player(id: id, name: name)
        
        XCTAssertEqual(player.id, id)
        XCTAssertEqual(player.name, name)
    }
    
    func testEquatable_whenPropertiesAreTheSame_equals() {
        let id = UUID()
        let player1 = Player(id: id, name: "John")
        let player2 = Player(id: id, name: "John")
        
        XCTAssertEqual(player1, player2)
    }
    
    func testEquatable_whenIDsAreNotEqual_notEquals() {
        let player1 = Player(id: .init(), name: "John")
        let player2 = Player(id: .init(), name: "John")
        
        XCTAssertNotEqual(player1, player2)
    }
    
    func testEquatable_whenNamesAreNotEqual_notEquals() {
        let id = UUID()
        let player1 = Player(id: id, name: "John")
        let player2 = Player(id: id, name: "Jane")
        
        XCTAssertNotEqual(player1, player2)
    }
    
}
