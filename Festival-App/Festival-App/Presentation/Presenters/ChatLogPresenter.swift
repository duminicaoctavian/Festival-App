//
//  ChatLogPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 10/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class ChatLogPresenter {
    weak var view: ChatLogView?
    
    init(view: ChatLogView) {
        self.view = view
    }
    
    var numberOfMessages: Int {
        return MessageService.shared.messages.count
    }
    var wasFirstLoaded = false
    
    func viewDidLoad() {
        observeNewMessages()
        getChannels()
    }
    
    func viewWillAppear() {
        MessageService.shared.messages.removeAll()
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.view?.reloadData()
        }
    }
    
    func viewWillDisappear() {
        SocketService.shared.removeListener(forEvent: Event.messageCreated)
    }
    
    func sendMessage(withText text: String) {
        guard let channedID = MessageService.shared.selectedChannel?.id else { return }
            
        SocketService.shared.addMessage(body: text, userID: AuthService.shared.user.id, channelID: channedID, username: AuthService.shared.user.username) { [weak self] (success) in
            guard let weakSelf = self else { return }
            
            if success {
                weakSelf.view?.resetInputTextField()
            } else {
                // TODO
            }
        }
    }
    
    private func observeNewMessages() {
        SocketService.shared.getMessage { [weak self] (message) in
            guard let _ = self else { return }
            guard let message = message, let selectedChannelID = MessageService.shared.selectedChannel?.id else { return }
            
            if message.channelID == selectedChannelID {
                MessageService.shared.messages.append(message)
                
                DispatchQueue.main.async { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.view?.reloadData()
                    if weakSelf.numberOfMessages > 0 {
                        weakSelf.view?.scrollToIndex(weakSelf.numberOfMessages - 1)
                    }
                }
            }
        }
    }
    
    private func getChannels() {
        if !wasFirstLoaded {
            view?.startActivityIndicator()
        }
        
        MessageService.shared.getAllChannels { [weak self] (success) in
            guard let weakSelf = self else { return }
            
            if success {
                if MessageService.shared.channels.count > 0 {
                    MessageService.shared.selectedChannel = MessageService.shared.channels[0]
                    weakSelf.updateWithChannel()
                } else {
                    weakSelf.view?.displayNoChannelsAvailable()
                }
            } else {
                // TODO
            }
        }
    }
    
    private func updateWithChannel() {
        if wasFirstLoaded {
            view?.startActivityIndicator()
        }
        view?.hideInputView()
        wasFirstLoaded = true
        
        guard let channelName = MessageService.shared.selectedChannel?.name else { return }
        view?.displayChannelName(channelName)
        getMessages()
    }
    
    private func getMessages() {
        MessageService.shared.messages.removeAll()
        
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.view?.reloadData()
        }
        
        guard let channelID = MessageService.shared.selectedChannel?.id else { return }
        
        MessageService.shared.getAllMessagesForChannel(withID: channelID) { [weak self] (success) in
            guard let weakSelf = self else { return }
            
            if success {
                weakSelf.getAllUsersForCurrentChannel(completion: { [weak self] (success) in
                    guard let weakSelf = self else { return }
                    weakSelf.view?.showInputView()
                    weakSelf.view?.stopActivityIndicator()
                    
                    if success {
                        DispatchQueue.main.async { [weak self] in 
                            guard let weakSelf = self else { return }
                            weakSelf.view?.reloadData()
                            if weakSelf.numberOfMessages > 0 {
                                weakSelf.view?.scrollToIndex(weakSelf.numberOfMessages - 1)
                            }
                        }
                    } else {
                        DispatchQueue.main.async { [weak self] in
                            guard let weakSelf = self else { return }
                            weakSelf.view?.reloadData()
                        }
                    }
                })
            }
        }
    }
    
    private func getAllUsersForCurrentChannel(completion: @escaping CompletionHandler) {
        var count = 0
        
        if MessageService.shared.usersForChannel.count == 0 {
            completion(false)
        }
        
        MessageService.shared.usersForChannel.forEach { (key: String, value: User) in
            
            AuthService.shared.findUserByID(id: key, completion: { [weak self] (user) in
                guard let _ = self else { return }
                guard let user = user else { return }

                MessageService.shared.usersForChannel.updateValue(user, forKey: key)
                count = count + 1
                
                if count == MessageService.shared.usersForChannel.count {
                    completion(true)
                }
            })
        }
    }
}

extension ChatLogPresenter: ChannelsPresenterDelegate {
    func channelSelected() {
        updateWithChannel()
    }
}
