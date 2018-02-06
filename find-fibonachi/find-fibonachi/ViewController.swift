//
//  ViewController.swift
//  find-fibonachi
//
//  Created by Artsiom Sadyryn on 1/30/18.
//  Copyright © 2018 Artsiom Sadyryn. All rights reserved.
//

import Foundation
import UIKit
import BigInt

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var fibonachiTable: UITableView!
    
    @IBOutlet weak var fiboSearchBar: UISearchBar!
    
    var searchActive: Bool = false
    var filteredFibo = [String]()
    var numbers = [BigInt]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fibonachiTable.dataSource = self
        fibonachiTable.delegate = self
        fiboSearchBar.delegate = self
        numbers = createFiboArray(100)
        filteredFibo = numbers.map( { String($0) } )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFibo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FibonachiTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FibonachiTableViewCell else {
            fatalError("The dequeued cell is not an instance of ListTableViewCell.")
        }
        let number = filteredFibo[indexPath.row]
        cell.resultLabel.text = number
        return cell
    }
    
    func clear() {
        filteredFibo = numbers.map( { String($0) } )
        fibonachiTable.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            clear()
            return
        }
        let positionOfNumber = Int(searchText)
        filteredFibo = [String(getFibonachi(positionOfNumber!))]
        
        fibonachiTable.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.endEditing(true)
        searchBar.resignFirstResponder()
        clear()
    }
    
    func getFibonachi(_ n: Int) -> BigInt {
        var num1: BigInt = 0
        var num2: BigInt = 1
        for _ in 1..<n {
            num1 += num2
            num2 = num1 - num2
        }
        return num1
    }
    
    func createFiboArray(_ index: Int) -> [BigInt] {
        var temp = [BigInt]()
        for i in 0..<index {
            temp.append(getFibonachi(i + 1))
        }
        return temp
    }
    
}
