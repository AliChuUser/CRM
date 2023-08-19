//
//  NLPService.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation
import Networking

enum NLPServiceError: Error, LocalizedError {
    case serviceError
    
    var localizedDescription: String {
        switch self {
        case .serviceError:
            return "NLPService error"
        }
    }
}

final class NLPService {
    
    private let url = URL(string: "wss://vpstest2.online.av.ru:443/vps/")!
    private let userID = "123123123123"
    private let userChannel = "AV"
    private let vpsToken = "CHWtM45npQhy6bXSFR4PIeLXFCMJ3Jj9"
    
    private var client: WebSocketClient<NLPMessage>?
    
    var onError: ((Error) -> Void)?
    var onMessage: ((NLPMessage) -> Void)?
    
    func sendPing() {
        client?.sendPing()
    }
    
    func sendMessage(_ message: NLPMessage, completion: @escaping (() -> Void)) {
        guard let client = client else {
            completion()
            onError?(NLPServiceError.serviceError)
            return
        }
        
        guard client.isConnected else {
            connect { [weak self] in
                guard let self = self else {
                    completion()
                    return
                }
                self.sendMessage(message, completion: {
                    completion()
                })
            }
            return
        }
        
        print("SENDING:\n\(message)\n")
        client.send(message: message) { voiceResult in
            switch voiceResult {
            case .success(_):
                completion()
                return
            case .failure(let error):
                completion()
                self.onError?(error)
            }
        }
    }
    
    func sendMessages(_ messages: [NLPMessage], completion: @escaping (() -> Void)) {
        guard let client = client else {
            onError?(NLPServiceError.serviceError)
            completion()
            return
        }
        
        guard client.isConnected else {
            connect { [weak self] in
                guard let self = self else {
                    completion()
                    return
                }
                self.sendMessages(messages, completion: {
                    completion()
                })
            }
            return
        }
        
        let id = messages.first?.messageID ?? 0
        
        DispatchQueue.global(qos: .background).async {
            let group = DispatchGroup()
            
            messages.forEach { message in
                var message = message
                message.messageID = id
                group.enter()
                print("SENDING:\n\(message)\n")
                client.send(message: message) { voiceResult in
                    switch voiceResult {
                    case .success(_):
                        group.leave()
                        return
                    case .failure(let error):
                        self.onError?(error)
                        group.leave()
                    }
                }
            }
            group.wait()
            DispatchQueue.main.async(execute: {
                completion()
            })
        }
    }
    
    func connect(completion: @escaping () -> Void) {
        let config = NLPConfiguration(url: url)
        let client = WebSocketClient<NLPMessage>(configuration: config)
        self.client = client
        
        client.onError = { [weak self] error in
            guard let self = self else { return }
            self.onError?(error)
            return
        }
        
        client.onConnection = {
            completion()
        }
        
        client.onMessage = { [weak self] message in
            self?.onMessage?(message)
        }
        
        client.openConnection()
    }
    
    func disconnect() {
        client?.closeConnection()
    }
}

