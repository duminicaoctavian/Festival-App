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
        return MessageService.instance.messages.count
    }
    var wasFirstLoaded = false
    
    func viewDidLoad() {
        observeNewMessages()
        getChannels()
    }
    
    func viewWillAppear() {
        MessageService.instance.messages.removeAll()
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.view?.reloadData()
        }
    }
    
    func viewWillDisappear() {
        SocketService.instance.removeListener(forEvent: Event.messageCreated)
    }
    
    func sendMessage(withText text: String) {
        guard let channedID = MessageService.instance.selectedChannel?.id else { return }
            
        SocketService.instance.addMessage(body: text, userID: AuthService.instance.user.id, channelID: channedID, username: AuthService.instance.user.username) { [weak self] (success) in
            guard let weakSelf = self else { return }
            
            if success {
                weakSelf.view?.resetInputTextField()
            } else {
                // TODO
            }
        }
    }
    
    private func observeNewMessages() {
        SocketService.instance.getMessage { [weak self] (message) in
            guard let _ = self else { return }
            guard let message = message, let selectedChannelID = MessageService.instance.selectedChannel?.id else { return }
            
            if message.channelID == selectedChannelID {
                MessageService.instance.messages.append(message)
                
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
        
        MessageService.instance.getAllChannels { [weak self] (success) in
            guard let weakSelf = self else { return }
            
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
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
        
        guard let channelName = MessageService.instance.selectedChannel?.name else { return }
        view?.displayChannelName(channelName)
        getMessages()
    }
    
    private func getMessages() {
        MessageService.instance.messages.removeAll()
        
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.view?.reloadData()
        }
        
        guard let channelID = MessageService.instance.selectedChannel?.id else { return }
        
        MessageService.instance.getAllMessagesForChannel(withID: channelID) { [weak self] (success) in
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
        
        if MessageService.instance.usersForChannel.count == 0 {
            completion(false)
        }
        
        MessageService.instance.usersForChannel.forEach { (key: String, value: User) in
            
            AuthService.instance.findUserByID(id: key, completion: { [weak self] (user) in
                guard let _ = self else { return }
                guard let user = user else { return }

                MessageService.instance.usersForChannel.updateValue(user, forKey: key)
                count = count + 1
                
                if count == MessageService.instance.usersForChannel.count {
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
