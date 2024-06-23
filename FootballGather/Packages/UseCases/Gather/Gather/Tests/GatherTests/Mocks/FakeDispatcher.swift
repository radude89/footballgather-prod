//
//  FakeDispatcher.swift
//  
//
//  Created by Radu Dan on 23.06.2024.
//

import Foundation
@testable import Gather

struct FakeDispatcher: DispatchHelper {
    func executeAsync(work: @escaping () -> Void) {
        work()
    }
}
