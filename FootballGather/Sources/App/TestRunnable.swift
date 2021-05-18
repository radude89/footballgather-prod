//
//  TestRunnable.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 18.05.2021.
//

import Foundation

protocol TestRunnable {
    static var isRunningTests: Bool { get }
}

extension TestRunnable {
    static var isRunningTests: Bool {
        NSClassFromString("XCTestCase") != nil
    }
}
