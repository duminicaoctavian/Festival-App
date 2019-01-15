//
//  ChannelsPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 10/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol ChannelsPresenterDelegate: class {
    func channelSelected()
}

class ChannelsPresenter {
    weak var view: ChannelsView?
    weak var delegate: ChannelsPresenterDelegate?
    
    var numberOfChannels: Int {
        return MessageService.shared.channels.count
    }
    
    init(view: ChannelsView) {
        self.view = view
    }
    
    func viewDidLoad() {
        observeChannelCreated()
        observeMessageCreated()
    }
    
    func configure(_ itemView: ChannelItemView, at index: Int) {
        let channel = MessageService.shared.channels[index]
        
        itemView.displayName(channel.name)
        itemView.displayReadChannel()
        
        for id in MessageService.shared.unreadChannels {
            if id == channel.id {
                itemView.displayUnreadChannel()
            }
        }
    }
    
    func handleChannelSelection(at index: Int) {
        let channel = MessageService.shared.channels[index]
        MessageService.shared.selectedChannel = channel
        
        if numberOfChannels > 0 {
            MessageService.shared.unreadChannels = MessageService.shared.unreadChannels.filter { $0 != channel.id }
        }
        
        delegate?.channelSelected()
    }
    
    private func observeChannelCreated() {
        SocketService.shared.getCreatedChannel { [weak self] (success) in
            guard let _ = self else { return }
            
            if success {
                DispatchQueue.main.async { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.view?.reloadData()
                }
            } else {
                // TODO
            }
        }
    }
    
    private func observeMessageCreated() {
        SocketService.shared.getCreatedMessage { [weak self] (message) in
            guard let _ = self else { return }
            
            if message?.channelID != MessageService.shared.selectedChannel?.id {
                guard let id = message?.channelID else { return }
                MessageService.shared.unreadChannels.append(id)
                DispatchQueue.main.async { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.view?.reloadData()
                }
            }
        }
    }
}
