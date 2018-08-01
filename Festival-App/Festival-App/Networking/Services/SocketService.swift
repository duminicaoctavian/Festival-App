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
    let manager = SocketManager(socketURL: URL(string: BASE_URL)!)
    var socket: SocketIOClient
    
    override init() {
        socket = manager.defaultSocket
        super.init()
    }

    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDesc = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let userName = AuthService.instance.userName
        
        socket.emit("newMessage", messageBody, userId, channelId, userName)
        completion(true)
    }
    
    func getChatMessage(completion: @escaping (_ newMessage: Message) -> Void) {
        socket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else { return }
            guard let userId = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let id = dataArray[4] as? String else { return }
            guard let timeStamp = dataArray[5] as? String else { return }
            
            let newMessage = Message(message: msgBody, userName: userName, channelId: channelId, id: id, timeStamp: timeStamp, userId: userId)
            
            completion(newMessage)
        }
    }
    
    func addLocation(location: Location, completion: @escaping CompletionHandler) {
        print(location)
        socket.emit("newLocation", location.latitude, location.longitude, location.userID, location.title, location.address, location.description, location.images)
        completion(true)
    }
    
    func getMapLocation(completion: @escaping (_ newLocation: Location) -> Void) {
        socket.on("locationCreated") { (dataArray, ack) in
            guard let id = dataArray[0] as? String else { return }
            guard let latitude = dataArray[1] as? Double else { return }
            guard let longitude = dataArray[2] as? Double else { return }
            guard let userId = dataArray[3] as? String else { return }
            guard let title = dataArray[4] as? String else { return }
            guard let address = dataArray[5] as? String else {return }
            guard let description = dataArray[6] as? String else { return }
            guard let images = dataArray[7] as? [String] else {return }
            
            let newLocation = Location(_id: id, latitude: latitude, longitude: longitude, userID: userId, title: title, address: address, description: description, price: 25, images: images)
            
            completion(newLocation)
        }
    }
    
    func disableGetChatListener() {
        socket.off("messageCreated")
    }
    
    func getTypingUsers(_ completionHandler: @escaping (_ typingUsers: [String: String]) -> Void) {
        socket.on("userTypingUpdate") { (dataArray, ack) in
            print(dataArray)
            guard let typingUsers = dataArray[0] as? [String: String] else { return }
            completionHandler(typingUsers)
        }
    }
}
