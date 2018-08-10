//
//  ChatLogViewController.swift
//  Festival-App
//
//  Created by Duminica Octavian on 18/03/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

private struct Constants {
    static let estimatedRowHeight: CGFloat = 80.0
    static let noChannelsAvailable = "No channels yet!"
}

class ChatLogViewController: UIViewController {
    
    lazy var presenter: ChatLogPresenter = {
        return ChatLogPresenter(view: self)
    }()

    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var textInputView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlideMenu()
        addGestures()
        view.bindToKeyboard()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }

    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @IBAction func sendMessageTapped(_ sender: Any) {
        guard let text = messageTextField.text else { return }
        presenter.sendMessage(withText: text)
    }

    @IBAction func onBackTapped(_ sender: Any) {
        navigateToHomeScreen()
    }
}

extension ChatLogViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfMessages
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.className, for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ChatLogViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

extension ChatLogViewController: ChatLogView {
    func hideInputView() {
        textInputView.isHidden = true
    }
    
    func showInputView() {
        textInputView.isHidden = false
    }
    
    func resetInputTextField() {
        messageTextField.text = ""
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func startActivityIndicator() {
        LoadingView.startLoading()
    }
    
    func stopActivityIndicator() {
        LoadingView.stopLoading()
    }
    
    func setupSlideMenu() {
        chatButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), for: .touchUpInside)
        if let channelsViewController = revealViewController().rightViewController as? ChannelsViewController {
            channelsViewController.presenter.delegate = presenter
        }
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
    }
    
    func setupTableViewAutomaticCellDimension() {
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func navigateToHomeScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func scrollToIndex(_ index: Int) {
        let endIndex = IndexPath(row: index, section: 0)
        tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
    }
    
    func displayChannelName(_ name: String) {
        channelNameLabel.text = "#\(name)"
    }
    
    func displayNoChannelsAvailable() {
        channelNameLabel.text = Constants.noChannelsAvailable
    }
}

