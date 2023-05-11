//
//  AmplifyCloudFileManager.swift
//
//
//  Created by Suguru Takahashi on 2023/05/11.
//

import Amplify
import AWSS3StoragePlugin
import Foundation
import SampleAppCoreFoundation
import SampleAppDomain

public class AmplifyCloudFileManager: CloudFileManagerProtocol {
    public init() {}

    public func uploadCSVFile() async throws {
        let csvString = "column1,column2,column3\nvalue1,value2,value3\nvalue4,value5,value6"
        let fileNameKey = "sample_\(UUID().uuidString).csv"
        let fileManager = FileManager.default

        do {
            // CSVファイルをキャッシュディレクトリに作成して保存する
            let fileUrl = try fileManager.createCSVFileInCacheDirectory(csvString: csvString, fileName: fileNameKey)
            print("Create: \(fileUrl)")

            // キャッシュディレクトリからS3にアップロードする
            let uploadTask = Amplify.Storage.uploadFile(
                key: "raw/\(fileNameKey)",
                local: fileUrl
            )

            Task {
                for await progress in await uploadTask.progress {
                    print("Progress: \(progress)")
                }
            }
            let data = try await uploadTask.value
            print("Completed: \(data)")

            // アップロード成功後、キャッシュを削除する
            try fileManager.removeItem(at: fileUrl)
            print("Delete: \(fileUrl)")
        } catch {
            throw error
        }
    }
}
