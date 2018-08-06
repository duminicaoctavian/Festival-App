//
//  NewsViewModel.swift
//  Festival-App
//
//  Created by Octavian Duminica on 06/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class NewsViewModel: NSObject {
    override init() {
        super.init()
    }
}

extension NewsViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsService.instance.newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = NewsService.instance.newsItems[indexPath.row]
        
        switch item.type {
        case .image:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PictureNewsCell.identifier, for: indexPath) as? PictureNewsCell {
                cell.item = item
                return cell
            }
        case .video:
            if let cell = tableView.dequeueReusableCell(withIdentifier: VideoNewsCell.identifier, for: indexPath) as? VideoNewsCell {
                cell.item = item
                return cell
            }
        }
        
        return UITableViewCell()
    }
}




