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
    static let shared = SocketService()
    
    var socket: SocketIOClient
    let manager = SocketManager(socketURL: URL(string: baseURL)!)
    
    override init() {
        socket = manager.defaultSocket
        super.init()
    }
    
    func addChannel(_ channel: Channel, completion: @escaping CompletionHandler) {
        socket.emit(Event.newChannel.rawValue, channel.name, channel.description)
        completion(true)
    }
    
    func getCreatedChannel(completion: @escaping CompletionHandler) {
        
        socket.on(Event.channelCreated.rawValue) { [weak self] (dataArray, ack) in
            print(dataArray)
            
            guard let _ = self else { completion(false); return }
            
            if let channel = Channel(dataArray) {
                MessageService.shared.channels.append(channel)
                completion(true)
            } else {
                completion(false)
                return
            }
        }
    }
    
    func addMessage(body: String, userID: String, channelID: String, username: String, completion: @escaping CompletionHandler) {
        socket.emit(Event.newMessage.rawValue, body, userID, channelID, username)
        completion(true)
    }
    
    func getCreatedMessage(completion: @escaping (_ message: Message?) -> Void) {
        socket.on(Event.messageCreated.rawValue) { [weak self] (dataArray, ack) in
            
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
        
        socket.emit(Event.newLocation.rawValue, location.latitude, location.longitude, location.userID,
                     location.title, location.address, location.description, location.price, location.phone, location.images)
        completion(true)
    }
    
    func deleteLocationWithID(_ id: String, completion: @escaping CompletionHandler) {
        socket.emit(Event.deleteLocation.rawValue, id)
        completion(true)
    }
    
    func updateLocationWithID(_ id: String, newLocation: Location, completion: @escaping CompletionHandler) {
        socket.emit(Event.updateLocation.rawValue, id, newLocation.latitude, newLocation.longitude, newLocation.userID, newLocation.title,
                    newLocation.address, newLocation.description, newLocation.price, newLocation.phone, newLocation.images)
        completion(true)
    }
    
    func getCreatedLocation(completion: @escaping (_ location: Location?) -> Void) {
        socket.on(Event.locationCreated.rawValue) { [weak self] (dataArray, ack) in
            
            guard let _ = self else { completion(nil); return }
            
            if let location = Location(dataArray) {
                completion(location)
            } else {
                completion(nil)
                return
            }
        }
    }
    
    func getDeletedLocation(completion: @escaping (_ location: Location?) -> Void) {
        socket.on(Event.locationDeleted.rawValue) { [weak self] (dataArray, ack) in
            
            guard let _ = self else { completion(nil); return }
            
            if let location = Location(dataArray) {
                completion(location)
            } else {
                completion(nil)
                return
            }
        }
    }
    
    func getUpdatedLocation(completion: @escaping (_ location: Location?) -> Void) {
        socket.on(Event.locationUpdated.rawValue) { [weak self] (dataArray, ack) in
            
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
            socket.off(Event.newChannel.rawValue)
        case .newMessage:
            socket.off(Event.newMessage.rawValue)
        case .newLocation:
            socket.off(Event.newLocation.rawValue)
        case .channelCreated:
            socket.off(Event.channelCreated.rawValue)
        case .messageCreated:
            socket.off(Event.messageCreated.rawValue)
        case .locationCreated:
            socket.off(Event.locationCreated.rawValue)
        case .userTypingUpdate:
            socket.off(Event.userTypingUpdate.rawValue)
        case .deleteLocation:
            socket.off(Event.deleteLocation.rawValue)
        case .updateLocation:
            socket.off(Event.updateLocation.rawValue)
        case .locationDeleted:
            socket.off(Event.locationDeleted.rawValue)
        case .locationUpdated:
            socket.off(Event.locationUpdated.rawValue)
        }
    }
    
    func getTypingUsers(_ completion: @escaping (_ typingUsers: [String: String]?) -> Void) {
        socket.on(Event.userTypingUpdate.rawValue) { [weak self] (dataArray, ack) in
         
            guard let _ = self else { completion(nil); return }
            
            if let typingUsers = dataArray[0] as? [String: String] {
                completion(typingUsers)
            } else {
                completion(nil)
            }
        }
    }

    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
}
