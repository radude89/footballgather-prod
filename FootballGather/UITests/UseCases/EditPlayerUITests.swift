//
//  EditPlayerUITests.swift
//  UITests
//
//  Created by Radu Dan on 14.10.2021.
//

import XCTest

final class EditPlayerUITests: UITestCase {
    
    var selectionHandler: PlayerDetailsSelection!
    
    private let playerToEditIndex = 1
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        
        selectionHandler = PlayerDetailsSelection(app: app)
        launchApp(populatingStorage: true)
        presentPlayerDetails()
    }
    
    private func presentPlayerDetails() {
        cells[playerToEditIndex].tap()
        XCTAssertTrue(app.tables[.detailsView].waitToAppear())
    }
    
    func save() {
        app.buttons[.saveButton].tap()
    }
    
    func assertAllCellsAreUnticked(file: StaticString = #file, line: UInt = #line) {
        cells.forEach { cell in
            XCTAssertFalse(cell.isTicked, file: file, line: line)
        }
    }
    
    func assertHasSelectedOption(file: StaticString = #file, line: UInt = #line) throws {
        let tickedCell = try XCTUnwrap(cells.first { $0.isTicked }, file: file, line: line)
        XCTAssertTrue(tickedCell.exists, file: file, line: line)
        tickedCell.tap()
    }
    
    func selectDifferentOption(
        for cellType: PlayerDetailsSelection.CellType,
        file: StaticString = #file,
        line: UInt = #line
    ) throws {
        selectionHandler.selectCell(cellType)
        let firstUntickedCell = try XCTUnwrap(cells.first { !$0.isTicked }, file: file, line: line)
        firstUntickedCell.tap()
    }
    
}
