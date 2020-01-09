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
    var totalCells = [Product]()
    var flippedCells = [CollectionViewCell]()
    var numberOfColumns = 4
    var numberOfPairsToMatch = 2
    var numberOfTotalCards = 10
    var scoreCount = 0 {
        didSet {
            let indexPath = IndexPath(row: 0, section: 0)
            configureHeader(view: collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexPath) as! HeaderView)
            if scoreCount == products.count/2 {
                userHasWon()
            }
        }
    }
    var flipCount = 0 {
        didSet {
            let indexPath = IndexPath(row: 0, section: 0)
            configureHeader(view: collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexPath) as! HeaderView)
        }
    }

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
        let width = view.bounds.width/CGFloat(numberOfColumns+1)
        return CGSize(width: width, height: width*1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID", for: indexPath) as? HeaderView else { fatalError("u dun goofed")}
            configureHeader(view: view)
        return view
    }
    
    func configureHeader(view: HeaderView) {
        view.scoreLabel.text = "Score: \(scoreCount)"
        view.flipLabel.text = "Flips: \(flipCount)"
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        if !cell.mysteryLabel.isHidden {
            UIView.transition(with: cell, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: {
                cell.mysteryLabel.isHidden = true
                cell.image.isHidden = false
                cell.title.isHidden = false
            }) { (finished: Bool) in
                self.cellsHaveBeenFlipped(cell)
            }
        }
    }
    
    func cellsHaveBeenFlipped(_ cell: CollectionViewCell) {
        flippedCells.append(cell)
        if flippedCells.count == numberOfPairsToMatch {
            flipCount += 1
            if flippedCells[0].title.text == flippedCells[1].title.text {
                for cell in flippedCells {
                    cell.isUserInteractionEnabled = false
                }
                scoreCount += 1
                flippedCells.removeAll()
            } else {
                for cell in flippedCells {
                    UIView.transition(with: cell, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: { () -> Void in
                        cell.mysteryLabel.isHidden = false
                        cell.image.isHidden = true
                        cell.title.isHidden = true
                    }) { (finished: Bool) in
                        self.flippedCells.removeAll()
                    }
                }
            }
        }
    }
    
    func userHasWon() {
        let alert = UIAlertController(title: "Congratulations!", message: "You have won :D", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func resetGame() {
        for cell in (collectionView.visibleCells as? [CollectionViewCell])! {
            cell.mysteryLabel.isHidden = false
            cell.image.isHidden = true
            cell.title.isHidden = true
            cell.isUserInteractionEnabled = true
        }
        scoreCount = 0
        flipCount = 0
        flippedCells.removeAll()
        var newProducts = totalCells.shuffled().prefix(numberOfTotalCards/2)
        newProducts += newProducts
        products = newProducts.shuffled()
        collectionView.reloadData()
    }
    
    func setupCardGrid(_ json: Response) {
        totalCells = json.products.shuffled()
        var firstTenProducts = totalCells.prefix(numberOfTotalCards/2)
        firstTenProducts += firstTenProducts
        products = firstTenProducts.shuffled()
        collectionView.reloadData()
    }
    
    func setupViews() {
        title = "Matching Game"
        collectionView.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetGame))
    }
    
    func setupCellRegistration() {
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID")
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
                    self.setupCardGrid(jsonResponse)
                }
            }
        }
        task.resume()
    }
    
    
}

