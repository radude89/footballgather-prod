//
//  FileStorage.swift
//  
//
//  Created by Radu Dan on 28.05.2021.
//

import Foundation

// MARK: - FileStorage

public struct FileStorage<Key: Hashable, Value: Codable> {
    
    private let fileManager: FileManager
    private let documentsURL: URL
    private let coder: StorageCoder
    private let configuration: Configuration
    
    public struct Configuration {
        public let writeAtomically: Bool
        public let encoding: String.Encoding
        
        public init(writeAtomically: Bool = true, encoding: String.Encoding = .utf8) {
            self.writeAtomically = writeAtomically
            self.encoding = encoding
        }
    }
    
    public init(
        fileManager: FileManager = .default,
        documentsURL: URL = FileManager.documentsDirectoryURL,
        coder: StorageCoder = .init(),
        configuration: Configuration = .init()
    ) {
        self.fileManager = fileManager
        self.documentsURL = documentsURL
        self.coder = coder
        self.configuration = configuration
    }
}

// MARK: - Storageable

extension FileStorage: Storageable {
    public func store(_ object: Value, at key: Key) {
        guard let fileName = key as? String,
              let data = try? coder.encode(object) else {
            return
        }
        
        try? store(data, name: fileName)
    }
    
    private func store(_ data: Data, name: String) throws {
        let text = String(data: data, encoding: configuration.encoding)!
        let url = documentsURL.appendingPathComponent(name)
        
        try text.write(
            to: url,
            atomically: configuration.writeAtomically,
            encoding: configuration.encoding
        )
    }
    
    public func load(forKey key: Key) -> Value? {
        guard let path = key as? String else { return nil }
        
        let url = documentsURL.appendingPathComponent(path)
        
        guard let data = try? Data(contentsOf: url),
              let decoded = try? coder.decode(Value.self, from: data) else {
            return nil
        }
        
        return decoded
    }
    
    public func deleteObject(forKey key: Key) {
        guard let path = key as? String else { return }

        let url = documentsURL.appendingPathComponent(path)
        try? fileManager.removeItem(at: url)
    }
    
    public func clear() {
        let url = documentsURL.path
        
        guard let paths = try? fileManager.contentsOfDirectory(atPath: url) else {
            return
        }
        
        paths.forEach {
            try? fileManager.removeItem(atPath: url + "/\($0)")
        }
    }
}
