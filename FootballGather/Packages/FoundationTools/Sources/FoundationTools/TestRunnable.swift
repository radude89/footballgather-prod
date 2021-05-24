//
//  TestRunnable.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 18.05.2021.
//

import Foundation

public protocol TestRunnable {
    static var isRunningTests: Bool { get }
}

public extension TestRunnable {
    static var isRunningTests: Bool {
        NSClassFromString("XCTestCase") != nil
    }
}
