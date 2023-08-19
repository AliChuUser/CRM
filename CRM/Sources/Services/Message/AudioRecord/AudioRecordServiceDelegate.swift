//
//  AudioRecordServiceDelegate.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation

protocol AudioRecordServiceDelegate: AnyObject {
    
    func didSuccessFileRecorded(with url: URL)
    func didFailure(with error: AudioRecordServiceError)
    func didStopByRestrictions()
    func didCancelRecording()
    
}
