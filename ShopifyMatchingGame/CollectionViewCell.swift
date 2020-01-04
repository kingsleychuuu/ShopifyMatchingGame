//
//  CollectionViewCell.swift
//  ShopifyMatchingGame
//
//  Created by admin on 1/4/20.
//  Copyright © 2020 Kingsley. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var image: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var title: UILabel = {
        var label = UILabel()
        label.text = "wowoasdjfhasdlfjhadfsdfasdasdl"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var mysteryLabel: UILabel = {
        var label = UILabel()
        label.text = "?"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupImageView()
    }
    
    func setupCellConstraints() {
        addSubview(image)
        image.topAnchor.constraint(equalTo: topAnchor).isActive = true
        image.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        image.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        image.heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        image.isHidden = true
        addSubview(title)
        title.topAnchor.constraint(equalTo: image.bottomAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: leftAnchor, constant: 2).isActive = true
        title.rightAnchor.constraint(equalTo: rightAnchor, constant: -2).isActive = true
        title.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        title.isHidden = true
        addSubview(mysteryLabel)
        mysteryLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        mysteryLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        mysteryLabel.isHidden = false
    }
    
    func setupImageView() {
        image.layer.cornerRadius = image.frame.width/2
        image.layer.masksToBounds = true
        image.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
