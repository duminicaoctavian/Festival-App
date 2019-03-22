//
//  MyLineupViewController.swift
//  Festival-App
//
//  Created by Octavian Duminica on 24/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

private struct Constants {
    static let headerHeight: CGFloat = 50.0
    static let headerLabelHeight: CGFloat = 30.0
    static let headerLabelFont = UIFont(name: "Avenir-Medium", size: 19)
}

class MyLineupViewController: UIViewController {
    
    lazy var presenter: MyLineupPresenter = {
        return MyLineupPresenter(view: self)
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @IBAction func onBackTapped(_ sender: Any) {
        navigateToLineupScreen()
    }
    
    private func makeLabel(with frame: CGRect, at index: Int) -> UILabel {
        let label = UILabel()
        label.text = "Day \(index)"
        label.textColor = .white
        label.font = Constants.headerLabelFont
        return label
    }
    
    private func setupHeaderLabelConstraints(forView firstView: UIView, relativeTo secondView: UIView) {
        firstView.translatesAutoresizingMaskIntoConstraints = false
        firstView.centerXAnchor.constraint(equalTo: secondView.centerXAnchor).isActive = true
        firstView.centerYAnchor.constraint(equalTo: secondView.centerYAnchor).isActive = true
    }
}

extension MyLineupViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = presenter.artistsCount(forDay: section) else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyLineupCell.className, for: indexPath) as? MyLineupCell else {
            return UITableViewCell()
        }
        let section = indexPath.section
        presenter.configure(cell, at: indexPath.row, with: section)
        return cell
    }
    
}

extension MyLineupViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if presenter.artistsCount(forDay: section) != nil {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: Constants.headerHeight))
            headerView.backgroundColor = .clear
            
            let headerLabel = makeLabel(with: headerView.frame, at: section + 1)
            headerView.addSubview(headerLabel)
            setupHeaderLabelConstraints(forView: headerLabel, relativeTo: headerView)
            
            return headerView
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if presenter.artistsCount(forDay: section) != nil {
            return Constants.headerHeight
        } else {
            return 0
        }
    }
}

extension MyLineupViewController: MyLineupView {

    func navigateToLineupScreen() {
        navigationController?.popViewController(animated: true)
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
}
