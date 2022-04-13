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
    var coinArray = [Coin]()
    private var coinArrayIndex: Int = 0
    private var coinArraySearchList = [[Coin]]()
    private let coinArrayPublishSubject = PublishSubject<[Coin]>()
    private var startedEditingFlag: Bool = false
    
    func bindWithTable(homeView: HomeView, bag: DisposeBag) {
        coinArrayPublishSubject.bind(to: homeView.myTableView.rx.items(cellIdentifier: CoinTableViewCell.identifier, cellType: CoinTableViewCell.self)){
            row, coin , cell in
            cell.configureCell(with: coin)
        }.disposed(by: bag)
    }
    
    func getEditingFlag() -> Bool {
        return startedEditingFlag
    }
    
    func startedEditing() {
        startedEditingFlag = true
    }
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
}
