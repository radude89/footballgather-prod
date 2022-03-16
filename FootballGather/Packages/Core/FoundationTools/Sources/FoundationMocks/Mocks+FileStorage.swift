//
//  Mocks+FileStorage.swift
//  
//
//  Created by Radu Dan on 16.03.2022.
//

import FoundationTools
import Foundation

extension Mocks {
    public static func makeFileStorage(
        _ fileManager: FileManager = .init(),
        filePath: String = NSTemporaryDirectory() + "com.mocks",
        storageCoder: StorageCoder = makeStorageCoder()
    ) throws -> FileStorage<String, [String]> {
        
        try? fileManager.removeItem(atPath: filePath)
        try fileManager.createDirectory(
            atPath: filePath,
            withIntermediateDirectories: false
        )
        
        let url = URL(fileURLWithPath: filePath)
        
        return FileStorage(
            fileManager: fileManager,
            documentsURL: url,
            coder: storageCoder
        )
    }
    
    public static func makeStorageCoder(
        encoder: StorageEncoder = Mocks.Encoder(),
        decoder: StorageDecoder = Mocks.Decoder()
    ) -> StorageCoder {
        StorageCoder(
            encoder: encoder,
            decoder: decoder
        )
    }
}
