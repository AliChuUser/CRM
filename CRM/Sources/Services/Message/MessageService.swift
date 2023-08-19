//
//  MessageService.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation
import AVFoundation
import Networking
import UIKit

enum RecordState {
    case unavailable
    case idle
    case recording
    case processing
}

class MessageService {
    
    private let url = URL(string: "wss://vpstest2.online.av.ru:443/vps/")!
    private var userID: Int {
        get {
            let ud = UserDefaults.standard
            let storedValue = ud.integer(forKey: "NLPUserId")
            if storedValue == 0 {
                return 35000
            }
            return storedValue
        }
        set {
            let ud = UserDefaults.standard
            ud.set(newValue, forKey: "NLPUserId")
        }
    }
    private let userChannel = "AV"
    private let vpsToken = "CHWtM45npQhy6bXSFR4PIeLXFCMJ3Jj9"
    private let chunkSize = 32768
    
    private var nlpService: NLPService!
    private var audioRecordService: AudioRecordService!
    
    private (set) var currentMessageId: Int64 = 123456
    private (set) var chunkCount: Int = 0
    
    private (set) var recordState: RecordState = .unavailable {
        didSet {
            updateRecordState()
        }
    }
    
    public var onStateChanged: ((RecordState) -> Void)?
    public var onMessage: ((_ text: String, _ id: Int64, _ isLast: Bool, _ isFromUser: Bool) -> Void)?
    
    init(onStateChanged: ((RecordState) -> Void)?,
         onMessage: ((_ text: String, _ id: Int64, _ isLast: Bool, _ isFromUser: Bool) -> Void)?,
         completion: @escaping () -> Void) {
        
        self.onMessage = onMessage
        self.onStateChanged = onStateChanged
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.nlpService?.sendPing()
        }
        
        setupRecording {
            completion()
        }
    }
    
    private func setupRecording(completion: @escaping () -> Void) {
        let audioSession = AVAudioSession.sharedInstance()
        let nlpService = NLPService()

        let deviceMessage = makeDeviceMessage()
        let settingsMessage = makeSettingsMessage()
        
        nlpService.onError = { [weak self] error in
            print("NLP error: \(error)")
            self?.recordState = .idle//.unavailable
        }
        nlpService.onMessage = { [weak self] message in
            self?.processMessage(message)
        }
        nlpService.connect(completion: { [weak self] in
            guard let self = self else { return }
            guard let audioRecordService = try? AudioRecordService(audioSession: audioSession) else {
                self.recordState = .unavailable
                print("Error: AudioRecordService unavailable")
                completion()
                return
            }
            audioRecordService.delegate = self
            
            self.nlpService = nlpService
            self.audioRecordService = audioRecordService
            
            print("Sending device info\n")
            nlpService.sendMessage(deviceMessage, completion: {
                print("Device info sent")
                print("Sending settings\n")
                nlpService.sendMessage(settingsMessage, completion: {
                    print("Settings sent")
                    DispatchQueue.main.async {
                        self.recordState = .idle
                        completion()
                    }
                })
            })
        })
    }
    
    func sendTextMessage(text: String, completion: @escaping () -> Void) {
        currentMessageId += 1
        var message = NLPMessage()
        message.last = 1
        message.messageID = currentMessageId
        message.text.data = text
        message.userID = "\(self.userID)"
        message.userChannel = self.userChannel
        message.vpsToken = self.vpsToken
        
        nlpService.sendMessage(message, completion: {
            completion()
        })
    }
    
    func startRecording() {
        recordState = .recording
        do {
            try audioRecordService.startRecord()
        } catch AudioRecordServiceError.permissionNotGranted {
            AVAudioSession.sharedInstance().requestRecordPermission { response in
                if response {
                    self.startRecording()
                } else {
                    print("startRecording failed")
                    self.recordState = .unavailable
                }
            }
        } catch {
            print("startRecording error: \(error)")
            self.recordState = .unavailable
        }
    }
    
    func stopRecording() {
        recordState = .processing
        audioRecordService.stopRecord()
    }
    
    private func processMessage(_ message: NLPMessage) {
        recordState = .idle
        if message.messageName == "OPEN_CHAT" || message.status.code != 0 {
            userID += 1
            nlpService.disconnect()
            self.setupRecording {
                
            }
        }
        let isUserMessage = message.messageName == "STT"
        let id = message.messageID * (isUserMessage ? 1 : -1)
        onMessage?(message.text.data, id, message.last == 1, isUserMessage)
    }
    
    private func updateRecordState() {
        onStateChanged?(recordState)
    }
    
    deinit {
        nlpService.disconnect()
        audioRecordService.cancelRecordingIfNeeded()
    }
    
    private func makeDeviceMessage() -> NLPMessage {
        currentMessageId += 1
        var deviceInfo = NLPDevice()
        deviceInfo.clientType = ""
        deviceInfo.channel = ""
        deviceInfo.channelVersion = ""
        deviceInfo.platformName = "iOS"
        deviceInfo.platformVersion = "14"
        
        var deviceMessage = NLPMessage()
        deviceMessage.userID = "\(self.userID)"
        deviceMessage.userChannel = userChannel
        deviceMessage.messageID = currentMessageId
        deviceMessage.last = 1
        deviceMessage.vpsToken = vpsToken
        deviceMessage.device = deviceInfo
        
        return deviceMessage
    }
    
    private func makeSettingsMessage() -> NLPMessage {
        currentMessageId += 1
        var settingsInfo = NLPSettings()
        settingsInfo.dubbing = -1
        settingsInfo.echo = -1
        settingsInfo.sttAutoStop = -1
        
        var settingsMessage = NLPMessage()
        settingsMessage.userID = "\(self.userID)"
        settingsMessage.userChannel = userChannel
        settingsMessage.messageID = currentMessageId
        settingsMessage.last = 1
        settingsMessage.vpsToken = vpsToken
        settingsMessage.settings = settingsInfo
        
        return settingsMessage
    }
}

