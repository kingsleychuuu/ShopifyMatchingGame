//
//  TableViewController.swift
//  ShopifyMatchingGame
//
//  Created by admin on 1/7/20.
//  Copyright © 2020 Kingsley. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var tableViewLabels = ["Columns of Grid", "Number of Matches"]
    var finalColumnSize = 4
    var numberOfMatches = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        registerCells()
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(playButtonTapped))
    }
    
    func registerCells() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cellID")
    }
    
    @objc func playButtonTapped() {
        let viewController = CollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        viewController.numberOfTotalCards = numberOfMatches * 2
        viewController.numberOfColumns = finalColumnSize
        navigationController?.pushViewController(viewController, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! TableViewCell
        cell.textLabel?.text = tableViewLabels[indexPath.row]
        if indexPath.row == 0 {
            cell.detailTextLabel?.text = "\(finalColumnSize)"
        } else {
            cell.detailTextLabel?.text = "\(numberOfMatches)"
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            columnSizeTapped()
        } else {
            matchesTapped()
        }
        
    }
    
    func columnSizeTapped() {
        let alert = UIAlertController(title: "Customize Grid", message: "Select the column size for the grid (default is 4)", preferredStyle: .alert)
        for columnSize in 3...5 {
            alert.addAction(UIAlertAction(title: "\(columnSize)", style: UIAlertAction.Style.default, handler: { action in
                self.finalColumnSize = columnSize
                self.tableView.reloadData()
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func matchesTapped() {
        let alert = UIAlertController(title: "Customize Matches", message: "Select the total matches for the grid (default is 10)", preferredStyle: .alert)
        for matchQuantity in 10...25 {
            if matchQuantity % 5 == 0 {
                alert.addAction(UIAlertAction(title: "\(matchQuantity)", style: UIAlertAction.Style.default, handler: { action in
                    self.numberOfMatches = matchQuantity
                    self.tableView.reloadData()
                }))
            }
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
