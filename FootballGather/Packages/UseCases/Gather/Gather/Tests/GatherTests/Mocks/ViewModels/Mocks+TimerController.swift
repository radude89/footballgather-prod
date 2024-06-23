//
//  Mocks+TimerController.swift
//  
//
//  Created by Radu Dan on 21.03.2022.
//

import Foundation
import Combine
@testable import Gather

extension Mocks {
    
    nonisolated(unsafe) static let timer = Timer.TimerPublisher(
        interval: 0.0000001,
        runLoop: .current,
        mode: .default
    )

    final class TimerController: TimerControllable {
        
        private(set) var timerStarted = false
        private(set) var timerStopped = false
        private let remainingTimeUnit: Int
        private var cancellable: AnyCancellable?
        
        init(remainingTimeUnit: Int = 1) {
            precondition(remainingTimeUnit > 0)
            self.remainingTimeUnit = remainingTimeUnit
        }

        func startTimer(onUpdate: @escaping (Date) -> ()) {
            timerStarted = true
            updateTime(onUpdate)
        }
        
        private func updateTime(_ onUpdate: @escaping (Date) -> ()) {
            cancellable = (0 ..< remainingTimeUnit).publisher.sink { _ in
                onUpdate(Date())
            }
        }
        
        func stopTimer() {
            timerStopped = true
        }
        
    }
    
}
