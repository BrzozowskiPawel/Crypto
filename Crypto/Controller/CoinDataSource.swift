//
//  CoinDataSource.swift
//  Crypto
//
//  Created by Paweł Brzozowski on 12/04/2022.
//

import Foundation
import UIKit

class CoinDataSource: NSObject, UITableViewDataSource {
    private var coinArray = [Coin]()
    private var coinArrayIndex: Int = 0
    private var coinArraySearchList = [[Coin]]()
    
    func getCoinArrayIndex() -> Int {
        return self.coinArrayIndex
    }
    
    func getCoinArraySearchList() -> [[Coin]] {
        return self.coinArraySearchList
    }
    
    func getCoinArray() -> [Coin] {
        return self.coinArray
    }
    
    func updateCoinArrayIndex(indexVal: Int) {
        self.coinArrayIndex = indexVal
    }
    
    func updateCoinArraySearchList(coinArrList: [[Coin]]) {
        self.coinArraySearchList = coinArrList
    }
    
    func updateCoinArray(array: [Coin]) {
        self.coinArray = array
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.identifier, for: indexPath as IndexPath) as! CoinTableViewCell
        cell.configureCell(withCell: coinArray[indexPath.row])
        return cell
    }
}
