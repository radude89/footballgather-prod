//
//  TeamsTableAsserter.swift
//  UITests
//
//  Created by Radu Dan on 30.11.2021.
//

import XCTest
import CoreModels

struct TeamsTableAsserter {
    private let cells: [XCUIElement]
    private let table: XCUIElement
    
    init(cells: [XCUIElement], table: XCUIElement) {
        self.cells = cells
        self.table = table
    }
    
    func assertSection(
        forTeam team: Team,
        shouldExist: Bool,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let sectionExists = table.staticTexts[team.name.uppercased()].exists
        XCTAssertTrue(
            shouldExist ? sectionExists : !sectionExists,
            file: file,
            line: line
        )
    }
    
    func assertRow(
        at index: Int,
        hasLabel label: String,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertTrue(
            cells[index].staticTexts[label].exists,
            file: file,
            line: line
        )
    }
}
