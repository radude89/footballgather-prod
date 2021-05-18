//
//  AppLauncher.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 18.05.2021.
//

import SwiftUI

@main
struct AppLauncher {
    static func main() throws {
        if isRunningTests {
            TestApp.main()
        } else {
            FootballGatherApp.main()
        }
    }
}

extension AppLauncher: TestRunnable {}