extension MessageService: AudioRecordServiceDelegate {
    
    func didSuccessFileRecorded(with url: URL) {
        sendVoice(form: url)
    }
    
    func didFailure(with error: AudioRecordServiceError) {
        print("MessageService Audio record error")
        recordState = .idle//.unavailable
        audioRecordService.stopRecord()
        recordState = .idle
    }
    
    func didStopByRestrictions() {
        print("MessageService Stopped because of silence")
        audioRecordService.stopRecord()
        recordState = .idle
    }
    
    func didCancelRecording() {
        print("MessageService Recording cancelled")
        audioRecordService.stopRecord()
        recordState = .idle
    }
}

extension MessageService {
    
    private func sendVoice(form fileUrl: URL) {
        print("Sending voice\n")
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            let data: Data
            do {
                data = try Data(contentsOf: fileUrl)
            } catch {
                print("sendVoice(form fileUrl: URL) failed: \(error)")
                self.recordState = .idle//.unavailable
                return
            }
            
            self.splitData(data, chunkSize: self.chunkSize, onComplete: { chunks in
                DispatchQueue.main.async {
                    self.chunkCount = chunks.count
                    self.sendVoiceData(chunks)
                }
            })
        }
    }
    
    private func sendVoiceData(_ chunks: [Data]) {
        currentMessageId += 1
        
        let messages: [NLPMessage] = chunks.indices.map { i in
            let isLast = i == chunks.count - 1
            
            var message = NLPMessage()
            message.messageID = currentMessageId
            message.last = isLast ? 1 : -1
            message.voice.data = chunks[i]
            message.userID = "\(self.userID)"
            message.userChannel = self.userChannel
            message.vpsToken = self.vpsToken
            
            return message
        }
        
        nlpService.sendMessages(messages, completion: {
            print("Voice sent\n")
        })
    }
    
    private func splitData(_ data: Data, chunkSize: Int, onComplete: ([Data]) -> Void) {
        
        data.withUnsafeBytes { (u8Ptr: UnsafePointer<UInt8>) in
            var chunks: [Data] = []
            let mutRawPointer = UnsafeMutableRawPointer(mutating: u8Ptr)
            let uploadChunkSize = chunkSize
            let totalSize = data.count
            var offset = 0
            
            while offset < totalSize {
                let chunkSize = offset + uploadChunkSize > totalSize ? totalSize - offset : uploadChunkSize
                let chunk = Data(bytes: mutRawPointer + offset, count: chunkSize)

                offset += chunkSize
                chunks.append(chunk)
            }
            onComplete(chunks)
        }
        
    }
}

