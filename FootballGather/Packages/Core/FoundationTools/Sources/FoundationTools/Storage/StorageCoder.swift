//
//  StorageCoder.swift
//  
//
//  Created by Radu Dan on 25.05.2021.
//

import Foundation

// MARK: - StorageEncoder

public protocol StorageEncoder {
    func encode<T: Encodable>(_ value: T) throws -> Data
}

extension JSONEncoder: StorageEncoder {}

// MARK: - StorageDecoder

public protocol StorageDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: StorageDecoder {}

// MARK: - StorageCoder

public struct StorageCoder {
    private let encoder: StorageEncoder
    private let decoder: StorageDecoder
    
    public init(
        encoder: StorageEncoder = JSONEncoder(),
        decoder: StorageDecoder = JSONDecoder()
    ) {
        self.encoder = encoder
        self.decoder = decoder
    }
    
    func encode<T: Encodable>(_ value: T) throws -> Data {
        try encoder.encode(value)
    }
    
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        try decoder.decode(type, from: data)
    }
}
