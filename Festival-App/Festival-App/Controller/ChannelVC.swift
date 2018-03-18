//
//  ChannelVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 18/03/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setSWRevealViewControllerTrailingSpace()
    }
    
    func setSWRevealViewControllerTrailingSpace() {
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }
}
