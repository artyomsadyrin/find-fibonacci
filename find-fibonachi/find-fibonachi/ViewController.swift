//
//  ViewController.swift
//  find-fibonachi
//
//  Created by Artsiom Sadyryn on 1/30/18.
//  Copyright © 2018 Artsiom Sadyryn. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var fibonachiTable: UITableView!
    
    @IBOutlet weak var fiboSearchBar: UISearchBar!
    
    var searchActive: Bool = false
    var filteredFibo = [String]()
    var numbers = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fibonachiTable.dataSource = self
        fibonachiTable.delegate = self
        fiboSearchBar.delegate = self
        numbers = createFiboArray(50)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "FibonachiTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FibonachiTableViewCell else {
            fatalError("The dequeued cell is not an instance of ListTableViewCell.")
        }
        let number = numbers[indexPath.row]
        cell.resultLabel.text = String(number)
        return cell
        
    }

    func getFibonachi(_ n: Int) -> Int {
        var num1 = 0
        var num2 = 1
        for _ in 1..<n {
            num1 += num2
            num2 = num1 - num2
        }
        return num1
    }
    
    func createFiboArray(_ index: Int) -> [Int] {
        var temp = [Int]()
        for i in 0..<index {
            temp.append(getFibonachi(i + 1))
        }
        return temp
    }
    
}
