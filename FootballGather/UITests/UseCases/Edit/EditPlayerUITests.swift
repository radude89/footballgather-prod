//
//  EditPlayerUITests.swift
//  UITests
//
//  Created by Radu Dan on 14.10.2021.
//

import XCTest
import CoreModels

final class EditPlayerUITests: UITestCase {
    
    var selectionHandler: PlayerDetailsSelection!

    let playerToEditIndex = 1
    let knownPositions = Player.Position.allCases.filter { $0 != .unknown }
    let knownSkills = Player.Skill.allCases.filter { $0 != .unknown }
    
    let unknownPosition = Player.Position.unknown
    let unknownSkill = Player.Skill.unknown
    
    // MARK: - Setup
    
    @MainActor
    override func setUp() {
        super.setUp()
        
        selectionHandler = PlayerDetailsSelection(app: app)
        launchApp(populatingStorage: true)
        presentPlayerDetails()
    }
    
    @MainActor
    private func presentPlayerDetails() {
        cells[playerToEditIndex].tap()
        XCTAssertTrue(app.collectionViews[.detailsView].waitToAppear())
    }
    
    // MARK: - Helpers
    
    @MainActor
    func save() {
        saveButton.tap()
    }
    
    @MainActor
    func assertItemIsSelected<Item: RawRepresentable>(
        _ item: Item,
        file: StaticString = #filePath,
        line: UInt = #line
    ) where Item.RawValue == String {
        XCTAssertTrue(
            app.buttons[item.rawValue.capitalized].isSelected,
            file: file,
            line: line
        )
    }
    
    @MainActor
    func assertItemsAreUnselected<Item: RawRepresentable>(
        _ items: [Item],
        file: StaticString = #filePath,
        line: UInt = #line
    ) where Item.RawValue == String {
        items.forEach {
            XCTAssertFalse(
                app.buttons[$0.rawValue.capitalized].isSelected,
                file: file,
                line: line
            )
        }
    }
    
    @MainActor
    func setPlayerWithRandomItem<T: RawRepresentable>(
        from list: [T],
        currentItem: T,
        rowType: PlayerDetailsSelection.RowType
    ) -> T where T.RawValue == String {
        selectionHandler.openItemPicker(for: currentItem, rowType: rowType)
        let item = selectionHandler.selectRandomItem(from: list)
        save()
        cells[cells.count - 1].tap()
        return item
    }
    
}
