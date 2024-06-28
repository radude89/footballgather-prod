//
//  TimerViewModel+UIModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 16.12.2021.
//

import GatherAssets
import FoundationTools

@MainActor
protocol ActionTimerButtonModel {
    var title: String { get }
    var accessibilityLabel: String { get }
}

@MainActor
extension TimerViewModel {
    enum ActionTimerButtonModelFactory {
        static func makeModel(
            from state: TimerState
        ) -> ActionTimerButtonModel {
            switch state {
            case .started:
                return TimerStartedButtonModel()
            case .paused:
                return TimerPausedButtonModel()
            case .stopped:
                return TimerStoppedButtonModel()
            }
        }
    }
    
    struct TimerStoppedButtonModel: ActionTimerButtonModel {
        let title = LocalizedString.start
        let accessibilityLabel = LocalizedString.startTimerLabel
    }
    
    struct TimerPausedButtonModel: ActionTimerButtonModel {
        let title = LocalizedString.resume
        let accessibilityLabel = LocalizedString.resumeTimerLabel
    }
    
    struct TimerStartedButtonModel: ActionTimerButtonModel {
        let title = LocalizedString.pause
        let accessibilityLabel = LocalizedString.pauseTimerLabel
    }
}
