//
//  ChatVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 18/03/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class ChatWindowVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var typingLbl: UILabel!
    @IBOutlet weak var messageTextBox: UITextField!
    
    //Variables
    var isTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
    
        messageTextBox.delegate = self
        
        setUpSWRevealViewController()
    
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatWindowVC.handleTap))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatWindowVC.channelSelected(_:)), name: NotificationName.channelSelected, object: nil)
        
        SocketService.instance.getMessage { (newMessage) in
            
            if newMessage?.channelID == MessageService.instance.selectedChannel!.id && AuthService.instance.isLoggedIn {
                MessageService.instance.messages.append(newMessage!)
                
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }
        
        SocketService.instance.getTypingUsers { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            var names = ""//the names of who are typing
            var numberOfTypers = 0
        
            for (typingUser, channel) in typingUsers! {
                if typingUser != AuthService.instance.user.username && channel == channelId {
                    if names == "" {
                        names = typingUser
                    } else {
                        names = "\(names), \(typingUser)"
                    }
                    numberOfTypers += 1
                }
            }
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn == true {
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                self.typingLbl.text = "\(names) \(verb) typing a message ..."
                
            } else {
                self.typingLbl.text = ""
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MessageService.instance.messages.removeAll()
        tableView.reloadData()
    }
    
    func setUpSWRevealViewController() {
        chatBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            // get channels
            onLoginGetMessages()
        } else {
            channelNameLbl.text = "Please Log In"
            tableView.reloadData()
        }
    }
    
    func onLoginGetMessages() {
        MessageService.instance.getAllChannels { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0] //set first channel as selected one
                    self.updateWithChannel()
                } else {
                    self.channelNameLbl.text = "No channels yet!"
                }
            }
        }
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.name ?? ""
        channelNameLbl.text = "#\(channelName)"
        getMessages()
    }
    
    func getMessages() {
        MessageService.instance.messages.removeAll()
        tableView.reloadData()
        startSpinner()
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        MessageService.instance.getAllMessagesForChannel(withId: channelId) { (success) in
            if success {
                self.getUsers(completion: { (success) in
                    if success {
                        self.stopSpinner()
                        self.tableView.reloadData()
                        if MessageService.instance.messages.count > 0 {
                            let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                            self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: true)
                        }
                    } else {
                        self.stopSpinner()
                        self.tableView.reloadData()
                    }
                })
                
            }
        }
    }
    
    func getUsers(completion: @escaping CompletionHandler) {
        var count = 0
        if MessageService.instance.usersForChannel.count == 0 {
            completion(false)
        }
        MessageService.instance.usersForChannel.forEach { (arg: (key: String, value: User)) in
            
            let (key, value) = arg
            AuthService.instance.findUserByID(id: key, completion: { (user) in
                if user?.id != nil {
                    MessageService.instance.usersForChannel.updateValue(user!, forKey: key)
                    count = count + 1
                }
                if count == MessageService.instance.usersForChannel.count {
                    completion(true)
                }
            })
        }
    }
    
    @IBAction func sendMessagePressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channedId = MessageService.instance.selectedChannel?.id else { return }
            guard let text = messageTextBox.text else { return }
            
            let message = Message(userID: AuthService.instance.user.id, channelID: channedId, body: text, username: AuthService.instance.user.username)
            
            SocketService.instance.addMessage(message, completion: { (success) in
                if success {
                    self.messageTextBox.text = ""
                    self.messageTextBox.resignFirstResponder()
                    SocketService.instance.socket?.emit("stopType", AuthService.instance.user.username, channedId)
                }
            })
        }
    }
    
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        guard let channedId = MessageService.instance.selectedChannel?.id else { return }
        if messageTextBox.text == "" {
            isTyping = false
            SocketService.instance.socket?.emit("stopType", AuthService.instance.user.username, channedId)
        } else {
            if isTyping == false {
                SocketService.instance.socket?.emit("startType", AuthService.instance.user.username, channedId)
            }
            isTyping = true
        }
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func startSpinner() {
        LoadingView.startLoading()
    }
    
    func stopSpinner() {
        LoadingView.stopLoading()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        SocketService.instance.removeListener(forEvent: Event.messageCreated)
    }
}

extension ChatWindowVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.identifier, for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
}

extension ChatWindowVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

