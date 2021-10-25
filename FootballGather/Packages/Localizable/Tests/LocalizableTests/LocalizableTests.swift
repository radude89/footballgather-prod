import XCTest
@testable import Localizable

final class LocalizableTests: XCTestCase {
    
    func testLocalizedTexts() {
        let localizedTextDictionary = [
            "players": LocalizedString.players,
            "no.players": LocalizedString.noPlayers,
            "add.players.hint": LocalizedString.addPlayersHint,
            "add.player.label": LocalizedString.addPlayerLabel,
            "done": LocalizedString.done,
            "done.hint": LocalizedString.doneHint,
            "select": LocalizedString.select,
            "select.hint": LocalizedString.selectHint,
            "selected.player": LocalizedString.selectedPlayer,
            "tap.select.player": LocalizedString.tapToSelectPlayer,
            "selected.count": LocalizedString.selectedCount,
            "player.name.field": LocalizedString.playerNameField,
            "section.player.details.header": LocalizedString.sectionDetailsHeader,
            "section.player.details.footer": LocalizedString.sectionDetailsFooter,
            "skill": LocalizedString.skill,
            "position": LocalizedString.position,
            "skillset.and.position.header": LocalizedString.sectionSkillsetHeader,
            "skillset.and.position.footer": LocalizedString.sectionSkillsetFooter,
            "save": LocalizedString.save,
            "add.player": LocalizedString.addPlayer,
            "cancel": LocalizedString.cancel,
            "discard.confirmation": LocalizedString.discardConfirmation,
            "discard.changes.lost": LocalizedString.discardChangesLost,
            "discard": LocalizedString.discard,
            "confirm.players.title": LocalizedString.confirmPlayersTitle
        ]
        
        localizedTextDictionary.forEach { key, value in
            XCTAssertEqual(
                value,
                NSLocalizedString(key, bundle: Bundle.module, comment: ""),
                "Text at \"\(key)\", is not equal with localized text \"\(value)\"."
            )
        }
    }

}

extension LocalizableTests {
    static var allTests = [
        ("testLocalizedTexts", testLocalizedTexts),
    ]
}
