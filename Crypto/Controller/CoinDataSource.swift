//
//  CoinDataSource.swift
//  Crypto
//
//  Created by Paweł Brzozowski on 12/04/2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CoinDataSource: NSObject {
    let coinArrayPublishSubject = PublishSubject<[Coin]>()
    var coinArray = [Coin]()
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
        self.coinArrayPublishSubject.onNext(array)
    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return coinArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.identifier, for: indexPath as IndexPath) as! CoinTableViewCell
//        cell.configureCell(with: coinArray[indexPath.row])
//        return cell
//    }
}
