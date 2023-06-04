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
import SwiftProtobuf

public class AmplifyCloudFileManager: CloudFileManagerProtocol {
    public init() {}

    public func uploadCSVFile() async throws {
        var protoTest1: ProtoTest = .init()
        protoTest1.id = 1
        protoTest1.name = "hoge1"
        protoTest1.timestamp = Google_Protobuf_Timestamp(date: Date())

        var protoTest2: ProtoTest = .init()
        protoTest2.id = 1
        protoTest2.name = "hoge1"
        protoTest2.timestamp = Google_Protobuf_Timestamp(date: Date())

        let protoTestList: [ProtoTest] = [protoTest1, protoTest2]
        var data = Data()
        do {
            // try を入れる必要があるので forEach は使えない
            for protoTest in protoTestList {
                try data.append(protoTest.serializedData())
            }
        } catch {
            print("Failed to serialize messages: \(error)")
        }

        let key = "raw/\(UUID().uuidString)"
        print(key)
        print(protoTest1)
        try print(protoTest1.serializedData())
        print(protoTest2)
        try print(protoTest2.serializedData())
        print(data)

        do {
            let uploadTask = Amplify.Storage.uploadData(
                key: key,
                data: data
            )

            Task {
                for await progress in await uploadTask.progress {
                    print("Progress: \(progress)")
                }
            }

            let data = try await uploadTask.value
            print("Completed: \(data)")
        } catch {
            throw error
        }
    }
}
