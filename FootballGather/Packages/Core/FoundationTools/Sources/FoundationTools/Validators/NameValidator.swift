//
//  NameValidator.swift
//  
//
//  Created by Radu Dan on 25.09.2021.
//

import Foundation

public struct NameValidator {
    private let name: String
    
    public init(name: String) {
        self.name = name
    }
    
    public var isValid: Bool {
        !(name.isEmpty || containsOnlySpaces || startsWithSpace)
    }

    private var containsOnlySpaces: Bool {
        name.replacingOccurrences(of: " ", with: "").isEmpty
    }
    
    private var startsWithSpace: Bool {
        name.starts(with: " ")
    }
}
