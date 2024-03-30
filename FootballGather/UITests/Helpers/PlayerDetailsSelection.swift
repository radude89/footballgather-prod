//
//  PlayerDetailsSelection.swift
//  UITests
//
//  Created by Radu Dan on 14.10.2021.
//

import XCTest
import CoreModels
import PlayerDetailsAssets

@MainActor
struct PlayerDetailsSelection {
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    func openItemPicker<T: RawRepresentable>(
        for item: T,
        rowType: PlayerDetailsSelection.RowType
    ) where T.RawValue == String {
        let id = item.rawValue.capitalized
        let textElements = app.staticTexts.matching(identifier: id)
        
        if textElements.count > 1 {
            textElements.element(boundBy: rowType.rawValue).tap()
        } else {
            textElements.element(boundBy: 0).tap()
        }
    }
    
    func selectItem<T: RawRepresentable>(_ item: T) where T.RawValue == String {
        app.buttons[item.rawValue.capitalized].tap()
    }
    
    @discardableResult
    func selectRandomItem<T: RawRepresentable>(from list: [T]) -> T where T.RawValue == String {
        let item = list.randomElement()!
        selectItem(item)
        return item
    }
    
    func selectSameItem<T: RawRepresentable>(
        item: T,
        rowType: RowType
    ) where T.RawValue == String {
        openItemPicker(for: item, rowType: rowType)
        selectItem(item)
    }
}

// MARK: - RowType
extension PlayerDetailsSelection {
    enum RowType: Int {
        case skill
        case position
        
        var description: String {
            switch self {
            case .skill:
                return LocalizedString.skill
            case .position:
                return LocalizedString.position
            }
        }
    }
}
