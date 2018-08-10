//
//  MessageService.swift
//  Festival-App
//
//  Created by Octavian on 07/01/2018.
//  Copyright © 2018 Octavian. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var unreadChannels = [String]()

    var usersForChannel = [String: User]()
    
    var selectedChannel : Channel?
    
    func getAllChannels(completion: @escaping CompletionHandler) {
        Alamofire.request(Route.channels, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Header.bearerHeader).responseJSON { [weak self] (response) in
            
            guard let weakSelf = self else { completion(false); return }
            
            if response.result.error == nil {
                weakSelf.clearChannels()
                guard let data = response.data else { completion(false); return }

                do {
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let channel = Channel(json: item)
                            weakSelf.channels.append(channel)
                        }
                        completion(true)
                    }
                } catch {
                    debugPrint(error)
                    completion(false)
                    return
                }
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
                return
            }
        }
    }
    
    func getAllMessagesForChannel(withID id: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(Route.messages)/\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Header.bearerHeader).responseJSON { [weak self] (response) in
            
            guard let weakSelf = self else { completion(false); return }
            
            if response.result.error == nil {
                weakSelf.clearMessages()
                weakSelf.clearUsersForChannel()
                guard let data = response.data else { completion(false); return }
                do {
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let message = Message(json: item)
                            weakSelf.messages.append(message)
                            weakSelf.usersForChannel.updateValue(User(), forKey: message.userID)
                        }
                        completion(true)
                    }
                } catch {
                    debugPrint(error)
                    completion(false)
                    return
                }
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
                return
            }
        }
    }
    
    func clearMessages() {
        messages.removeAll()
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
    func clearUsersForChannel() {
        usersForChannel.removeAll()
    }
}
