//
//  URLOpener.swift
//  FoundationTools
//
//  Created by Radu Dan on 26.05.2025.
//

import UIKit

public protocol URLOpener {
    func canOpenURL(_ url: URL) -> Bool

    @MainActor
    func openURL(_ url: URL) async
}

extension UIApplication: URLOpener {
    public func openURL(_ url: URL) async {
        await open(url, options: [:])
    }
}
