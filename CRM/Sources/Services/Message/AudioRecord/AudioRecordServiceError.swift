//
//  AudioRecordServiceError.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation

enum AudioRecordServiceError: Error {
    case notConfigured
    case permissionNotGranted
    case permissionDenied
    case failedToSetup
    case recordInterrupted
}
