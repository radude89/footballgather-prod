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
        let player = Player(id: id, name: name, position: .defender, skill: .amateur)
        
        XCTAssertEqual(player.id, id)
        XCTAssertEqual(player.name, name)
        XCTAssertEqual(player.position, .defender)
        XCTAssertEqual(player.skill, .amateur)
    }
    
    func testInit_whenNameIsEmpty() {
        let id = UUID()
        let name = ""
        let player = Player(id: id, name: name)
        
        XCTAssertEqual(player.id, id)
        XCTAssertEqual(player.name, name)
        XCTAssertEqual(player.position, .unknown)
        XCTAssertEqual(player.skill, .unknown)
    }
    
    func testEquatable_whenPropertiesAreTheSame_equals() {
        let id = UUID()
        let player1 = Player(id: id, name: "John", position: .forward, skill: .rookie)
        let player2 = Player(id: id, name: "John", position: .forward, skill: .rookie)
        
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
