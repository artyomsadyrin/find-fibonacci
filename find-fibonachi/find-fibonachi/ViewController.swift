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
    
    private var filteredFibonachi = [String]()
    private var numbers = [String]()
    private var N = 19
    private let fibonachiCalculation = FibonachiCalculation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fibonachiTable.dataSource = self
        fibonachiTable.delegate = self
        fiboSearchBar.delegate = self
        numbers = fibonachiCalculation.createFibonachiArray(N)
        filteredFibonachi = numbers
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFibonachi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FibonachiTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FibonachiTableViewCell else {
            fatalError("The dequeued cell is not an instance of ListTableViewCell.")
        }
        let number = filteredFibonachi[indexPath.row]
        cell.resultLabel.text = number
        return cell
    }
    
    func refreshFibonachiTable() {
        filteredFibonachi = numbers
        fibonachiTable.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            refreshFibonachiTable()
            return
        }
        if let positionOfNumber = Int(searchText) {
            if positionOfNumber > 0 {
                
                self.filteredFibonachi = [fibonachiCalculation.getFibonachiNumber(positionOfNumber)]
            }
            else {
                filteredFibonachi = [""]
            }
        }
        else {
            filteredFibonachi = [""]
        }
        fibonachiTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItemPosition = numbers.count - 1
        if indexPath.row == lastItemPosition {
            for index in (lastItemPosition + 1)...(lastItemPosition + 21) {
                let newFibonachiNumber = fibonachiCalculation.getFibonachiNumber(index)
                numbers.append(newFibonachiNumber)
            }
            refreshFibonachiTable()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.endEditing(true)
        searchBar.resignFirstResponder()
        refreshFibonachiTable()
    }
    
    
}
