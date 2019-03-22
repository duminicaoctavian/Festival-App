//
//  HomePresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 04/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

private struct Constants {
    static let buyTicketsURL = "https://ultramusicfestival.com/tickets/miami/"
}

class HomePresenter {
    weak var view: HomeView?
    
    init(view: HomeView) {
        self.view = view
    }
    
    func handleBuyTicketsPage() {
        guard let URL = URL(string: Constants.buyTicketsURL) else { return }
        UIApplication.shared.open(URL, options: [:]) { (_) in
        }
    }
}
