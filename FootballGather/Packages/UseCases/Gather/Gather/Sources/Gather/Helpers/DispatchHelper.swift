//
//  DispatchHelper.swift
//  
//
//  Created by Radu Dan on 23.06.2024.
//

import Foundation

protocol DispatchHelper {
    func executeAsync(work: @escaping @Sendable () -> Void)
}

extension DispatchQueue: DispatchHelper {
    func executeAsync(work: @escaping @Sendable () -> Void) {
        async {
            work()
        }
    }
}
