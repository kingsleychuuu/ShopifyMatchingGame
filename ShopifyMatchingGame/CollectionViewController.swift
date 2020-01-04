//
//  CollectionViewController.swift
//  ShopifyMatchingGame
//
//  Created by admin on 1/2/20.
//  Copyright © 2020 Kingsley. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var products = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCellRegistration()
        setupJSONData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? CollectionViewCell else { fatalError("Failed to load cell") }
        cell.backgroundColor = .white
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = .zero
        cell.layer.shadowRadius = 3
        cell.title.text = products[indexPath.row].title
        let imageURL = URL(string: products[indexPath.row].image.src)
        do {
            let imageData = try Data(contentsOf: imageURL!)
            cell.image.image = UIImage(data: imageData)
        } catch {
            print("Unable to load data: \(error)")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width/5
        return CGSize(width: width, height: width*1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.transition(with: collectionView.cellForItem(at: indexPath)!, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: { () -> Void in
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            if cell.mysteryLabel.isHidden {
                cell.mysteryLabel.isHidden = false
                cell.image.isHidden = true
                cell.title.isHidden = true
            } else {
                cell.mysteryLabel.isHidden = true
                cell.image.isHidden = false
                cell.title.isHidden = false
            }
            //
        }, completion: nil)
    }
    
    func setupViews() {
        collectionView.backgroundColor = .white
    }
    
    func setupCellRegistration() {
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
    }
    
    func setupJSONData() {
        let url = URL(string: "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            do {
                let str = String(decoding: data, as: UTF8.self)
                let jsonData = str.data(using: .utf8)!
                let jsonResponse = try! JSONDecoder().decode(Response.self, from: jsonData)
                DispatchQueue.main.async {
                    self.products = jsonResponse.products
                    self.collectionView.reloadData()
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

