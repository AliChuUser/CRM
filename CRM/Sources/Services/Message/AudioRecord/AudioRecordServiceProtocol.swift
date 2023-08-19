//
//  AudioRecordServiceProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation

protocol AudioRecordServiceProtocol: AnyObject {

    var delegate: AudioRecordServiceDelegate? { get set }

    func startRecord() throws
    func stopRecord()
    func cancelRecordingIfNeeded()
}
