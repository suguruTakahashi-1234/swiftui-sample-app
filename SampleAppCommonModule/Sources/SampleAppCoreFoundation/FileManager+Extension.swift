//
//  File.swift
//
//
//  Created by Suguru Takahashi on 2023/05/11.
//

import Foundation

public extension FileManager {
    func createCSVFileInCacheDirectory(csvString: String, fileName: String) throws -> URL {
        let cacheDirectory = try url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
        return fileURL
    }
}
