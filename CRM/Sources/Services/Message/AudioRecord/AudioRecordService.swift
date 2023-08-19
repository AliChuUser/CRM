//
//  AudioRecordService.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation
import AVFoundation

final class AudioRecordService: NSObject {
    
    enum SilenceState {
        case silenceAfterSpeech(duration: TimeInterval)
        case silenceBeforeSpeech(duration: TimeInterval)
    }
    
    // MARK: - Properties
    
    weak var delegate: AudioRecordServiceDelegate?
    
    // MARK: - Private Properties

    private var permissionGranted: Bool {
        return session.recordPermission == .granted
    }

    private var session: AVAudioSession
    private var recorder: AVAudioRecorder
    private var audioFilePath: URL
    
    private var measuringTimer: Timer?
    private let averagePowerSilentOfSilence: Float = -20
    private let maximumRecordingLength: TimeInterval = 30
    private let timeInterval: TimeInterval = 0.1
    
    private var canceledRecording: Bool = false
    private let maxSilenceBeforeSpeech: TimeInterval = 10
    private let maxSilenceAfterSpeech: TimeInterval = 1
    
    private let recorderSettings = [
        AVFormatIDKey: Int(kAudioFormatLinearPCM),
        AVSampleRateKey: 16000,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]
    
    // MARK: - Init
    
    init(audioSession: AVAudioSession) throws {
        
        self.session = audioSession
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            throw AudioRecordServiceError.notConfigured
        }

        audioFilePath = cachesDirectory.appendingPathComponent("voice.wav")
        recorder = try AVAudioRecorder(url: audioFilePath, settings: recorderSettings)

        super.init()
        recorder.delegate = self
    }
    
    // MARK: - Deinit
    
    deinit {
        measuringTimer?.invalidate()
        measuringTimer = nil
    }
    
    // MARK: - Private Methods

    private func setupSession() throws {
        try session.setCategory(.playAndRecord, mode: .default)
        try session.setActive(true)
    }
    
    private func stopRecording() {
        measuringTimer?.invalidate()
        measuringTimer = nil
        recorder.stop()
    }
    
    private func stopRecordingBySilence() {
        delegate?.didStopByRestrictions()
        stopRecording()
    }
    
    private func updateSilenceState(curentState: SilenceState, recorder: AVAudioRecorder) -> SilenceState {
        
        recorder.updateMeters()

        let averagePower = recorder.averagePower(forChannel: .zero)
        let isSilentNow = averagePower < self.averagePowerSilentOfSilence
        
        switch curentState {
            
        case .silenceBeforeSpeech(let duration) where isSilentNow:
            let silenceDuration = duration + self.timeInterval
            return .silenceBeforeSpeech(duration: silenceDuration)
            
        case .silenceAfterSpeech(let duration) where isSilentNow:
            let silenceDuration = duration + self.timeInterval
            return .silenceAfterSpeech(duration: silenceDuration)
            
        default:
            return .silenceAfterSpeech(duration: 0)
            
        }
        
    }
    
    private func startMeasuring() {
        
        var curentState: SilenceState = .silenceBeforeSpeech(duration: 0)
        measuringTimer?.invalidate()
        measuringTimer = nil
        
        measuringTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] timer in
            
            guard let strongSelf = self else {
                timer.invalidate()
                self?.measuringTimer = nil
                return
            }
            let recorder = strongSelf.recorder
            
            curentState = strongSelf.updateSilenceState(curentState: curentState, recorder: recorder)
            
            switch curentState {
                
            case .silenceBeforeSpeech(let duration) where duration > strongSelf.maxSilenceBeforeSpeech:
                strongSelf.cancelRecordingIfNeeded()
                
            case .silenceAfterSpeech(let duration) where duration > strongSelf.maxSilenceAfterSpeech:
                strongSelf.stopRecordingBySilence()
            
            default: return
                
            }
           
        })
    }
    
}

// MARK: - AVAudioRecorderDelegate
extension AudioRecordService: AVAudioRecorderDelegate {

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        measuringTimer?.invalidate()
        measuringTimer = nil
        
        // В случае отмены записи, игнорируется записанный фаил
        if canceledRecording {
            canceledRecording = false
            return
        }

        guard flag else {
            delegate?.didFailure(with: .recordInterrupted)
            return
        }

        delegate?.didSuccessFileRecorded(with: audioFilePath)

    }
}

// MARK: - AudioRecordServiceProtocol
extension AudioRecordService: AudioRecordServiceProtocol {

    func startRecord() throws {
 
        guard permissionGranted else {
            throw AudioRecordServiceError.permissionNotGranted
        }
        
        try setupSession()
        
        recorder.deleteRecording()
        recorder.prepareToRecord()
        recorder.record(forDuration: maximumRecordingLength)
        
        recorder.isMeteringEnabled = true
        startMeasuring()
    }

    func stopRecord() {
        recorder.stop()
    }
    
    func cancelRecordingIfNeeded() {
        guard recorder.isRecording else { return }
        delegate?.didCancelRecording()
        canceledRecording = true
        stopRecording()
    }
    
}
