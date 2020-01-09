//
//  HeaderView.swift
//  ShopifyMatchingGame
//
//  Created by admin on 1/7/20.
//  Copyright © 2020 Kingsley. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    var scoreLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Score: 0"
        return label
    }()
    
    var flipLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Flips: 0"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(scoreLabel)
        scoreLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        scoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(flipLabel)
        flipLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        flipLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
