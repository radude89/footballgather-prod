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
            "cancel.hint": LocalizedString.cancelHint,
            "select": LocalizedString.select,
            "select.hint": LocalizedString.selectHint,
            "selected.player": LocalizedString.selectedPlayer,
            "tap.select.player": LocalizedString.tapToSelectPlayer,
            "delete": LocalizedString.delete,
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
            "confirm.players.title": LocalizedString.confirmPlayersTitle,
            "start.gather": LocalizedString.startGather,
            "start.gather.hint": LocalizedString.startGatherHint,
            "gather.in.progress": LocalizedString.gatherInProgress,
            "end.gather": LocalizedString.endGather,
            "end.gather.confirmation": LocalizedString.endGatherConfirmation,
            "end.gather.message": LocalizedString.endGatherMessage,
            "yes": LocalizedString.yes,
            "no": LocalizedString.no,
            "start": LocalizedString.start,
            "start.timer.label": LocalizedString.startTimerLabel,
            "pause": LocalizedString.pause,
            "pause.timer.label": LocalizedString.pauseTimerLabel,
            "resume": LocalizedString.resume,
            "resume.timer.label": LocalizedString.resumeTimerLabel,
            "cancel.timer.label": LocalizedString.cancelTimerLabel,
            "ok": LocalizedString.ok,
            "time.is.up.title": LocalizedString.timeIsUpTitle,
            "minutes": LocalizedString.minutes,
            "seconds": LocalizedString.seconds,
            "set.time": LocalizedString.setTime,
            "no.gathers": LocalizedString.noGathers,
            "vs": LocalizedString.vs,
            "past.gathers": LocalizedString.pastGathers,
            "gather.complete.title": LocalizedString.gatherCompleteTitle,
            "gather.complete.message": LocalizedString.gatherCompleteMessage,
            "gather.score.accessibility.label": LocalizedString.gatherScoreAccessibilityLabel,
            "gather.all.accessibility.label": LocalizedString.gatherAllAccessibilityLabel,
            "gather.draw": LocalizedString.gatherDraw,
            "gather.players.in.team": LocalizedString.gatherPlayersInTeam
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
