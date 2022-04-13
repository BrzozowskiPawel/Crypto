//
//  ViewController.swift
//  Crypto
//
//  Created by Paweł Brzozowski on 27/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, UITableViewDelegate {

    private let APIservice = APIService()
    private var homeView = HomeView()
    private var coinDataSource = CoinDataSource()
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIservice.delegate = self
        APIservice.fetchData()
        
        homeView.segmentedControllDelegate = self
        homeView.myTableView.rx.setDelegate(self).disposed(by: bag)
        homeView.myTableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.identifier)
        coinDataSource.coinArrayPublishSubject.bind(to: homeView.myTableView.rx.items(cellIdentifier: CoinTableViewCell.identifier, cellType: CoinTableViewCell.self)){
            row, coin , cell in
            cell.configureCell(with: coin)
        }.disposed(by: bag)
        
    }
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
}

extension HomeViewController: SortingSegmentedControllDelegate {
    func didTypeCoinName(text: String) {
        var coinArray = coinDataSource.getCoinArray()
        var coinArraySearchList = coinDataSource.getCoinArraySearchList()
        var coinArrayIndex = coinDataSource.getCoinArrayIndex()
        
        if coinArraySearchList.count == 0 {
            coinArraySearchList.append(coinArray)
        }
        if coinArrayIndex > text.count {
            coinArray = coinArraySearchList[text.count]
            coinArraySearchList.remove(at: coinArrayIndex)
            coinArrayIndex = text.count
        } else {
            coinArray = coinArray.filter({ coin in
                return coin.name.lowercased().contains(text.lowercased())
            })
            coinArrayIndex += 1
            coinArraySearchList.append(coinArray)
        }
        
        coinDataSource.updateCoinArray(array: coinArraySearchList[coinArrayIndex])
        coinDataSource.updateCoinArraySearchList(coinArrList: coinArraySearchList)
        coinDataSource.updateCoinArrayIndex(indexVal: coinArrayIndex)
        
    }
    
    func didSelectSegement(segmentIndex: Int) {
        var coinArray = coinDataSource.getCoinArray()
        switch segmentIndex {
        case 0:
            coinArray = coinArray.sorted(by: {$0.quote.USD.price > $1.quote.USD.price})
        case 1:
            coinArray = coinArray.sorted(by: {$0.quote.USD.price < $1.quote.USD.price})
        case 2:
            coinArray = coinArray.sorted(by: {$0.quote.USD.percent_change_24h > $1.quote.USD.percent_change_24h})
        case 3:
            coinArray = coinArray.sorted(by: {$0.quote.USD.percent_change_24h < $1.quote.USD.percent_change_24h})
        case 4:
            coinArray = coinArray.sorted(by: {$0.quote.USD.percent_change_7d > $1.quote.USD.percent_change_7d})
        case 5:
            coinArray = coinArray.sorted(by: {$0.quote.USD.percent_change_7d < $1.quote.USD.percent_change_7d})
        default:
            print("NONE")
        }
        
        coinDataSource.updateCoinArray(array: coinArray)
    }
}

extension HomeViewController: APIProtocol {
    func coinArrayDidRetrieve(_ retrievedCoinArray: [Coin]) {
        coinDataSource.updateCoinArray(array: retrievedCoinArray)
    }
}


