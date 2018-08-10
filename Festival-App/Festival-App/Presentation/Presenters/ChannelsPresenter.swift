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
        return MessageService.instance.channels.count
    }
    
    init(view: ChannelsView) {
        self.view = view
    }
    
    func viewDidLoad() {
        observeChannelCreated()
        observeMessageCreated()
    }
    
    func configure(_ itemView: ChannelItemView, at index: Int) {
        let channel = MessageService.instance.channels[index]
        
        itemView.displayName(channel.name)
        itemView.displayReadChannel()
        
        for id in MessageService.instance.unreadChannels {
            if id == channel.id {
                itemView.displayUnreadChannel()
            }
        }
    }
    
    func handleChannelSelection(at index: Int) {
        let channel = MessageService.instance.channels[index]
        MessageService.instance.selectedChannel = channel
        
        if numberOfChannels > 0 {
            MessageService.instance.unreadChannels = MessageService.instance.unreadChannels.filter { $0 != channel.id }
        }
        
        delegate?.channelSelected()
    }
    
    private func observeChannelCreated() {
        SocketService.instance.getChannel { [weak self] (success) in
            guard let weakSelf = self else { return }
            
            if success {
                weakSelf.view?.reloadData()
            } else {
                // TODO
            }
        }
    }
    
    private func observeMessageCreated() {
        SocketService.instance.getMessage { [weak self] (message) in
            guard let weakSelf = self else { return }
            
            if message?.channelID != MessageService.instance.selectedChannel?.id {
                guard let id = message?.channelID else { return }
                MessageService.instance.unreadChannels.append(id)
                weakSelf.view?.reloadData()
            }
        }
    }
}
