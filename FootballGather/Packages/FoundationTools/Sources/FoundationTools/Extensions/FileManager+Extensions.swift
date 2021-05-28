//
//  File.swift
//  
//
//  Created by Radu Dan on 28.05.2021.
//

import Foundation

public extension FileManager {
    static var documentsDirectoryURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
