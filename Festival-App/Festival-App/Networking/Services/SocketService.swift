//
//  SocketService.swift
//  Smack
//
//  Created by Octavian on 07/01/2018.
//  Copyright © 2018 Octavian. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static let instance = SocketService()
    
    var socket: SocketIOClient?
    
    override init() {
        super.init()
        guard let URL = URL(string: baseURL) else { return }
        let manager = SocketManager(socketURL: URL)
        self.socket = manager.defaultSocket
    }
    
    func addChannel(_ channel: Channel, completion: @escaping CompletionHandler) {
        socket?.emit(Event.newChannel.rawValue, channel.name, channel.description)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        
        socket?.on(Event.channelCreated.rawValue) { [weak self] (dataArray, ack) in
            
            guard let _ = self else { completion(false); return }
            
            if let channel = Channel(dataArray) {
                MessageService.instance.channels.append(channel)
                completion(true)
            } else {
                completion(false)
                return
            }
        }
    }
    
    func addMessage(_ message: Message, completion: @escaping CompletionHandler) {
        socket?.emit(Event.newMessage.rawValue, message.body, message.userID,
                     message.channelID, message.username)
        completion(true)
    }
    
    func getMessage(completion: @escaping (_ message: Message?) -> Void) {
        socket?.on(Event.messageCreated.rawValue) { [weak self] (dataArray, ack) in
            
            guard let _ = self else { completion(nil); return }
            
            if let message = Message(dataArray) {
                completion(message)
            } else {
                completion(nil)
                return
            }
        }
    }
    
    func addLocation(_ location: Location, completion: @escaping CompletionHandler) {
        
        socket?.emit(Event.newLocation.rawValue, location.latitude, location.longitude, location.userID,
                     location.title, location.address, location.description, location.images)
        completion(true)
    }
    
    func getLocation(completion: @escaping (_ location: Location?) -> Void) {
        socket?.on(Event.locationCreated.rawValue) { [weak self] (dataArray, ack) in
            
            guard let _ = self else { completion(nil); return }
            
            if let location = Location(dataArray) {
                completion(location)
            } else {
                completion(nil)
                return
            }
        }
    }
    
    func removeListener(forEvent event: Event) {
        switch event {
        case .newChannel:
            socket?.off(Event.newChannel.rawValue)
        case .newMessage:
            socket?.off(Event.newMessage.rawValue)
        case .newLocation:
            socket?.off(Event.newLocation.rawValue)
        case .channelCreated:
            socket?.off(Event.channelCreated.rawValue)
        case .messageCreated:
            socket?.off(Event.messageCreated.rawValue)
        case .locationCreated:
            socket?.off(Event.locationCreated.rawValue)
        case .userTypingUpdate:
            socket?.off(Event.userTypingUpdate.rawValue)
        }
    }
    
    func getTypingUsers(_ completion: @escaping (_ typingUsers: [String: String]?) -> Void) {
        socket?.on(Event.userTypingUpdate.rawValue) { [weak self] (dataArray, ack) in
         
            guard let _ = self else { completion(nil); return }
            
            if let typingUsers = dataArray[0] as? [String: String] {
                completion(typingUsers)
            } else {
                completion(nil)
            }
        }
    }

    func establishConnection() {
        socket?.connect()
    }
    
    func closeConnection() {
        socket?.disconnect()
    }
}
