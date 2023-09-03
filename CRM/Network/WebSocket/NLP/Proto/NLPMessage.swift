//
//  NLPMessage.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

extension NLPMessage: WebSocketMessageProtocol {

    public var binaryData: Data? {
        guard let binaryData = try? serializedData() else { return nil }
        var size = Int32(binaryData.count).littleEndian
        var sizeData = Data(bytes: &size, count: MemoryLayout.size(ofValue: size))
        sizeData.append(binaryData)
        return sizeData
    }

    public init?(binaryData: Data) {
        var size = Int32(binaryData.count).littleEndian
        var sizeData = Data(bytes: &size, count: MemoryLayout.size(ofValue: size))
        var serializedData = binaryData
        serializedData.removeFirst(sizeData.count)
        do {
            try self.init(serializedData: serializedData)
        } catch {
            return nil
        }
    }
}
