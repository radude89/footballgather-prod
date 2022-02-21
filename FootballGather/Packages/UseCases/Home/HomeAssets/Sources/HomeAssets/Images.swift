//
//  Images.swift
//  
//
//  Created by Radu Dan on 21.02.2022.
//

import Foundation

public enum Images: String {
    case players = "person.3.sequence"
    case history = "clock"
}

extension Images {
    public var icon: String {
        rawValue
    }
}
