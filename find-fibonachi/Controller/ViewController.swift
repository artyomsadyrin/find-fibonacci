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
    
    @IBOutlet weak var operationCompleteActivityIndicatorView: UIActivityIndicatorView!
    private var filteredFibonachi = [String]()
    private var numbers = [String]()
    private var N = 19
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fibonachiTable.dataSource = self
        fibonachiTable.delegate = self
        fiboSearchBar.delegate = self
        numbers = FibonachiCalculation.createFibonachiArray(firstIndex: 0, lastIndex: 19)
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
    
    private func startLoadingActivityIndicator() {
        operationCompleteActivityIndicatorView.isHidden = false
        operationCompleteActivityIndicatorView.startAnimating()
    }
    
    private func stopLoadingActivityIndicator() {
        operationCompleteActivityIndicatorView.isHidden = true
        operationCompleteActivityIndicatorView.stopAnimating()
    }
    
    func refreshFibonachiTable() {
        filteredFibonachi = numbers
        stopLoadingActivityIndicator()
        fibonachiTable.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            refreshFibonachiTable()
            return
        }
        if let positionOfNumber = Int(searchText) {
            if positionOfNumber > 0 {
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    DispatchQueue.main.async {
                        self?.startLoadingActivityIndicator()
                    }
                    self?.filteredFibonachi = [FibonachiCalculation.getFibonachiNumber(positionOfNumber)]
                    DispatchQueue.main.async {
                        self?.stopLoadingActivityIndicator()
                        self?.fibonachiTable.reloadData()
                    }
                }
            }
            else {
                filteredFibonachi = [""]
            }
        }
        else {
            filteredFibonachi = [""]
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItemPosition = numbers.count - 1
        if indexPath.row == lastItemPosition {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                DispatchQueue.main.async {
                    self?.startLoadingActivityIndicator()
                }
                self?.numbers += FibonachiCalculation.createFibonachiArray(firstIndex: lastItemPosition + 1, lastIndex: lastItemPosition + 21)
                DispatchQueue.main.async {
                    self?.refreshFibonachiTable()

                }
            }
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
