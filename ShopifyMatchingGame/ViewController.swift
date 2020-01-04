//
//  ViewController.swift
//  ShopifyMatchingGame
//
//  Created by admin on 1/2/20.
//  Copyright © 2020 Kingsley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var response:Response?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        let url = URL(string: "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            do {
                let str = String(decoding: data, as: UTF8.self)
                let jsonData = str.data(using: .utf8)!
                let jsonResponse = try! JSONDecoder().decode(Response.self, from: jsonData)
                
                self.response = jsonResponse

            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }


}

