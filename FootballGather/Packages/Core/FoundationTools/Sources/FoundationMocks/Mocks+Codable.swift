//
//  Mocks+Codable.swift
//  
//
//  Created by Radu Dan on 16.03.2022.
//

import FoundationTools
import Foundation

extension Mocks {
    
    public final class Encoder: StorageEncoder {
        
        public var error: StorageError?
        public var encoder: StorageEncoder = JSONEncoder()
        
        public init(
            error: StorageError? = nil,
            encoder: StorageEncoder = JSONEncoder()
        ) {
            self.error = error
            self.encoder = encoder
        }
        
        public func encode<T: Encodable>(_ value: T) throws -> Data {
            guard error == nil else { throw error! }
            
            return try encoder.encode(value)
        }
        
    }
    
    public final class Decoder: StorageDecoder {
        
        public var error: StorageError?
        public var decoder: StorageDecoder = JSONDecoder()
        
        public init(
            error: StorageError? = nil,
            decoder: StorageDecoder = JSONDecoder()
        ) {
            self.error = error
            self.decoder = decoder
        }
        
        public func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
            guard error == nil else { throw error! }
            
            return try decoder.decode(type, from: data)
        }
        
    }
    
    public enum StorageError: Swift.Error {
        case generic
    }
    
}
