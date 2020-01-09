//
//  TableViewCell.swift
//  ShopifyMatchingGame
//
//  Created by admin on 1/9/20.
//  Copyright © 2020 Kingsley. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
